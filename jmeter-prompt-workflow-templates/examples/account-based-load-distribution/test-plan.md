# Performance Test Plan: Account-Based Load Distribution

## Test Overview

**Test Name**: Portfolio API - Account-Based Load Distribution Test
**Application**: Portfolio Management System
**Environment**: Staging (production-like infrastructure)
**Test Type**: Load Test (sustained load)
**Duration**: 5 minutes (300 seconds)
**Test Date**: [TO BE SCHEDULED]

---

## Objectives

1. Validate that the Portfolio API can handle production-like load distribution across different account sizes
2. Verify that weighted average response time matches production baseline (~361ms)
3. Ensure 95th percentile response time meets SLA (< 600ms adjusted, originally < 500ms)
4. Identify performance degradation patterns for large accounts (500+ positions)
5. Establish performance baseline for future regression testing

---

## API Endpoint Specification

### Endpoint Details

**URL**: `/api/v1/accounts/{accountId}/positions`

**HTTP Method**: GET

**Description**: Retrieves all position holdings for a specified account

**Authentication**: Bearer Token (OAuth 2.0)

**Request Headers**:
```
Authorization: Bearer {access_token}
Content-Type: application/json
Accept: application/json
X-Client-Id: jmeter-load-test
```

**Path Parameters**:
- `accountId` (string, required): Unique account identifier (format: ACCXXXXX)

**Query Parameters**: None

**Request Body**: None (GET request)

**Response Format**: JSON

**Example Response**:
```json
{
  "accountId": "ACC10001",
  "accountName": "Small Portfolio A",
  "positionCount": 26,
  "positions": [
    {
      "symbol": "AAPL",
      "quantity": 100,
      "marketValue": 15000.00
    },
    ...
  ],
  "totalMarketValue": 450000.00,
  "lastUpdated": "2026-01-09T14:30:00Z"
}
```

**Expected Status Codes**:
- `200 OK`: Success
- `401 Unauthorized`: Invalid or expired token
- `404 Not Found`: Account ID does not exist
- `429 Too Many Requests`: Rate limit exceeded
- `500 Internal Server Error`: Server-side error

---

## Load Requirements

### Load Distribution (Production-Based)

Based on production data analysis (see [production-data-analysis.md](production-data-analysis.md)):

| Account Category | % of Traffic | Thread Count | CSV Data File | Avg Positions |
|-----------------|--------------|--------------|---------------|---------------|
| **Small Accounts** | 60% | 60 | test-data-small-accounts.csv | 26 |
| **Medium Accounts** | 30% | 30 | test-data-medium-accounts.csv | 120 |
| **Large Accounts** | 9% | 9 | test-data-large-accounts.csv | 350 |
| **XLarge Accounts** | 1% | 1 | test-data-xlarge-accounts.csv | 750 |

**Total Concurrent Users**: 100 threads

**Ramp-Up Period**: 60 seconds (gradual increase to avoid spike)

**Test Duration**: 300 seconds (5 minutes)

**Think Time**: 2000ms between requests (2 seconds)

---

## Performance SLAs

### Primary Metrics

| Metric | Target | Critical Threshold | Source |
|--------|--------|-------------------|--------|
| **Weighted Avg Response Time** | ~361ms | > 500ms = Fail | Production baseline |
| **95th Percentile Response Time** | < 600ms | > 800ms = Fail | Adjusted SLA |
| **Error Rate** | < 1% | > 5% = Fail | Production standard |
| **Throughput** | > 100 req/sec | < 80 req/sec = Fail | Production average |

### Per-Category SLAs

| Account Size | Avg Response Time Target | 95th Percentile Target |
|--------------|-------------------------|----------------------|
| Small (1-50 pos) | < 200ms | < 250ms |
| Medium (51-200 pos) | < 500ms | < 600ms |
| Large (201-500 pos) | < 1500ms | < 1800ms |
| XLarge (500+ pos) | < 3000ms | < 3500ms |

---

## Test Data Requirements

### Account Test Data

Generate CSV files with the following structure:

**CSV Format**:
```csv
accountId,accountName,positionCount,expectedResponseTime
ACC10001,Small Portfolio A,26,150
ACC10002,Small Portfolio B,18,130
```

### Data Volume

- **Small Accounts CSV**: 20 accounts (covers 60 threads with recycle)
- **Medium Accounts CSV**: 10 accounts (covers 30 threads with recycle)
- **Large Accounts CSV**: 5 accounts (covers 9 threads with recycle)
- **XLarge Accounts CSV**: 2 accounts (covers 1 thread with recycle)

**Total Test Accounts**: 37 unique accounts

### Data Characteristics

| CSV File | Position Range | Count Range | Realistic Values |
|----------|---------------|-------------|------------------|
| small-accounts.csv | 1-50 | 18-35 | Retirement accounts, new investors |
| medium-accounts.csv | 51-200 | 100-140 | Active traders, diversified portfolios |
| large-accounts.csv | 201-500 | 300-400 | High-net-worth, complex strategies |
| xlarge-accounts.csv | 500+ | 700-800 | Ultra-HNW, hedge funds, legacy accounts |

---

## Test Environment

### Infrastructure

**Environment**: Staging

**API Server**:
- Hostname: `api-staging.example.com`
- Protocol: HTTPS
- Port: 443
- Instance Type: AWS EC2 m5.xlarge (4 vCPU, 16 GB RAM)
- Count: 2 instances (behind load balancer)

**Database**:
- Type: PostgreSQL 14
- Instance: AWS RDS db.m5.large (2 vCPU, 8 GB RAM)
- Storage: 500 GB SSD

**Load Balancer**: AWS ALB (Application Load Balancer)

**Expected Capacity**:
- Staging environment is ~50% of production capacity
- Target: 100 concurrent users
- Expected throughput: 50-60 req/sec (vs 100 req/sec in production)

### Authentication

**OAuth 2.0 Bearer Token**:
- Token endpoint: `https://auth-staging.example.com/oauth/token`
- Token lifespan: 1 hour
- Refresh strategy: Generate new token before test execution

**Test Token Placeholder**: `[REPLACE_WITH_ACTUAL_TOKEN]`

---

## JMeter Configuration

### Thread Group Configuration

| Thread Group | Threads | Ramp-Up | Duration | Scheduler | CSV File |
|--------------|---------|---------|----------|-----------|----------|
| Small Accounts (60%) | 60 | 60s | 300s | Enabled | small-accounts.csv |
| Medium Accounts (30%) | 30 | 60s | 300s | Enabled | medium-accounts.csv |
| Large Accounts (9%) | 9 | 60s | 300s | Enabled | large-accounts.csv |
| XLarge Accounts (1%) | 1 | 60s | 300s | Enabled | xlarge-accounts.csv |

### HTTP Request Sampler Configuration

- **Server Name**: api-staging.example.com
- **Port**: 443
- **Protocol**: https
- **Path**: `/api/v1/accounts/${accountId}/positions`
- **Method**: GET
- **Follow Redirects**: Yes
- **Use KeepAlive**: Yes
- **Implementation**: HttpClient4

### Assertions

1. **Response Code Assertion**: Equals 200
2. **Duration Assertion**: Response time based on account size
   - Small accounts: < 250ms
   - Medium accounts: < 600ms
   - Large accounts: < 1800ms
   - XLarge accounts: < 3500ms
3. **JSON Assertion**: Response contains `accountId`, `positions`, `positionCount`

### Listeners

1. **Aggregate Report**: Save to `results-aggregate.csv`
2. **View Results Tree**: Enabled for first run (disable for full test)
3. **Summary Report**: Quick overview
4. **Response Time Graph**: Visual performance tracking

---

## Acceptance Criteria

### Test Passes If

- ✅ Weighted average response time is between 300-400ms
- ✅ 95th percentile response time < 600ms
- ✅ Error rate < 1%
- ✅ Throughput > 100 req/sec (adjusted for staging: > 50 req/sec)
- ✅ No server errors (5xx responses) exceeding 0.5%
- ✅ All thread groups complete without JMeter errors

### Test Fails If

- ❌ Weighted average response time > 500ms
- ❌ 95th percentile response time > 800ms
- ❌ Error rate > 5%
- ❌ Throughput < 80 req/sec (adjusted for staging: < 40 req/sec)
- ❌ Server errors > 2%
- ❌ JMeter thread failures or resource exhaustion

---

## Test Execution Steps

### Pre-Execution (15 minutes)

1. **Generate OAuth Token**:
   ```bash
   curl -X POST https://auth-staging.example.com/oauth/token \
     -d "grant_type=client_credentials" \
     -d "client_id=jmeter-load-test" \
     -d "client_secret=[SECRET]"
   ```
   Update token in JMeter User Defined Variables.

2. **Verify Test Data Files**:
   ```bash
   ls -lh test-data-*.csv
   wc -l test-data-*.csv
   ```

3. **Smoke Test** (1 thread, 1 minute):
   ```bash
   jmeter -n -t generated.jmx -l smoke-results.jtl \
     -Jthreads=1 -Jduration=60
   ```
   Verify 0% error rate before proceeding.

### Execution (5 minutes)

4. **Run Full Load Test**:
   ```bash
   jmeter -n -t generated.jmx -l results.jtl \
     -e -o reports/ \
     -Jthreads=100 -Jduration=300
   ```

5. **Monitor During Execution**:
   - Watch thread count ramp-up
   - Monitor error rate in real-time
   - Check server CPU/memory in CloudWatch

### Post-Execution (10 minutes)

6. **Generate HTML Report**:
   ```bash
   jmeter -g results.jtl -o html-report/
   ```

7. **Review Results**:
   - Open `html-report/index.html`
   - Check Aggregate Report CSV
   - Validate against acceptance criteria

8. **Document Findings**:
   - Copy results to `results-analysis.md`
   - Note any anomalies or failures
   - Provide recommendations

---

## Risks & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Authentication token expires mid-test | Low | High | Generate token immediately before test; verify 1-hour lifespan |
| Staging environment unstable | Medium | High | Run smoke test first; coordinate with DevOps |
| Test data accounts deleted/invalid | Low | High | Verify accounts exist in staging DB before test |
| Network latency from JMeter host | Medium | Medium | Run JMeter from AWS same region as staging |
| Resource exhaustion on JMeter host | Low | High | Monitor JMeter host CPU/memory; use distributed testing if needed |

---

## Success Metrics

### Technical Metrics
- Baseline performance established for regression testing
- Identified response time patterns by account size
- Validated load distribution matches production

### Business Metrics
- Confirmed staging environment can handle production load
- Identified optimization opportunities for large accounts
- Established confidence for production deployment

---

## Approvals

- **Test Plan Author**: Performance Engineering Team
- **Reviewed By**: QA Lead, [NAME]
- **Approved By**: Engineering Manager, [NAME]
- **Stakeholders Notified**: Product Management, DevOps

---

## Appendix A: Account ID Format

Valid account IDs follow the pattern:
- **Format**: `ACCXXXXX` where X is a digit (e.g., `ACC10001`)
- **Range**: ACC10001 - ACC99999
- **Test Data**: ACC10001 - ACC40002 (37 accounts)

---

## Appendix B: Expected Throughput Calculation

```
Total threads: 100
Think time: 2000ms (2 seconds)
Avg response time: 361ms

Requests per thread per second = 1 / (2 + 0.361) ≈ 0.42 req/sec
Total throughput = 100 threads × 0.42 req/sec ≈ 42 req/sec

Adjusted for no think time: ~120 req/sec theoretical max
Production-like with think time: 40-50 req/sec expected
```

---

**Test Plan Version**: 1.0
**Created**: January 2026
**Last Updated**: January 9, 2026
