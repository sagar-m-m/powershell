# PowerShell Script to Delete Stale Branches in Azure DevOps

This PowerShell script automates the process of deleting stale branches in a specified repository on Azure DevOps. A "stale" branch is one that has not been modified for a certain number of days determined by the user.

## Prerequisites

Before running this script, ensure that the following requirements are met:

* You have the `az` Azure command-line interface installed locally. If you don't have it, you can download and install it from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli).
* You have appropriate permissions to manage repositories in your Azure DevOps organization.
* You have PowerShell installed on your system. If you don't have it already, you can download and install it from [here](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1).

## Configuration

Before running the script, you need to specify the following variables at the top of the file:

* `$project`: The name of the project containing the repository to manage.
* `$repository`: The name of the repository to manage.
* `$organization`: The URL of the Azure DevOps organization.
* `$excludeBranches`: An array of branch names to exclude from deletion. For example, `@("develop","master","qa")`.
* `$daysDeleteBefore`: The number of days before a branch is considered "stale" and subject to deletion.

By default, the script runs in dry-run mode, meaning no branches are actually deleted. To disable dry-run mode, unset the `IS_DRY_RUN` environment variable.

## Running the Script

To run the script, open a PowerShell terminal and navigate to the directory containing the script file. Then, execute the following command:

```powershell
.\remove-staleBranches.ps1
```

The script will output information about its progress in the terminal as it works, including the number of branches fetched, the number of stale branches found, and the name, ID, and status of each branch deleted.

## Notes

* Use caution when running this script. Once a branch is deleted, it cannot be recovered.
* Make sure that you set the `$excludeBranches` array correctly before running the script to ensure that you don't delete any important branches.
* This script is not recommended for use in a production environment without thorough testing and user validation.
* This script may take some time to run, depending on the number of branches in the repository, the size of their commit histories, and the complexity of their associated objects.
* This script can be scheduled and run at regular intervals using Azure DevOps pipelines or other automation tools.

## Credits

This script was adapted from a similar script originally written by Aamer Sadiq. To learn more about the original script and its usage, please visit their blog post at https://aamersadiq.github.io/2021/Delete-stale-branches-in-Azure-DevOps/. I would like to express my gratitude to Aamer for sharing their work and making it available to the community.
