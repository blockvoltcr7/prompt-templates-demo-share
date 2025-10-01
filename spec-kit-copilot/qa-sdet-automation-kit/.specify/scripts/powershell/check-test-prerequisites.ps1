#!/usr/bin/env pwsh
# Check prerequisites for QA test automation workflow
[CmdletBinding()]
param(
    [switch]$Json,
    [switch]$RequireTestPlan,
    [switch]$RequireGherkin,
    [switch]$RequireStrategy,
    [switch]$PathsOnly,
    [switch]$Help
)

$ErrorActionPreference = 'Stop'

# Show help if requested
if ($Help) {
    Write-Output @"
Usage: check-test-prerequisites.ps1 [OPTIONS]

Prerequisite checking for QA test automation workflow.

OPTIONS:
  -Json                Output in JSON format
  -RequireTestPlan     Require test-plan.md to exist
  -RequireGherkin      Require gherkin/ directory to exist with .feature files
  -RequireStrategy     Require test-automation-strategy.md to exist
  -PathsOnly           Only output path variables (no validation)
  -Help, -h            Show this help message

EXAMPLES:
  # Check story analysis prerequisites
  .\check-test-prerequisites.ps1 -Json

  # Check test plan prerequisites (requires story-analysis.md)
  .\check-test-prerequisites.ps1 -Json -RequireTestPlan

  # Check gherkin prerequisites (requires test-plan.md and gherkin files)
  .\check-test-prerequisites.ps1 -Json -RequireTestPlan -RequireGherkin

  # Check implementation prerequisites (requires strategy)
  .\check-test-prerequisites.ps1 -Json -RequireStrategy

  # Get feature paths only (no validation)
  .\check-test-prerequisites.ps1 -Json -PathsOnly

"@
    exit 0
}

# Source common functions
. "$PSScriptRoot/common.ps1"

# Get feature paths and validate branch
$paths = Get-FeaturePathsEnv

if (-not (Test-FeatureBranch -Branch $paths.CURRENT_BRANCH -HasGit:$paths.HAS_GIT)) {
    exit 1
}

# If paths-only mode, output paths and exit
if ($PathsOnly) {
    if ($Json) {
        [PSCustomObject]@{
            REPO_ROOT      = $paths.REPO_ROOT
            BRANCH         = $paths.CURRENT_BRANCH
            STORY_DIR      = $paths.FEATURE_DIR
            ANALYSIS_FILE  = $paths.FEATURE_SPEC
            TEST_PLAN_FILE = $paths.IMPL_PLAN
            GHERKIN_DIR    = $paths.CONTRACTS_DIR
            STRATEGY_FILE  = $paths.RESEARCH
            TEST_FRAMEWORK_DIR = Join-Path $paths.REPO_ROOT 'src/test/java'
        } | ConvertTo-Json -Compress
    } else {
        Write-Output "REPO_ROOT: $($paths.REPO_ROOT)"
        Write-Output "BRANCH: $($paths.CURRENT_BRANCH)"
        Write-Output "STORY_DIR: $($paths.FEATURE_DIR)"
        Write-Output "ANALYSIS_FILE: $($paths.FEATURE_SPEC)"
        Write-Output "TEST_PLAN_FILE: $($paths.IMPL_PLAN)"
        Write-Output "GHERKIN_DIR: $($paths.CONTRACTS_DIR)"
        Write-Output "STRATEGY_FILE: $($paths.RESEARCH)"
        Write-Output "TEST_FRAMEWORK_DIR: $(Join-Path $paths.REPO_ROOT 'src/test/java')"
    }
    exit 0
}

# Map QA-specific paths
$STORY_DIR = $paths.FEATURE_DIR
$ANALYSIS_FILE = Join-Path $STORY_DIR 'story-analysis.md'
$TEST_PLAN_FILE = Join-Path $STORY_DIR 'test-plan.md'
$GHERKIN_DIR = Join-Path $STORY_DIR 'gherkin'
$STRATEGY_FILE = Join-Path $STORY_DIR 'test-automation-strategy.md'
$IMPL_SUMMARY_FILE = Join-Path $STORY_DIR 'implementation-summary.md'
$STEP_DEFS_GUIDE = Join-Path $STORY_DIR 'step-definitions-guide.md'

# Validate required directories and files
if (-not (Test-Path $STORY_DIR -PathType Container)) {
    Write-Output "ERROR: Story directory not found: $STORY_DIR"
    Write-Output "Run /analyze-story first to create the story structure."
    exit 1
}

if (-not (Test-Path $ANALYSIS_FILE -PathType Leaf)) {
    Write-Output "ERROR: story-analysis.md not found in $STORY_DIR"
    Write-Output "Run /analyze-story first to analyze the JIRA story."
    exit 1
}

# Check for test-plan.md if required
if ($RequireTestPlan -and -not (Test-Path $TEST_PLAN_FILE -PathType Leaf)) {
    Write-Output "ERROR: test-plan.md not found in $STORY_DIR"
    Write-Output "Run /test-plan first to create the test plan."
    exit 1
}

# Check for gherkin directory if required
if ($RequireGherkin) {
    if (-not (Test-Path $GHERKIN_DIR -PathType Container)) {
        Write-Output "ERROR: gherkin/ directory not found in $STORY_DIR"
        Write-Output "Run /gherkin-scenarios first to generate Gherkin scenarios."
        exit 1
    }

    # Check if there are any .feature files
    $featureFiles = Get-ChildItem -Path $GHERKIN_DIR -Filter "*.feature" -ErrorAction SilentlyContinue
    if (-not $featureFiles -or $featureFiles.Count -eq 0) {
        Write-Output "ERROR: No .feature files found in $GHERKIN_DIR"
        Write-Output "Run /gherkin-scenarios first to generate Gherkin scenarios."
        exit 1
    }
}

# Check for test-automation-strategy.md if required
if ($RequireStrategy -and -not (Test-Path $STRATEGY_FILE -PathType Leaf)) {
    Write-Output "ERROR: test-automation-strategy.md not found in $STORY_DIR"
    Write-Output "Run /test-strategy first to create the automation strategy."
    exit 1
}

# Build list of available documents
$docs = @()

# Always include story-analysis.md (required)
$docs += 'story-analysis.md'

# Check optional docs
if (Test-Path $TEST_PLAN_FILE) { $docs += 'test-plan.md' }
if ((Test-Path $GHERKIN_DIR) -and (Get-ChildItem -Path $GHERKIN_DIR -Filter "*.feature" -ErrorAction SilentlyContinue | Select-Object -First 1)) {
    $docs += 'gherkin/*.feature'
}
if (Test-Path $STRATEGY_FILE) { $docs += 'test-automation-strategy.md' }
if (Test-Path $IMPL_SUMMARY_FILE) { $docs += 'implementation-summary.md' }
if (Test-Path $STEP_DEFS_GUIDE) { $docs += 'step-definitions-guide.md' }

# Output results
if ($Json) {
    # JSON output
    [PSCustomObject]@{
        STORY_DIR = $STORY_DIR
        ANALYSIS_FILE = $ANALYSIS_FILE
        TEST_PLAN_FILE = $TEST_PLAN_FILE
        GHERKIN_DIR = $GHERKIN_DIR
        STRATEGY_FILE = $STRATEGY_FILE
        TEST_FRAMEWORK_DIR = Join-Path $paths.REPO_ROOT 'src/test/java'
        AVAILABLE_DOCS = $docs
    } | ConvertTo-Json -Compress
} else {
    # Text output
    Write-Output "STORY_DIR: $STORY_DIR"
    Write-Output "AVAILABLE_DOCS:"

    # Show status of each potential document
    Test-FileExists -Path $ANALYSIS_FILE -Description 'story-analysis.md' | Out-Null
    Test-FileExists -Path $TEST_PLAN_FILE -Description 'test-plan.md' | Out-Null
    Test-DirHasFiles -Path $GHERKIN_DIR -Description 'gherkin/*.feature' | Out-Null
    Test-FileExists -Path $STRATEGY_FILE -Description 'test-automation-strategy.md' | Out-Null
    Test-FileExists -Path $IMPL_SUMMARY_FILE -Description 'implementation-summary.md' | Out-Null
    Test-FileExists -Path $STEP_DEFS_GUIDE -Description 'step-definitions-guide.md' | Out-Null
}
