# Auto-Tag and Create Branch :rocket:

This PowerShell script allows you to automatically create a tag and a branch in Azure DevOps from the latest commit in a specified branch.

## Setup :wrench:

Before you can use the script, you'll need to replace the placeholders with your own values:

- `<organization-name>`: the name of your Azure DevOps organization.
- `<project-name>`: the name of your Azure DevOps project.
- `<repository-name>`: the name of your Azure DevOps repository.
- `<source-branch>`: the name of the branch to use as the source for the tag and the branch.
- `<target-branch>`: the name of the new branch to create.
- `<tag-name>`: the name of the tag to create.
- `<tag-message>`: the message to include in the tag.

You'll also need to replace `<PAT>` with a Personal Access Token (PAT) that has the appropriate permissions to create tags and branches in your Azure DevOps repository.

## Usage :rocket:

To use the script, simply run it in a PowerShell environment. The script will automatically create a tag and a branch in Azure DevOps based on the latest commit in the specified source branch.

### :pushpin: Prerequisites

Before you run the script, you'll need the following:

- A valid Azure DevOps account with appropriate permissions to create tags and branches in the repository. You can refer to the [official documentation](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/create-organization?view=azure-devops) to create an Azure DevOps account and organization.
- PowerShell installed on your local machine. You can download PowerShell from the [official website](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7.1).

### :zap: Running the Script

1. Open a PowerShell environment.
2. Replace the placeholders with your own values in the script.
3. Run the script by typing the name of the script file followed by Enter.

## Example :bulb:

```powershell
# Replace the placeholders with your own values
$organization = "<organization-name>"
$project = "<project-name>"
$repo = "<repository-name>"
$sourceBranch = "<source-branch>"
$targetBranch = "<target-branch>"
$adoUrl = "https://dev.azure.com/$organization/$project"
$tag = "<tag-name>"
$tagMessage = "<tag-message>"
$PAT = '<PAT>'

# ... rest of the script ...
```

## Troubleshooting :warning:

If you encounter any issues while running the script, here are some common solutions:

- **Error: "The term 'Invoke-RestMethod' is not recognized as the name of a cmdlet..."**: This error occurs when the `Invoke-RestMethod` cmdlet is not recognized by your PowerShell environment. You can fix this by importing the `Microsoft.PowerShell.Utility` module by running `Import-Module Microsoft.PowerShell.Utility` in your PowerShell environment.
- **Error: "The remote server returned an error: (401) Unauthorized."**: This error occurs when the Personal Access Token (PAT) that you've specified does not have the appropriate permissions to create tags and branches in the repository. Make sure the PAT has the appropriate permissions and try again.
- **Error: "The remote server returned an error: (404) Not Found."**: This error occurs when the specified repository, organization, or project does not exist in Azure DevOps. Make sure the names are spelled correctly and try again.


## FAQ :question:

### What is a Personal Access Token (PAT)?

A Personal Access Token (PAT) is a security token that you can use to authenticate with Azure DevOps. You'll need to create a PAT with the appropriate permissions to create tags and branches in your repository. You can refer to the [official documentation](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops) to learn how to create a PAT in Azure DevOps.

### Can I use this script with Git repositories hosted outside of Azure DevOps?

No, this script is specifically designed to work with Git repositories hosted in Azure DevOps. If you're working with a Git repository hosted outside of Azure DevOps, you'll need to use a different tool or script to create tags and branches.

### What permissions do I need to create tags and branches in Azure DevOps?

To create tags and branches in Azure DevOps, you'll need the appropriate permissions in your Azure DevOps account. You can refer to the [official documentation](https://docs.microsoft.com/en-us/azure/devops/repos/git/tagging?view=azure-devops&tabs=visual-studio#create-and-manage-tags) to learn more about the permissions required to create tags and branches in Azure DevOps.

### How can I customize the script to meet my specific needs?

If you need to customize the script to meet your specific needs, you can modify the variables in the script to change the behavior of the script. You can also refer to the [official documentation](https://docs.microsoft.com/en-us/rest/api/azure/devops/git/?view=azure-devops-rest-6.1) to learn more about the Azure DevOps REST API and customize the script accordingly.

