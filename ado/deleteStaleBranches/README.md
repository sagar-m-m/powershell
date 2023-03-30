# PowerShell Script to Delete Stale Branches in Azure DevOps

This PowerShell script helps in deleting stale branches in a repository on Azure DevOps. A "stale" branch refers to a branch that has not been modified for a specific period (determined by the user). Use this script to keep your repository tidy, and get rid of useless branches.

## Prerequisites

Before you start using the script, make sure of the following prerequisites:

* Your system should have the `az` Azure command-line interface installed. Don't have it? Get it from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli).
* You should have appropriate permissions to manage your repositories in Azure DevOps.
* Your system should have PowerShell installed. Don't have it? Get it from [here](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1).

## 🚀 Configuration

Before executing the script, you need to fill in the following variables at the top of the file:

* `$project`: Name of the project which has the repository that needs managing.
* `$repository`: Name of the repository that needs managing.
* `$organization`: URL of your Azure DevOps organization.
* `$excludeBranches`: An array of branch names that should be excluded from deletion. For example, `@("develop","master","qa")`.
* `$daysDeleteBefore`: Number of days after which a branch is considered "stale" and can be deleted.

By default, the script runs in dry-run mode, meaning no branches are actually deleted. To disable dry-run mode, unset the `IS_DRY_RUN` environment variable.

## Running the Script 🏃‍♂️

To run the script, open a PowerShell terminal, navigate to the directory containing the script file, and execute the following command:

```powershell
.\remove-staleBranches.ps1
```

The script gives the progress updates in the terminal as it works, including the number of branches fetched, the number of stale branches found, and the name, ID, and status of each branch deleted.

## Notes 📝

* Use this script with caution. Once a branch is deleted, it cannot be recovered. 🔍
* Check that you have set the `$excludeBranches` array correctly before running the script to ensure that you don't delete any vital branches. 🛑
* It is recommended to do thorough testing and user validation of this script before using it on a production environment. 🙅‍♂️
* This script may take quite some time to run, depending on the number of branches in the repository, the size of their commit histories, and the complexity of their associated objects. ☕
* You can use Azure DevOps pipelines or other automation tools to schedule and run this script regularly. 🕒

## Credits 💡

Aamer Sadiq initially wrote a script similar to this. For the original script and its usage, you can visit their blog post at https://aamersadiq.github.io/2021/Delete-stale-branches-in-Azure-DevOps/. I would like to appreciate Aamer for sharing their work and making it available to the community. 👏
