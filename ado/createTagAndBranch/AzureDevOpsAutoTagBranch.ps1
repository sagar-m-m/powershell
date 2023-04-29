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

# Encode the PAT for use in the authentication header
$AzureDevOpsAuthenicationHeader = @{
    Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($PAT)"))
}

# Get the latest commit ID from the source branch
$getLatestCommit = "$adoUrl/_apis/git/repositories/$repo/commits?searchCriteria.`$top=1&searchCriteria.itemVersion.version=$sourceBranch&api-version=7.0"
$commitId = (Invoke-RestMethod -Method Get -Uri $getLatestCommit -Headers $AzureDevOpsAuthenicationHeader).value.commitId

Write-Host "commit id is $commitId"
Write-Host "tag is $tag"
Write-Host "message is $tagMessage"

# Create a new annotated tag based on the latest commit
$createTagUri = "$adoUrl/_apis/git/repositories/$repo/annotatedtags?api-version=7.0"
$createTagBody = @{
    name = $tag
    taggedObject = @{
        objectId = $commitId
    }
    message = $tagMessage
} | ConvertTo-Json

Write-Host "Creating tag using latest commit from $sourceBranch"

$tagResult = Invoke-RestMethod -Method POST `
    -Body $createTagBody `
    -Uri $createTagUri `
    -Headers $AzureDevOpsAuthenicationHeader `
    -ContentType "application/json" `
    -ErrorAction Stop

$tagName = $tagResult.name
$tagObjectId = $tagResult.objectId

Write-Host "Creating branch from $tagName "

# Create a new branch from the newly created tag
$createBranchUri = "$adoUrl/_apis/git/repositories/$repo/refs?api-version=7.0"
$newObjectId = $tagResult.taggedObject.objectId

$createBranchBody = @(
    @{
        name = $targetBranch
        oldObjectId = "0000000000000000000000000000000000000000"
        newObjectId = $newObjectId
    }
) | ConvertTo-Json

$newBranch = Invoke-RestMethod -Method POST `
    -Body $createBranchBody `
    -Uri $createBranchUri `
    -Headers $AzureDevOpsAuthenicationHeader `
    -ContentType "application/json" `
    -TransferEncoding "chunked" `
    -ErrorAction Stop

Write-Host "New branch created"
