# Assign values to variables for Azure API Management service, subscription, function app, and resource groups
$apimName = ""; # Azure API Management service name
$apimRg = ""; # Azure API Management service resource group
$apimApiName = "" # Azure API Management API name
$subId = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx" # Subscription ID
$functionAppRg = "" # Function App resource group
$functionAppName = "" # Function App name

# Set the context to the subscription ID
Set-AzContext -Subscription $subId

# Retrieve the Azure context and profile
$azContext = Get-AzContext
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)

# Acquire an access token and set the authorization header
$token = $profileClient.AcquireAccessToken($azContext.Subscription.TenantId)
$authHeader = @{
   'Content-Type'='application/json'
   'Authorization'='Bearer ' + $token.AccessToken
}

# Retrieve the HTTP triggers from the function app and filter by type
$restUri = "https://management.azure.com/subscriptions/$subId/resourceGroups/$functionAppRg/providers/Microsoft.Web/sites/$functionAppName/functions?api-version=2022-03-01"
$response = Invoke-RestMethod -Uri $restUri -Method Get -Headers $authHeader 
$httpTriggers = $response.value.properties | Where-Object { $_.config.bindings.type -eq "httpTrigger"  }

# Create an API Management context and retrieve the APIs
$apimContext = New-AzApiManagementContext -ResourceGroupName $apimRg  -ServiceName $apimName
$apis = Get-AzApiManagementOperation -Context $apimContext -ApiId $apimApiName

# Iterate through the HTTP triggers and delete the corresponding operations in API Management
foreach ($httpTrigger in $httpTriggers) {
   $apiOprs = $apis  | Where-Object{$_.Name -eq $httpTrigger.name}
    Write-Host "Name of function app is" $functionAppName
    Write-Host "Name of operation is" $httpTrigger.name
    foreach ($apiOpr in $apiOprs) {             
          
            Write-Host "Deleting" $apiOpr.OperationId        
            Remove-AzApiManagementOperation -Context $apimContext -ApiId $apimApiName -OperationId $apiOpr.OperationId -ErrorAction Stop
            Write-Host "Deleted" $apiOpr.OperationId        
    }
}
