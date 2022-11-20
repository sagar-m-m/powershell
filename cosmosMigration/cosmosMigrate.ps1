[CmdletBinding()]
param (

    [Parameter(Mandatory)]
    [string]$SourceRGName,
    
    [Parameter(Mandatory)]
    [string]$SourceDBAccountName,
   
    [Parameter(Mandatory)]
    [string]$DestinationRGName,
    
    [Parameter(Mandatory)]
    [string]$DestinationDBAccountName,

    [Parameter()]
    [string]$sleepTime = "60",

    [Parameter()]
    [switch]$migratedata,   

    [Parameter()]
    [switch]$provisioned,

    [Parameter()]
    [string]$CollectionThroughput = "1000"

    
        
)

$sourceDbList = Get-AzCosmosDBSqlDatabase -ResourceGroupName "$SourceRGName" -AccountName "$SourceDBAccountName"

foreach ($sourceDb in $sourceDbList) {

    $sourceDbName = $sourceDb.Name

    #Get Source DB account connection string
    Write-Host "Get Source DB account connection string"
    $sourceConnectionString = Get-AzCosmosDBAccountKey -ResourceGroupName $SourceRGName `
        -Name $SourceDBAccountName `
        -Type "ConnectionStrings" `
        -ErrorAction Stop
 

    #Get Target DB account connection string
    Write-Host "Get Target DB account connection string"
    $targetConnectionString = Get-AzCosmosDBAccountKey -ResourceGroupName $DestinationRGName `
        -Name $DestinationDBAccountName `
        -Type "ConnectionStrings" `
        -ErrorAction Stop

    Write-Verbose "<<<<<<<<<<<<<  Source db  >>>>>>>>>>>>>>> " 
  
    $sourceConnectionString = $sourceConnectionString.'Primary Read-Only SQL Connection String' + "Database=$sourceDbName;"
    Write-Verbose "<<<<<<<<<<<<<  source Connection String  >>>>>>>>>>>>>>> $sourceConnectionString "
    Write-Host "Source Connection string saved..."

    $targetConnectionString = $targetConnectionString.'Primary SQL Connection String' + "Database=$sourceDbName;"
    Write-Verbose "<<<<<<<<<<<<<  target Connection String >>>>>>>>>>>>>>> $targetConnectionString "
    Write-Host "Target Connection string saved..."

    #Check is target already has db , if not create new
    $CheckDb = Get-AzCosmosDBSqlDatabase -ResourceGroupName $DestinationRGName `
        -AccountName $DestinationDBAccountName `
        -ErrorAction Stop


    if ($CheckDb.Name -contains $sourceDbName) {

        Write-Host " $sourceDbName already exists "
        
    }
    else {
        Write-Host "Creating DB" $sourceDbName

        if ($provisioned.IsPresent) {

            $newdb = New-AzCosmosDBSqlDatabase -AccountName $DestinationDBAccountName `
                -Name $sourceDbName `
                -ResourceGroupName $DestinationRGName `
                -AutoscaleMaxThroughput $CollectionThroughput `
                -ErrorAction Stop            
            

        }
        else {

            $newdb = New-AzCosmosDBSqlDatabase -AccountName $DestinationDBAccountName `
                -Name $sourceDbName `
                -ResourceGroupName $DestinationRGName `
                -ErrorAction Stop
        }
    

        
        Write-Host " Created DB $sourceDbName "
        Write-Verbose "<<<<<<<<<<<<<  new db >>>>>>>>>>>>>>>  $newdb "
        Start-Sleep -Seconds 60 
    }

    
    $azContext = Get-AzContext
    $SubID = $azContext.Subscription.Id
    $azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
    $profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
    $token = $profileClient.AcquireAccessToken($azContext.Subscription.TenantId)
    $authHeader = @{
        'Content-Type'  = 'application/json'
        'Authorization' = 'Bearer ' + $token.AccessToken
    }


    #get list of containers in source
    $ContainersUri = "https://management.azure.com/subscriptions/$SubID/resourceGroups/$SourceRGName/providers/Microsoft.DocumentDB/databaseAccounts/$SourceDBAccountName/sqlDatabases/$sourceDbName/containers?api-version=2021-10-15"
    $sourceContainerList = Invoke-RestMethod -Uri $ContainersUri -Method Get -Headers $authHeader 
    foreach ($Coll in $sourceContainerList.value) {
        $collValue = $sourceContainerList.value.Get($sourceContainerList.value.IndexOf($Coll)).name
        $CollPath = $sourceContainerList.value.Get($sourceContainerList.value.IndexOf($Coll)).properties.resource.partitionkey.paths

        #get list of containers in Destination
        $conts = Get-AzCosmosDBSqlContainer -AccountName $DestinationDBAccountName -DatabaseName $sourceDbName -ResourceGroupName $DestinationRGName
        $conts = $conts.Name

        #Create source containers in target if not exists 
        if (($null -ne $conts ) -and $conts.Contains($collValue) ) {

            Write-Warning "Container $CollValue already exists skipping creation...."      
     
        }
        else {
            
      
            Write-Host "Creating container $CollValue..."
            $newContainer = New-AzCosmosDBSqlContainer -AccountName $DestinationDBAccountName -DatabaseName $sourceDbName -ResourceGroupName $DestinationRGName -Name $collValue -PartitionKeyPath $CollPath -PartitionKeyKind Hash -ErrorAction Stop
            Write-Host "Created container $CollValue..."
            Write-Verbose "<<<<<<<<<<<<<  new container >>>>>>>>>>>>>>>  $newContainer "
            Start-Sleep -Seconds $sleepTime
      
        }
  
        if ($migratedata.IsPresent) {

            #Start migrating data
            Write-Host "Starting Migration of $collValue"
            Write-Host "Starting Migration of sproc"
            $sourceSprocs = Get-AzCosmosDBSqlStoredProcedure -AccountName "$SourceDBAccountName" -ResourceGroupName "$SourceRGName" -DatabaseName "$sourceDbName" -ContainerName "$collValue" 
            foreach ($sourceSproc in $sourceSprocs) {

                $sprocName = $sourceSproc.Resource.Id
                $sprocBody = $sourceSproc.Resource.Body
                $deleteDestinationSproc = Remove-AzCosmosDBSqlStoredProcedure -ResourceGroupName "$DestinationRGName" -AccountName "$DestinationDBAccountName" -DatabaseName "$sourceDbName" -ContainerName "$collValue" -Name "$sprocName" 
                $newDestinationSproc = New-AzCosmosDBSqlStoredProcedure -AccountName $DestinationDBAccountName -ResourceGroupName $DestinationRGName -DatabaseName $sourceDbName -ContainerName $collValue -Name $sprocName -Body "$sprocBody"
                Write-Host "Created sproc $sprocName in $collValue container in $sourceDbName db "
            }
           
            Write-Host "Starting Migration of data"

            Start-Process -Wait -PassThru -NoNewWindow -FilePath "./dt.exe" -ArgumentList "/ProgressUpdateInterval:00:00:05 /s:DocumentDB /s.ConnectionString:$sourceConnectionString /s.Collection:$collValue /s.InternalFields /t:DocumentDB /t.ConnectionString:$targetConnectionString /t.Collection:$collValue /t.PartitionKey:$CollPath /t.UpdateExisting" 
                
            Write-Host "Migration completed for  $collValue"  

            
            
        }

     
    }
}
