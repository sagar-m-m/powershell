$username = "<sonarQubeAdminUsername>"
$password = ConvertTo-SecureString "<sonarQubeAdminPassword>" -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential ($username, $password)
$sonarQubeUrl = "<sonarQubeUrl>"
$projectsUri = "$sonarQubeUrl/api/components/search_projects?ps=100"


$Results = @()

$projects = Invoke-RestMethod -Method Get -Uri $projectsUri -Authentication Basic -Credential $Cred

foreach ($project in $projects.components) {

    $totalIssuesUri = "$sonarQubeUrl/api/issues/search?componentKeys=" + $project.key + "&resolved=false&ps=1"
    $HighIssuesUri = "$sonarQubeUrl/api/issues/search?componentKeys=" + $project.key + "&resolved=false&severities=MAJOR&ps=1"
    $CriticalIssuesUri = "$sonarQubeUrl/api/issues/search?componentKeys=" + $project.key + "&resolved=false&severities=CRITICAL&ps=1"
    $TotalIssues = (Invoke-RestMethod -Method Get -Uri $totalIssuesUri -Authentication Basic -Credential $Cred).total
    $HighIssues = (Invoke-RestMethod -Method Get -Uri $HighIssuesUri -Authentication Basic -Credential $Cred).total
    $CriticalIssues = (Invoke-RestMethod -Method Get -Uri $CriticalIssuesUri -Authentication Basic -Credential $Cred).total   
    $Results += [pscustomobject] @{
        "ProjectName"    = $project.name
        "HighIssues"     = $HighIssues
        "CriticalIssues" = $CriticalIssues
        "TotalIssues"    = $TotalIssues    
    }    
}

$Results += [pscustomobject] @{
    "ProjectName"    = "Total"
    "HighIssues"     = [int]($Results | Measure-Object -Property HighIssues -Sum ).Sum
    "CriticalIssues" = [int]($Results | Measure-Object -Property CriticalIssues -Sum).Sum
    "TotalIssues"    = [int]($Results | Measure-Object -Property TotalIssues -Sum).Sum
    
}
$Results | Export-Csv -Path $PSScriptRoot\sonarResult.csv -Force

$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TH {border-width: 1px; padding: 3px; border-style: solid; border-color: black; background-color: #6495ED;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@

$Results | ConvertTo-Html -body "<H2>SonarQube Issues report</H2>" -Head $Header  | Out-File $PSScriptRoot\sonarResult.html -Force 
