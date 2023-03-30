# Azure Function Apps' Appsettings Retrieval and Storage 👨‍💻

Welcome to the GitHub repository for our PowerShell script that is designed to retrieve and save Azure Function Apps' appsettings to separate JSON files. 🚀

## Introduction

Azure Function Apps' appsettings can be difficult to manage and maintain, especially when they are spread across multiple Function Apps. Our PowerShell script simplifies this process by retrieving and storing these appsettings in separate JSON files, making it easier to manage and maintain these settings.

## Features ⭐️

- Retrieves and stores Azure Function Apps' appsettings in separate JSON files.
- Creates a separate JSON file for each Function App's appsettings with the filename as the app name.
- Outputs a list of messages indicating the appsettings retrieved and the files where they're stored.
- Easy to customize to suit your specific needs.

## Prerequisites 🧰

Before running the script, ensure that you have the following prerequisites:

- [Azure PowerShell module](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-6.2.0) installed on your machine.
- A valid Azure subscription ID to target the query. Replace `XXXXX-XXXXX-XXXXX-XXXXX` with your subscription ID.
- Azure account with sufficient privileges to view and modify Function App settings within the specified subscription (you should be logged in prior to running the script).

## How to Use 👨‍🏫

1. Download the `get-functionAppAppsettings.ps1` script.
2. Launch the PowerShell command prompt or PowerShell ISE console window.
3. Navigate to the directory where the script is located.
4. Run the script with PowerShell by typing `.\get-functionAppAppsettings.ps1`.
5. The script outputs a list of messages indicating the appsettings retrieved and the files where they're stored.

## Output folder structure 📂

Once the script is run, it creates a folder named `Appsettings` in the same directory where the script is located. It then saves a separate JSON file for each Function App's appsettings under this folder with the filename as the app name.

```
<App Folder>
├── get-functionAppAppsettings.ps1
└── Appsettings
├── FunctionApp1.json
├── FunctionApp2.json
└── ...
```

## Security Considerations 🔒

It's important to avoid hardcoding sensitive data within the script since it may lead to security vulnerabilities. We recommend using Azure Key Vault to store sensitive data and use PowerShell to retrieve the values.

## Contribute 🤝

We welcome contributions to improve the functionality of the script. To contribute, please fork the repository, make your changes, and submit a pull request.


## Resources 📖

- [Azure PowerShell module](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-6.2.0)
- [Azure Function Apps](https://azure.microsoft.com/en-us/services/functions/)
- [PowerShell ISE](https://docs.microsoft.com/en-us/powershell/scripting/tools/windows-powershell/introducing-the-windows-powershell-ise?view=powershell-7.1)
