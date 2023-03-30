# SonarQube Report Generator

This PowerShell script generates a report of the number of high and critical issues for each project in SonarQube and outputs the results to a CSV file and an HTML report.

## Prerequisites

Before running the script, you must have the following:

- A SonarQube instance URL - this is the URL of your SonarQube instance, e.g. `https://sonarqube.example.com`.
- Credentials for a SonarQube admin user - this is the username and password of a SonarQube user with admin privileges.

## Usage

1. Download and save the `get-sonarQubeReport.ps1` PowerShell script to your local machine.
2. Open the script in a text editor and update the following variables with your SonarQube instance URL, admin username, and admin password:

```
$username = "<sonarQubeAdminUsername>"
$password = ConvertTo-SecureString "<sonarQubeAdminPassword>" -AsPlainText -Force
$sonarQubeUrl = "<sonarQubeUrl>"
```

3. Save the changes to the script.
4. Open PowerShell on your local machine and navigate to the directory where the script is saved.
5. Enter the following command to run the script:

```
./get-sonarQubeReport.ps1
```

6. The script will start running and will output the results to the console. After the script finishes running, two files will be generated in the same directory as the script:

- `sonarResult.csv` - this file contains the results in CSV format.
- `sonarResult.html` - this file contains the results in an HTML format.

7. You can open the `sonarResult.html` file in your web browser to view the results in a formatted report. The format of the report will look like this:

# SonarQube Issues report

| ProjectName | HighIssues | CriticalIssues | TotalIssues |
|-------------|-----------|----------------|-------------|
| project1 | 14 | 9 | 29 |
| project2 | 7978 | 737 | 10826 |
| project3 | 425 | 693 | 2229 |
| project4 | 493 | 365 | 1479 |
| project5 | 16 | 1 | 19 |
| project6 | 32 | 23 | 58 |
| project7 | 1020 | 834 | 1998 |
| Total | 9978 | 2662 | 16638 |

8. You can also view the results in the `sonarResult.csv` file.

## Contributing

If you find an issue with the script or would like to suggest an improvement, please submit a pull request or open an issue. Contributions are always welcome!

