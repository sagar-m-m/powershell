# This PowerShell script saves the appsettings of all Azure Function Apps
# under a specific subscription to separate JSON files in a specified folder.

# Replace the sub ID below with the appropriate subscription ID.
$subId = "XXXXX-XXXXX-XXXXX-XXXXX"

# Sign in to Azure and set the default subscription.
Write-Host "Logging in"
$login = az login
Write-Host "Setting default sub"
$setSub = az account set -s $subId
Write-Host "Current default is"
$account = az account show | ConvertFrom-Json
Write-Host $account.name

# Query the Azure Resource Graph to get all Function Apps under the specified subscription.
$functionApps = Search-AzGraph -Query "resources | where type == 'microsoft.web/sites' and subscriptionId == '$subId' and kind contains 'functionapp'| order by ['name'] asc"

# Loop through each Function App and save its appsettings to a JSON file.
foreach ($functionApp in $functionApps) {
    $name = $functionApp.name
    Write-Host "Saving appsettings for $name "
    az webapp config appsettings list --name $name --resource-group $functionApp.resourceGroup > $PSScriptRoot\Appsettings\$name.json
    Write-Host "Saved appsettings for $name "
}
