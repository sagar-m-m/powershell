$project = "<ProjectName>"
$repository = "<repoName>"
$organization = "https://dev.azure.com/<OrganizationName>"
$excludeBranches = @("develop","master","qa") #Provide any branch names that needs to be excluded
$daysDeleteBefore = -30 #Provide number of days
$dateTimeNow = [DateTime]::Now
$dateTimeBeforeToDelete = $dateTimeNow.AddDays( $daysDeleteBefore)
if (-not (Test-Path env:IS_DRY_RUN)) { $env:IS_DRY_RUN = $true }
Write-Host ("is dry run: {0}" -f $env:IS_DRY_RUN)
Write-Host ("datetime now: {0}" -f $dateTimeNow)
Write-Host ("delete branches before {0}" -f (get-date $dateTimeBeforeToDelete))
Write-Host "Getting list of branches"
$refs = az repos ref list --project $project --repository $repository --organization $organization --filter heads | ConvertFrom-Json
Write-Host "Got list of branches"
$toDeleteBranches = @() 
Write-host "Total ref are"
$refs.Count
foreach ($ref in $refs) {
    Write-Host "Current count is"
    $refs.IndexOf($ref) 
    if ($ref.name -replace "refs/heads/" -in $excludeBranches) {
        continue;
    }
    $objectId = $ref.objectId
 
    # fetch individual commit details
    $commit = az devops invoke `
    --area git `
    --resource commits `
    --organization $organization `
    --route-parameters `
    project=$project `
    repositoryId=$repository `
    commitId=$objectId |
ConvertFrom-Json
 
    $toDelete = [PSCustomObject]@{ 
        name         = $ref.name
        creator      = $ref.creator.uniqueName
        lastAuthor   = $commit.committer.email
        lastModified = $commit.push.date
        objectId     = $objectId
    }
    $toDeleteBranches += , $toDelete
}

$toDeleteBranches = $toDeleteBranches  | Where-Object { (get-date $_.lastModified) -lt (get-date $dateTimeBeforeToDelete) }

if ($toDeleteBranches.count -eq 0) {
    Write-Host "No stale branches to delete"
    return;
}
$filename = $repository + "__StaleBranches.csv"
$toDeleteBranches  | ConvertTo-Csv -UseQuotes AsNeeded > ./$filename
ForEach-Object {
    Write-Host ("deleting staled branch: name={0} - id={1} - lastModified={2}" -f $_.name, $_.objectId, $_.lastModified)
    if (![System.Convert]::ToBoolean($env:IS_DRY_RUN)) {
      
       $result = az repos ref delete `
            --name $_.name `
            --object-id $_.objectId `
            --project $project `
            --repository $repository |
        ConvertFrom-Json
        Write-Host ("success message: {0}" -f $result.updateStatus)
      
    }
}
