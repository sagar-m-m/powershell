# Set the Resource Group name
$rg = "<resourceGroupName>"
# Get a list of all deployments which are in 'Running' state
$runningList = az deployment group list --resource-group $rg --filter "provisioningState eq 'Running'" | ConvertFrom-Json

# Check if there are any deployments still in 'Running' state
while ($null -ne $runningList) {
    # Display the list of deployments still running
    Write-Host "Below deployments are still running"
    foreach ($runningItem in $runningList) {
        # Display the name of the deployment
        $runningItem.name
        # Display the duration the deployment has been running for
        Write-Host "Deployment run duration"
        $runningItem.properties.duration
    }
    # Wait for 60 seconds before checking again
    Write-Host "Waiting for above deployment to complete"
    Start-Sleep -Seconds 60
    $runningList = az deployment group list --resource-group $rg --filter "provisioningState eq 'Running'" | ConvertFrom-Json
}

# Display a message once all deployments are complete
Write-Host "All Deployments are complete"
