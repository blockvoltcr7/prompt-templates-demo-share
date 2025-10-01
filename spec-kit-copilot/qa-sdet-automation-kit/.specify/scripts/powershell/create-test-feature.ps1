#!/usr/bin/env pwsh
# Create a new test feature for QA automation
[CmdletBinding()]
param(
    [switch]$Json,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$StoryDescription
)
$ErrorActionPreference = 'Stop'

if (-not $StoryDescription -or $StoryDescription.Count -eq 0) {
    Write-Error "Usage: ./create-test-feature.ps1 [-Json] <JIRA story key or description>"
    Write-Error "Example: ./create-test-feature.ps1 PROJ-123: User authentication feature"
    exit 1
}
$storyDesc = ($StoryDescription -join ' ').Trim()

# Extract JIRA key if present (format: PROJ-123 or PROJ-123:)
$jiraKey = $null
if ($storyDesc -match '^([A-Z]+-\d+):?\s*(.*)$') {
    $jiraKey = $matches[1]
    $description = $matches[2].Trim()
    if (-not $description) {
        $description = $storyDesc
    }
} else {
    $description = $storyDesc
}

# Resolve repository root
function Find-RepositoryRoot {
    param(
        [string]$StartDir,
        [string[]]$Markers = @('.git', '.specify')
    )
    $current = Resolve-Path $StartDir
    while ($true) {
        foreach ($marker in $Markers) {
            if (Test-Path (Join-Path $current $marker)) {
                return $current
            }
        }
        $parent = Split-Path $current -Parent
        if ($parent -eq $current) {
            return $null
        }
        $current = $parent
    }
}

$fallbackRoot = (Find-RepositoryRoot -StartDir $PSScriptRoot)
if (-not $fallbackRoot) {
    Write-Error "Error: Could not determine repository root. Please run this script from within the repository."
    exit 1
}

try {
    $repoRoot = git rev-parse --show-toplevel 2>$null
    if ($LASTEXITCODE -eq 0) {
        $hasGit = $true
    } else {
        throw "Git not available"
    }
} catch {
    $repoRoot = $fallbackRoot
    $hasGit = $false
}

Set-Location $repoRoot

$specsDir = Join-Path $repoRoot 'specs'
New-Item -ItemType Directory -Path $specsDir -Force | Out-Null

# Determine feature number and name
if ($jiraKey) {
    # Use JIRA key as the feature directory name
    $featureName = $jiraKey.ToLower()
    $branchName = $featureName
} else {
    # Generate numeric prefix
    $highest = 0
    if (Test-Path $specsDir) {
        Get-ChildItem -Path $specsDir -Directory | ForEach-Object {
            if ($_.Name -match '^(\d{3})') {
                $num = [int]$matches[1]
                if ($num -gt $highest) { $highest = $num }
            }
        }
    }
    $next = $highest + 1
    $featureNum = ('{0:000}' -f $next)

    # Generate feature name from description
    $cleanDesc = $description.ToLower() -replace '[^a-z0-9]', '-' -replace '-{2,}', '-' -replace '^-', '' -replace '-$', ''
    $words = ($cleanDesc -split '-') | Where-Object { $_ } | Select-Object -First 3
    $featureName = "$featureNum-$([string]::Join('-', $words))"
    $branchName = "test/$featureName"
}

# Create branch if git is available
if ($hasGit) {
    try {
        git checkout -b $branchName 2>$null
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Branch '$branchName' may already exist. Checking out existing branch..."
            git checkout $branchName | Out-Null
        }
    } catch {
        Write-Warning "Failed to create git branch: $branchName"
    }
} else {
    Write-Warning "[specify] Warning: Git repository not detected; skipped branch creation for $branchName"
}

# Create feature directory
$featureDir = Join-Path $specsDir $featureName
New-Item -ItemType Directory -Path $featureDir -Force | Out-Null

# Create gherkin subdirectory
$gherkinDir = Join-Path $featureDir 'gherkin'
New-Item -ItemType Directory -Path $gherkinDir -Force | Out-Null

# Copy story analysis template
$template = Join-Path $repoRoot '.specify/templates/story-analysis-template.md'
$analysisFile = Join-Path $featureDir 'story-analysis.md'
if (Test-Path $template) {
    Copy-Item $template $analysisFile -Force
} else {
    New-Item -ItemType File -Path $analysisFile | Out-Null
}

# Set the SPECIFY_FEATURE environment variable for the current session
$env:SPECIFY_FEATURE = $featureName

# Prepare output
$storyKey = if ($jiraKey) { $jiraKey } else { $featureName.ToUpper() }

if ($Json) {
    $obj = [PSCustomObject]@{
        BRANCH_NAME = $branchName
        STORY_KEY = $storyKey
        FEATURE_NAME = $featureName
        ANALYSIS_FILE = $analysisFile
        GHERKIN_DIR = $gherkinDir
        FEATURE_DIR = $featureDir
        HAS_GIT = $hasGit
    }
    $obj | ConvertTo-Json -Compress
} else {
    Write-Output "BRANCH_NAME: $branchName"
    Write-Output "STORY_KEY: $storyKey"
    Write-Output "FEATURE_NAME: $featureName"
    Write-Output "ANALYSIS_FILE: $analysisFile"
    Write-Output "GHERKIN_DIR: $gherkinDir"
    Write-Output "FEATURE_DIR: $featureDir"
    Write-Output "HAS_GIT: $hasGit"
    Write-Output "SPECIFY_FEATURE environment variable set to: $featureName"
}
