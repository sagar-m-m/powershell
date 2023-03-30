
# CosmosDBMigration PowerShell Script

## Introduction

This PowerShell script is designed to help users migrate data from one Cosmos DB account to another within the same region. The script uses Azure PowerShell cmdlets and the DT.exe tool provided by Microsoft to transfer data and procedures between accounts.

The script takes several parameters, some of which are mandatory, and others optional.

## Prerequisites

To use this script, you need to have the following:

- PowerShell version 5.1 or above
- Azure PowerShell Module
- DT.exe tool from Microsoft
- An active subscription to Azure
- Permissions to create new resources in Azure

## Parameters

### Mandatory Parameters
- **SourceRGName:** The resource group name of the source account.
- **SourceDBAccountName:** The Cosmos DB account name of the source account.
- **DestinationRGName:** The resource group name of the destination account.
- **DestinationDBAccountName:** The Cosmos DB account name of the destination account.

### Optional Parameters
- **sleepTime:** The time to sleep between container creations. Default is 60 seconds.
- **migratedata:** This switch enables Data migration.
- **provisioned:** This switch enables the autoscale throughput provisioning.
- **CollectionThroughput:** This sets the throughput value for the collection. Default is 1000.

## How to Use the PowerShell Script

1. Install Azure PowerShell module if not installed.
https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-6.0.0

2. Install dt.exe tool to perform the data migration.
https://docs.microsoft.com/en-us/azure/cosmos-db/import-data

3. Open PowerShell ISE or any other PowerShell editor.

4. Load the script and execute it by providing the required parameters.
```PowerShell
.\CosmosDBMigration.ps1 -SourceRGName "sourceResourceGroupName" -SourceDBAccountName "sourceCosmosDbAccountName" -DestinationRGName "destinationResourceGroupName" -DestinationDBAccountName "destinationCosmosDbAccountName" -sleepTime 120 -migratedata -provisioned -CollectionThroughput 4000
```

5. If the -migratedata switch is specified, the script will start migrating data from source to target account. This process might take time, depending on the data size.

6. If the -provisioned switch is specified, the CollectionThroughput parameter is used to set the throughput value for the collection.

7. Once the migration process is completed, the target account will have the same data as the source account.

## How it works

The script uses Azure PowerShell cmdlets to interact with the source and destination Cosmos DB accounts. It gets the list of databases and containers from the source account and creates the same in the destination account.

For data migration, the script uses the DT.exe tool provided by Microsoft to migrate data from the source to the target account. The tool transfers data in a partitioned and efficient manner, ensuring that all data is transferred without any loss. The migration process can take some time, depending on the volume of data being transferred.

Stored procedures from the source account are also created in the target account using Get-AzCosmosDBSqlStoredProcedure, Remove-AzCosmosDBSqlStoredProcedure, and New-AzCosmosDBSqlStoredProcedure. This ensures that all necessary data and procedures are transferred to the new account.

## Best Practices

To ensure a smooth migration process, it's important to follow some best practices:

- Test the script on a test environment before running it in production.
- Ensure that the source and target Cosmos DB accounts are running the same version of Cosmos DB API and features.
- Ensure that the target account has enough capacity and throughput to handle the data being transferred.
- Monitor the migration process to ensure that it completes successfully without any issues.

## Troubleshooting

In case of any issues during the migration process, here are some troubleshooting tips:

- Check the Azure Portal for any error messages or notifications related to the migration process.
- Check the DT.exe tool logs for any error messages or issues encountered during data migration.
- Check the Azure PowerShell cmdlet logs for any error messages or issues encountered during the process.

## Conclusion

This PowerShell script provides a fast and efficient way to migrate data from one Cosmos DB account to another. With its easy-to-use interface and automated process, it reduces the time and effort involved in manual migration and ensures the data is consistent across both accounts. Following the best practices and troubleshooting tips can further ensure a smooth migration process.
