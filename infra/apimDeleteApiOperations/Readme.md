PowerShell Script to Delete API Operations in Azure API Management 🔍💻🚀
=========================================================================

This PowerShell script is used to delete the corresponding operations in Azure API Management when they exist in a Function App that uses HTTP Triggers.

Explanation 📝
--------------

This script retrieves all the HTTP Triggers from a Function App and filters them by type. Then it creates an Azure API Management context and retrieves the APIs. Finally, it iterates through the HTTP Triggers and deletes the corresponding operations in Azure API Management.

Prerequisites 📋
----------------

*   Azure PowerShell module needs to be installed.
*   You need to have valid Azure subscription credentials.
*   You should have permissions to manage API Management services and Function App resources in Azure.

Usage 🛠️
---------

1.  Assign values to the following variables at the beginning of the script:

* **$apimName**: The name of the Azure API Management service.
* **$apimRg**: The resource group of the Azure API Management service.
* **$apimApiName**: The name of the API in Azure API Management service.
* **$subId**: The subscription ID.
* **$functionAppRg**: The resource group of the Function App.
* **$functionAppName**: The name of the Function App.

3.  Open PowerShell on your local machine.
4.  Navigate to the directory where the script file (remove-apimApiOperations.ps1) is located using the `cd` command.
5.  Run the script by typing `.\remove-apimApiOperations.ps1` and pressing Enter.
6.  The script will run and perform the necessary actions on the specified Azure resources.

Note: Before running the script, ensure that you have assigned the correct values to the variables at the beginning of the script.
