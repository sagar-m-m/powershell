$apiManagementName = "<apiManagementName>";
$apiManagementResourceGroupName = "<apiManagementResourceGroupName>";
$apimApiName = "<apimApiName>"
$today = Get-Date -Format FileDateTime

$apis = az apim api operation list --resource-group $apiManagementResourceGroup --service-name $apiManagementName --api-id $apimApiName | ConvertFrom-Json
$intArray = 1..999
foreach ($api in $apis) {  
    
    $apiSplit = ($api.name).Split("-")
    if ($intArray -contains $apiSplit[-1]  ) {       
       
        $api.name >> "$PSScriptRoot/$apiManagementName-$apimApiName-duplicatelist-$today.txt"
        Write-Host "Deleting" $api.name
        az apim api operation delete --resource-group $apiManagementResourceGroup --service-name $apiManagementName --api-id $apimApiName --operation-id $api.name
        Write-Host "Deleted" $api.name
    }   
}
