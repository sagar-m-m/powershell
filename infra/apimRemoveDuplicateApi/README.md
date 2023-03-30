# Remove Duplicate APIs Script

This script is designed to identify and delete duplicate API operation entries within a specified API in an Azure API Management instance.

## Prerequisites

- Azure CLI installed and logged in
- PowerShell

## Usage

1. Clone or download the repository to your local machine:

```
git clone https://github.com/your_username/remove-apim-duplicate-apis.git
```

2. Navigate to the directory containing the script:

```
cd remove-apim-duplicate-apis
```

3. Open the script file `remove-apimDuplicateApis.ps1` in a text editor, and set the values for the following variables at the beginning of the script:

- `$apiManagementName`: Name of the Azure API Management instance.
- `$apiManagementResourceGroupName`: Name of the resource group that the Azure API Management instance belongs to.
- `$apimApiName`: Name of the API that you want to remove duplicate operations from.

Save the changes to the script file.

4. Open a PowerShell window and navigate to the directory containing the script.

5. Run the script by entering the following command:

```
.\remove-apimDuplicateApis.ps1
```

6. The script will start executing, and output messages indicating which duplicate API operations are being deleted.

7. After the script finishes running, check the same directory as the script for the timestamped text file with the list of duplicate operation names.

8. Review the file as necessary to confirm that the correct operations have been deleted.

Alternatively, you can schedule the script to run automatically using the Task Scheduler in Windows or a similar tool. By scheduling the script to run at regular intervals, you can ensure that duplicate operations are removed on a consistent basis without the need for manual intervention.

## Notes

- The script uses an array of integers from 1 to 999 to check for duplicate operations based on the last character of the operation name.

- The script will output a timestamped text file in the same directory as the script with the list of duplicate operation names.

- If you don't want to delete any operations, you can comment out or remove the lines that contain `az apim api operation delete` commands.

## Explanation

The first step in the script after setting the necessary variables is to use the `az apim api operation list` command to retrieve a list of API operations for the specified API ID.

The resulting list is stored as a JSON object using the PowerShell `ConvertFrom-Json` cmdlet.

Next, an array of integers from 1 to 999 is created using the range operator `..`. This array will be used later to check for duplicate operations based on the last character of the operation name.

A `foreach` loop is then used to iterate through each API operation in the list.

Within the loop, the operation name is split using the `-` delimiter, and the last element of the resulting array is checked to see if it is present in the array of integers created earlier using the `-contains` operator.

If the last element of the operation name is a number between 1 and 999 inclusive, the script will log the name of the operation to a timestamped text file with the format `$apiManagementName-$apimApiName-duplicatelist-$today.txt`.

The `az apim api operation delete` command is then used to delete the operation, and the script displays a message indicating that the operation has been deleted.

The script ends when all operations in the list have been processed. If no duplicate operations are found, the script will not output any files or delete any operations.

## Details

The script is designed to simplify the management of API operations in Azure API Management by removing duplicate operations that may have been accidentally created during development or maintenance.

Removing duplicate operations can also help to reduce confusion for API users and make it easier to maintain a clean and organized API operation set.

The script uses Azure CLI and PowerShell commands to retrieve and process API operation data, and can be run on any machine with access to the necessary tools and Azure API Management instance credentials.

The script can also be customized by modifying the variables to match the specific API Management instance and API operation set being managed.

By running this script on a regular basis, API developers and administrators can proactively identify and remove duplicate operations before they become a problem.

This can help to improve API performance, user experience, and overall quality, and ultimately help to ensure that the API is meeting the needs of its intended audience.
