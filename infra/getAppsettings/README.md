## Introduction
This PowerShell script helps to manage Azure Function Apps by providing an easy way of retrieving and saving their appsettings to separate JSON files. Appsettings are used to configure applications and contain key-value pairs of configuration settings.

## Requirements
Before running the script, you should have the following:
- Azure PowerShell module installed on your machine
- Azure account with sufficient privileges to view and modify Function App settings within the specified subscription (you should be logged in prior to running the script)
- Subscription ID: The script requires a valid subscription ID to target the query on. Replace `"XXXXX-XXXXX-XXXXX-XXXXX"` with your subscription ID.

## Instructions
1. Download the `get-functionAppAppsettings.ps1` script.
2. Open a PowerShell command prompt or PowerShell ISE console window, then navigate to the folder where the script is stored.
3. Run the script with PowerShell by typing `./get-functionAppAppsettings.ps1` followed by pressing `Enter`.

## Output folder structure
Once the script is run, it creates a folder named "Appsettings" in the same directory where the script is located. It then saves a separate JSON file for each Function App's appsettings under this folder with the filename as the app name.

```
<App Folder>
│ get-functionAppAppsettings.ps1
│
└───Appsettings
│ │ <App 1 name>.json
│ │ <App 2 name>.json
│ │ ...
│
```

## Security Considerations
It's important to avoid storing sensitive data within the script since it may lead to security vulnerabilities. It's recommended to store such data in secure methods such as Azure Key Vault or environment variables.

## Results
- The script retrieves the appsettings of all Function Apps under the specified subscription.
- The appsettings are saved as separate JSON files in the "Appsettings" folder.
- Each appsetting file is named after the Function App's name.


