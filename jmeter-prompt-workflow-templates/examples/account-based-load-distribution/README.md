# Account-Based Load Distribution Example

This is the **hero example** demonstrating the complete AI-assisted JMeter workflow for financial services performance testing with account-based load distribution.

---

## Scenario Overview

### Business Context
A portfolio management API that retrieves position data for client accounts. Response time varies significantly based on account size (number of positions held).

### Key Challenge
Different accounts have vastly different data volumes:
- Small accounts: 1-50 positions (fast, 150ms avg response time)
- Medium accounts: 51-200 positions (moderate, 450ms avg)
- Large accounts: 201-500 positions (slow, 1200ms avg)
- XLarge accounts: 500+ positions (very slow, 2800ms avg)

### Testing Goal
Create a performance test that mirrors production traffic distribution, where 60% of calls are for small accounts and only 1% are for xlarge accounts.

---

## What's Included

This complete example contains:

1. **[production-data-analysis.md](production-data-analysis.md)** - Production traffic analysis showing the 60/30/9/1% distribution
2. **[test-plan.md](test-plan.md)** - Structured test plan document with endpoints, SLAs, and requirements
3. **[generated.jmx](generated.jmx)** ⭐ - Complete working JMeter script (AI-generated)
4. **[test-data-small-accounts.csv](test-data-small-accounts.csv)** - Test data for small accounts (26 positions avg)
5. **[test-data-medium-accounts.csv](test-data-medium-accounts.csv)** - Test data for medium accounts (120 positions avg)
6. **[test-data-large-accounts.csv](test-data-large-accounts.csv)** - Test data for large accounts (350 positions avg)
7. **[test-data-xlarge-accounts.csv](test-data-xlarge-accounts.csv)** - Test data for xlarge accounts (750 positions avg)
8. **[results-analysis.md](results-analysis.md)** - Example results interpretation and analysis

---

## How to Use This Example

### Quick Test (5 minutes)

1. **Open the generated .jmx file**:
   ```bash
   jmeter -t generated.jmx
   ```

2. **Update CSV file paths** (if needed):
   - Right-click each "CSV Data Set Config" element
   - Update "Filename" to absolute path
   - Example: `/Users/yourname/.../test-data-small-accounts.csv`

3. **Run the test**:
   - Click green "Start" button
   - View results in "Aggregate Report"

4. **Review results**:
   - Check weighted average response time (~331ms expected)
   - Verify error rate < 1%
   - Compare to production metrics

### Learning Exercise (30 minutes)

Follow the complete workflow to regenerate this example:

1. **Stage 1**: Analyze [test-plan.md](test-plan.md) using [stage-1 prompt](../../prompts/stage-1-test-plan-analysis.md)
2. **Stage 2**: Calculate load distribution using [stage-2 prompt](../../prompts/stage-2-load-distribution-calculation.md)
3. **Stage 3**: Generate .jmx using [stage-3 prompt](../../prompts/stage-3-jmx-generation.md)
4. **Stage 4**: Generate CSV data using [stage-4 prompt](../../prompts/stage-4-csv-data-generation.md)
5. **Stage 5**: Validate before execution using [stage-5 prompt](../../prompts/stage-5-execution-validation.md)
6. **Execute**: Run test in JMeter
7. **Stage 6**: Analyze results using [stage-6 prompt](../../prompts/stage-6-results-analysis.md)

---

## Key Concepts Demonstrated

### 1. Production Data-Driven Load Distribution

**Production Analysis** ([see details](production-data-analysis.md)):
- 60% of API calls: Small accounts (1-50 positions)
- 30% of API calls: Medium accounts (51-200 positions)
- 9% of API calls: Large accounts (201-500 positions)
- 1% of API calls: XLarge accounts (500+ positions)

**JMeter Implementation**:
- Thread Group 1: 60 threads → small accounts CSV
- Thread Group 2: 30 threads → medium accounts CSV
- Thread Group 3: 9 threads → large accounts CSV
- Thread Group 4: 1 thread → xlarge accounts CSV

### 2. Weighted Average Response Time Calculation

Expected response time based on production distribution:
```
Weighted Avg = (0.60 × 150ms) + (0.30 × 450ms) + (0.09 × 1200ms) + (0.01 × 2800ms)
             = 90 + 135 + 108 + 28
             = 361ms
```

This should match the "Total" line in JMeter's Aggregate Report.

### 3. CSV Parameterization

Each thread group uses its own CSV file with account-specific data:

**Small Accounts CSV** (26 positions avg):
```csv
accountId,accountName,positionCount,expectedResponseTime
ACC10001,Small Portfolio A,26,150
ACC10002,Small Portfolio B,18,130
```

**XLarge Accounts CSV** (750 positions avg):
```csv
accountId,accountName,positionCount,expectedResponseTime
ACC40001,XLarge Portfolio A,750,2800
ACC40002,XLarge Portfolio B,820,3000
```

### 4. Realistic Performance SLAs

- **95th percentile response time**: < 500ms (based on production)
- **Error rate**: < 1%
- **Throughput**: > 100 requests/second
- **Concurrent users**: 100 (total threads across all groups)

---

## Expected Results

After running this test for 5 minutes, you should see:

### Aggregate Report

| Label | # Samples | Average | 95th % | Error % | Throughput |
|-------|-----------|---------|--------|---------|------------|
| Small Accounts (60%) | ~1200 | 150ms | 180ms | 0.00% | 40/sec |
| Medium Accounts (30%) | ~600 | 450ms | 520ms | 0.00% | 20/sec |
| Large Accounts (9%) | ~180 | 1200ms | 1350ms | 0.00% | 6/sec |
| XLarge Accounts (1%) | ~20 | 2800ms | 3100ms | 0.00% | 0.66/sec |
| **TOTAL** | ~2000 | **361ms** | **580ms** | **0.00%** | **66.6/sec** |

**Key Validation**:
- ✅ Weighted average (361ms) matches calculation
- ✅ 95th percentile < 500ms SLA (might fail due to large accounts - expected)
- ✅ Error rate < 1%
- ✅ Thread distribution matches production (60/30/9/1%)

---

## Files Explained

### 1. production-data-analysis.md
Shows how production logs were analyzed to determine:
- Call volume by account size
- Average response times
- Load distribution percentages
- Business context for testing priorities

### 2. test-plan.md
Structured test plan document containing:
- API endpoint specification
- Authentication requirements
- Load distribution requirements
- Performance SLAs
- Test duration and ramp-up

### 3. generated.jmx
Complete JMeter XML file with:
- 4 thread groups (60, 30, 9, 1 threads)
- HTTP GET sampler with parameterization
- CSV Data Set Configs for each thread group
- Response and duration assertions
- Aggregate Report and View Results Tree listeners

**This file was generated using the Stage 3 prompt!**

### 4. test-data-*.csv files
Test data organized by account size:
- **small-accounts.csv**: 20 accounts with 18-35 positions (avg 26)
- **medium-accounts.csv**: 10 accounts with 100-140 positions (avg 120)
- **large-accounts.csv**: 5 accounts with 300-400 positions (avg 350)
- **xlarge-accounts.csv**: 2 accounts with 700-800 positions (avg 750)

**These files were generated using the Stage 4 prompt!**

### 5. results-analysis.md
Example interpretation of JMeter results showing:
- Pass/Fail against SLAs
- Performance observations
- Bottleneck identification
- Recommendations for optimization

**This analysis was generated using the Stage 6 prompt!**

---

## Adapting This Example for Your API

### Step 1: Analyze Your Production Data

Replace [production-data-analysis.md](production-data-analysis.md) with your own analysis:
- Query your production logs/metrics
- Group API calls by payload size or data volume
- Calculate percentages for each group
- Determine average response times per group

### Step 2: Update the Test Plan

Modify [test-plan.md](test-plan.md) with your details:
- API endpoint (e.g., `/api/v2/portfolios/{id}/transactions`)
- Authentication method (Bearer token, OAuth, API key)
- Your performance SLAs
- Your load distribution

### Step 3: Regenerate .jmx

Use the Stage 3 prompt with your updated test plan to generate a new .jmx file.

### Step 4: Create Your Test Data

Use the Stage 4 prompt to generate CSV files matching your data categories.

### Step 5: Execute and Validate

Run your test and verify:
- Weighted average response time matches production
- Load distribution is correct (check thread counts)
- SLAs are met
- Error rate is acceptable

---

## Troubleshooting

### Issue: CSV File Not Found
**Error**: `java.io.FileNotFoundException`

**Solution**:
1. Update CSV Data Set Config paths to absolute paths
2. Verify files exist: `ls test-data-*.csv`
3. Check file permissions: `chmod 644 test-data-*.csv`

### Issue: High Error Rate (> 5%)
**Possible Causes**:
- Invalid account IDs in CSV files
- Authentication token expired
- API endpoint incorrect or unavailable
- Network connectivity issues

**Solution**:
1. Check View Results Tree for error messages
2. Verify one request manually using curl:
   ```bash
   curl -H "Authorization: Bearer TOKEN" \
        https://api.example.com/api/v1/accounts/ACC10001/positions
   ```
3. Update CSV with valid account IDs

### Issue: Response Times Much Slower Than Expected
**Possible Causes**:
- Test environment different from production (smaller instances)
- Network latency (local JMeter vs remote API)
- Cold start (first requests always slower)

**Solution**:
1. Run longer test to allow warmup (10+ minutes)
2. Compare apples-to-apples (same environment)
3. Check thread ramp-up period (too fast = resource contention)

### Issue: Weighted Average Doesn't Match Calculation
**Possible Causes**:
- Thread distribution incorrect
- Sample sizes too small
- Think time between requests

**Solution**:
1. Verify thread counts: 60, 30, 9, 1
2. Run longer test for more samples
3. Check that test duration is sufficient (5+ minutes)

---

## Next Steps

### Beginner
1. Run this example as-is to understand the output
2. Modify thread counts (e.g., change 60/30/9/1 to 50/40/8/2)
3. Add a new endpoint to the test plan

### Intermediate
1. Generate your own .jmx using the 6-stage workflow
2. Create a similar test for your team's API
3. Integrate into CI/CD pipeline

### Advanced
1. Add complex authentication flows (OAuth)
2. Chain multiple API calls (login → get account → get positions)
3. Extract data from responses using JSON Extractor
4. Implement conditional logic based on response values

---

## Related Examples

- **[REST API Performance Test](../rest-api-performance-test/)** - Simpler example with uniform load
- **[Multi-Endpoint Load Test](../multi-endpoint-load-test/)** - Testing multiple APIs simultaneously

---

## Support

Questions about this example? Check:
- [Getting Started Guide](../../docs/getting-started.md#common-issues--solutions)
- [Troubleshooting Guide](../../docs/guides/troubleshooting.md)
- [JMeter Execution Guide](../../docs/guides/jmeter-execution-guide.md)

---

**Last Updated**: January 2026
**Example Version**: 1.0.0
