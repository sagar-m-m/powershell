# PowerShell Azure Deployment Monitoring Script

## Overview

This PowerShell script monitors the status of deployments running in a specified Azure resource group. It checks for all deployments that are in 'Running' state and continues to monitor until all deployments are complete.

## Prerequisites

To use this script, you need the following:
- Azure PowerShell Module
- Azure account credentials with permission to view and manage the specified resource group

## Usage

1. Set the value `resourceGroupName` to the name of the Azure Resource Group that you want to monitor.
2. Run the PowerShell script in your preferred execution environment.

### Usage in Azure Release Pipelines

You can also use this PowerShell script in your Azure Release Pipelines to monitor deployments. Here's how you can do it:

1. In your Azure Release Pipeline, add a PowerShell task and specify the appropriate Azure Subscription.
2. Copy and paste the PowerShell script into the Script box.
3. Save and run the Release Pipeline.

The PowerShell task will execute the script to monitor deployments in the specified Resource Group. If all deployments are complete, the Release Pipeline will continue. If there are still running deployments, the Release Pipeline will wait for the specified duration before checking again.

## Example Output

While running, the script displays the following information for each deployment still in the 'Running' state:
- The name of the deployment
- The duration the deployment has been running for

```
Below deployments are still running
Deployment1
Deployment run duration: PT4M22.2757385S
Deployment2
Deployment run duration: PT3M51.6560269S
Waiting for above deployment to complete

Below deployments are still running
Deployment1
Deployment run duration: PT5M22.3941675S
Deployment2
Deployment run duration: PT4M51.674586S
Waiting for above deployment to complete
```

Once all deployments are complete, the script displays the following message:

```
All deployments are complete
```

## Contributing

If you find any issues with this script, please feel free to submit an issue or a pull request.
