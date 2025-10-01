# Test Report Generator and Analyzer
# This script generates comprehensive test reports and analyzes test results

param(
    [Parameter(Mandatory=$false)]
    [string]$ProjectPath = ".",
    
    [Parameter(Mandatory=$false)]
    [string]$ReportFormat = "html",
    
    [Parameter(Mandatory=$false)]
    [switch]$OpenReport = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$EmailReport = $false,
    
    [Parameter(Mandatory=$false)]
    [string]$EmailRecipients = ""
)

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Get-TestResults {
    param([string]$ProjectPath)
    
    $serenityReportPath = Join-Path $ProjectPath "target\site\serenity"
    $testResultsPath = Join-Path $ProjectPath "target\surefire-reports"
    
    $results = @{
        SerenityReportExists = Test-Path $serenityReportPath
        TestResultsExist = Test-Path $testResultsPath
        SerenityReportPath = $serenityReportPath
        TestResultsPath = $testResultsPath
    }
    
    return $results
}

function Get-TestMetrics {
    param([string]$ProjectPath)
    
    $metricsFile = Join-Path $ProjectPath "target\site\serenity\serenity-summary.txt"
    
    if (!(Test-Path $metricsFile)) {
        Write-ColorOutput "Serenity summary file not found. Run tests first." "Red"
        return $null
    }
    
    $content = Get-Content $metricsFile -Raw
    
    # Parse test metrics (simplified parsing)
    $metrics = @{
        TotalTests = 0
        PassedTests = 0
        FailedTests = 0
        PendingTests = 0
        PassRate = 0
        ExecutionTime = "Unknown"
    }
    
    # You would implement actual parsing logic here based on Serenity output format
    
    return $metrics
}

function Generate-TestSummaryReport {
    param(
        [string]$ProjectPath,
        [hashtable]$Metrics
    )
    
    $reportPath = Join-Path $ProjectPath "test-summary-report.html"
    
    $htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Test Execution Summary</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .header { background-color: #f0f0f0; padding: 20px; border-radius: 5px; }
        .metrics { display: flex; justify-content: space-around; margin: 20px 0; }
        .metric-box { background-color: #e9f4ff; padding: 15px; border-radius: 5px; text-align: center; }
        .passed { background-color: #d4edda; }
        .failed { background-color: #f8d7da; }
        .pending { background-color: #fff3cd; }
        .chart-container { margin: 20px 0; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Test Execution Summary Report</h1>
        <p>Generated on: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
        <p>Project: $(Split-Path $ProjectPath -Leaf)</p>
    </div>
    
    <div class="metrics">
        <div class="metric-box">
            <h3>Total Tests</h3>
            <h2>$($Metrics.TotalTests)</h2>
        </div>
        <div class="metric-box passed">
            <h3>Passed</h3>
            <h2>$($Metrics.PassedTests)</h2>
        </div>
        <div class="metric-box failed">
            <h3>Failed</h3>
            <h2>$($Metrics.FailedTests)</h2>
        </div>
        <div class="metric-box pending">
            <h3>Pending</h3>
            <h2>$($Metrics.PendingTests)</h2>
        </div>
    </div>
    
    <div class="chart-container">
        <h3>Pass Rate: $($Metrics.PassRate)%</h3>
        <div style="background-color: #f0f0f0; height: 30px; border-radius: 15px;">
            <div style="background-color: #28a745; height: 30px; width: $($Metrics.PassRate)%; border-radius: 15px;"></div>
        </div>
    </div>
    
    <h3>Quick Links</h3>
    <ul>
        <li><a href="target/site/serenity/index.html">Full Serenity Report</a></li>
        <li><a href="target/surefire-reports">Surefire Reports</a></li>
    </ul>
    
    <h3>Test Execution Details</h3>
    <p>Execution Time: $($Metrics.ExecutionTime)</p>
    <p>Environment: $(if ($env:TEST_ENV) { $env:TEST_ENV } else { "Default" })</p>
    
    <h3>Recommendations</h3>
    <ul>
        $(if ($Metrics.FailedTests -gt 0) { "<li style='color: red;'>Investigate and fix $($Metrics.FailedTests) failed test(s)</li>" })
        $(if ($Metrics.PassRate -lt 95) { "<li style='color: orange;'>Pass rate is below 95% - review test stability</li>" })
        $(if ($Metrics.PendingTests -gt 0) { "<li style='color: blue;'>Complete implementation of $($Metrics.PendingTests) pending test(s)</li>" })
    </ul>
</body>
</html>
"@

    $htmlContent | Out-File -FilePath $reportPath -Encoding UTF8
    Write-ColorOutput "Test summary report generated: $reportPath" "Green"
    
    return $reportPath
}

function Send-EmailReport {
    param(
        [string]$ReportPath,
        [string]$Recipients
    )
    
    # This would require email configuration
    Write-ColorOutput "Email functionality requires SMTP configuration" "Yellow"
    Write-ColorOutput "Report available at: $ReportPath" "Cyan"
}

# Main execution
Write-ColorOutput "=== QA/SDET Test Report Generator ===" "Cyan"

# Check if this is a valid test project
if (!(Test-Path (Join-Path $ProjectPath "pom.xml"))) {
    Write-ColorOutput "This doesn't appear to be a Maven project. Please run from project root." "Red"
    exit 1
}

Write-ColorOutput "Analyzing test results for project: $(Split-Path $ProjectPath -Leaf)" "Yellow"

# Get test results
$results = Get-TestResults -ProjectPath $ProjectPath

if (!$results.SerenityReportExists -and !$results.TestResultsExist) {
    Write-ColorOutput "No test results found. Please run tests first:" "Red"
    Write-ColorOutput "mvn clean test serenity:aggregate" "Yellow"
    exit 1
}

# Get test metrics
$metrics = Get-TestMetrics -ProjectPath $ProjectPath

if ($metrics) {
    # Generate summary report
    $reportPath = Generate-TestSummaryReport -ProjectPath $ProjectPath -Metrics $metrics
    
    # Open report if requested
    if ($OpenReport) {
        Start-Process $reportPath
    }
    
    # Send email if requested
    if ($EmailReport -and $EmailRecipients) {
        Send-EmailReport -ReportPath $reportPath -Recipients $EmailRecipients
    }
    
    # Display summary in console
    Write-ColorOutput "`n=== Test Execution Summary ===" "Cyan"
    Write-ColorOutput "Total Tests: $($metrics.TotalTests)" "White"
    Write-ColorOutput "Passed: $($metrics.PassedTests)" "Green"
    Write-ColorOutput "Failed: $($metrics.FailedTests)" "Red"
    Write-ColorOutput "Pending: $($metrics.PendingTests)" "Yellow"
    Write-ColorOutput "Pass Rate: $($metrics.PassRate)%" "Cyan"
    
    if ($results.SerenityReportExists) {
        Write-ColorOutput "`nFull Serenity report available at:" "Yellow"
        Write-ColorOutput "$($results.SerenityReportPath)\index.html" "Cyan"
    }
    
} else {
    Write-ColorOutput "Could not parse test metrics. Check if tests have been executed." "Red"
}

Write-ColorOutput "`n=== Report Generation Complete ===" "Green"