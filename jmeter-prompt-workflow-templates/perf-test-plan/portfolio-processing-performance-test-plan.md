# Portfolio Processing Service - Production-Ready Performance Test Plan

**Service**: Portfolio Processing API (Google Cloud Run)
**Endpoint**: `https://process-portfolio-4bzwg5efpa-uc.a.run.app`
**Test Plan Version**: 1.1
**Last Updated**: January 13, 2026
**Test Engineer**: Performance Engineering Team

---

## 1. Executive Summary

This performance test plan validates the Portfolio Processing Service's ability to handle production load patterns with strict production-grade SLAs. The service processes varying portfolio sizes (3 to 580 holdings) with response times correlating to payload complexity.

**Key Performance Requirements**:
- ✅ CPU Utilization < 80%
- ✅ Memory Utilization < 80%
- ✅ Error Rate ≤ 2% (98% success rate minimum)
- ✅ Response time targets vary by payload size (see Section 3)

**Test Scenarios**:
1. **Baseline Load**: 1,450,000 hits/day (current average daily traffic)
2. **Peak Load**: 1,740,000 hits/day (20% growth projection)

---

## 2. Test Objectives

### Primary Objectives
1. **Validate Production Readiness**: Confirm the service meets all SLAs under baseline and peak load
2. **Identify Performance Bottlenecks**: Detect CPU, memory, or I/O constraints before production deployment
3. **Establish Performance Baseline**: Document response time characteristics for each payload size category
4. **Validate Auto-Scaling**: Ensure Google Cloud Run scales appropriately under load
5. **Stress Test Resource Limits**: Verify graceful degradation when approaching SLA thresholds

### Success Criteria
- ✅ All response time SLAs met for 95th percentile across all payload sizes
- ✅ Error rate remains ≤ 2% for entire test duration
- ✅ CPU utilization peaks below 80%
- ✅ Memory utilization peaks below 80%
- ✅ No resource exhaustion errors (OOMKilled, throttling)
- ✅ Auto-scaling responds within 30 seconds to load increases

---

## 3. Service Level Agreements (SLAs)

### 3.1 Response Time SLAs (95th Percentile)

Based on payload complexity and production analysis:

| Payload Size | Holdings Count | Response Time SLA (95th %ile) | Expected Avg Response Time |
|--------------|----------------|-------------------------------|----------------------------|
| **Small** | 3 assets | ≤ 200ms | ~120ms |
| **Small** | 10 assets | ≤ 250ms | ~150ms |
| **Medium** | 67 assets | ≤ 800ms | ~500ms |
| **Large** | 105 assets | ≤ 1,200ms | ~750ms |
| **XLarge** | 245 assets | ≤ 2,500ms | ~1,800ms |
| **XXLarge** | 580 assets | ≤ 5,000ms | ~3,500ms |

**Rationale**: Response time increases non-linearly with portfolio size due to:
- External API calls for each holding (market data, pricing)
- Data aggregation and calculation complexity
- Network I/O for external service calls

### 3.2 Infrastructure SLAs

| Metric | SLA Threshold | Measurement Method |
|--------|---------------|-------------------|
| **CPU Utilization** | < 80% | Google Cloud Monitoring (container/cpu/utilization) |
| **Memory Utilization** | < 80% | Google Cloud Monitoring (container/memory/utilization) |
| **Error Rate** | ≤ 2% | HTTP 5xx responses / Total requests |
| **Success Rate** | ≥ 98% | HTTP 2xx responses / Total requests |

### 3.3 Availability SLAs

- **Service Uptime**: 100% during test execution (no planned downtime)
- **Cold Start Time**: ≤ 5 seconds for new Cloud Run instances
- **Auto-Scale Response**: New instances available within 30 seconds of load spike

---

## 4. Load Distribution & Payload Strategy

### 4.1 Production Traffic Analysis

Based on 30-day production data analysis:

| Payload Size | Holdings | % of Total Traffic | Calls/Day (Baseline) | Calls/Day (Peak) |
|--------------|----------|-------------------|----------------------|------------------|
| Small | 3 | 35% | 507,500 | 609,000 |
| Small | 10 | 35% | 507,500 | 609,000 |
| Medium | 67 | 20% | 290,000 | 348,000 |
| Large | 105 | 7% | 101,500 | 121,800 |
| XLarge | 245 | 2% | 29,000 | 34,800 |
| XXLarge | 580 | 1% | 14,500 | 17,400 |
| **Total** | — | **100%** | **1,450,000** | **1,740,000** |

### 4.2 Test Duration & Time Compression

**Production Window**: Daily traffic distributed over 8-hour business window (08:00-16:00 PST)

**Test Duration**: 30 minutes (time-compressed simulation)

**Compression Ratios**:
- **Baseline Test**: 8 hours → 30 minutes = 16× compression
- **Peak Test**: 8 hours → 30 minutes = 16× compression

### 4.3 Transactions Per Second (TPS) Requirements

#### Baseline Scenario (1,450,000 hits/day)

**8-Hour Business Window Model**:
- Hits per hour: 1,450,000 ÷ 8 = 181,250 hits/hour
- Hits per second: 181,250 ÷ 3,600 = **50.35 TPS**

**30-Minute Compressed Test**:
- Total hits in 30 minutes: 50.35 TPS × 1,800 seconds = **90,625 hits**

#### Peak Scenario (1,740,000 hits/day)

**8-Hour Business Window Model**:
- Hits per hour: 1,740,000 ÷ 8 = 217,500 hits/hour
- Hits per second: 217,500 ÷ 3,600 = **60.42 TPS**

**30-Minute Compressed Test**:
- Total hits in 30 minutes: 60.42 TPS × 1,800 seconds = **108,750 hits**

---

## 5. JMeter Test Architecture

### 5.1 Thread Group Configuration

Using **6 Thread Groups** (one per payload size) to maintain production distribution:

#### Baseline Scenario (50.35 TPS total)

| Thread Group | Payload Size | % Traffic | Target TPS | Estimated Response Time | Think Time | Threads Needed |
|--------------|--------------|-----------|------------|-------------------------|------------|----------------|
| TG-Small-3 | 3 holdings | 35% | 17.62 | 0.12s | 0.5s | **11 threads** |
| TG-Small-10 | 10 holdings | 35% | 17.62 | 0.15s | 0.5s | **12 threads** |
| TG-Medium-67 | 67 holdings | 20% | 10.07 | 0.50s | 0.5s | **11 threads** |
| TG-Large-105 | 105 holdings | 7% | 3.52 | 0.75s | 0.5s | **5 threads** |
| TG-XLarge-245 | 245 holdings | 2% | 1.01 | 1.80s | 0.5s | **3 threads** |
| TG-XXLarge-580 | 580 holdings | 1% | 0.50 | 3.50s | 0.5s | **2 threads** |
| **Total** | — | **100%** | **50.35 TPS** | — | — | **44 threads** |

#### Peak Scenario (60.42 TPS total)

| Thread Group | Payload Size | % Traffic | Target TPS | Estimated Response Time | Think Time | Threads Needed |
|--------------|--------------|-----------|------------|-------------------------|------------|----------------|
| TG-Small-3 | 3 holdings | 35% | 21.15 | 0.12s | 0.5s | **14 threads** |
| TG-Small-10 | 10 holdings | 35% | 21.15 | 0.15s | 0.5s | **14 threads** |
| TG-Medium-67 | 67 holdings | 20% | 12.08 | 0.50s | 0.5s | **13 threads** |
| TG-Large-105 | 105 holdings | 7% | 4.23 | 0.75s | 0.5s | **6 threads** |
| TG-XLarge-245 | 245 holdings | 2% | 1.21 | 1.80s | 0.5s | **3 threads** |
| TG-XXLarge-580 | 580 holdings | 1% | 0.60 | 3.50s | 0.5s | **3 threads** |
| **Total** | — | **100%** | **60.42 TPS** | — | — | **53 threads** |

**Thread Calculation Formula**: `Threads = TPS × (Response Time + Think Time) × Headroom Factor`
- Headroom Factor: 1.2 (20% buffer for variability)
- Think Time: 0.5s (simulates user delay between requests)

### 5.2 Rate Control Strategy

**Use Precise Throughput Timer** for each thread group to maintain constant rate:

- **Timer Mode**: `This thread only` (each thread group controls its own rate)
- **Target Throughput**: Calculated TPS per thread group
- **Calculate Throughput Based On**: `All active threads` (distribute load evenly)
- **Randomize Throughput**: No (consistent rate required)

**Why Precise Throughput Timer?**
- Open-loop model (rate-driven, not thread-looping)
- Decouples thread count from TPS (more realistic)
- Prevents backpressure from slow responses affecting rate

### 5.3 Ramp-Up Strategy

| Phase | Duration | Behavior | Purpose |
|-------|----------|----------|---------|
| **Ramp-Up** | 2 minutes | Linear increase from 0% to 100% target TPS | Gradual load increase, allow auto-scaling |
| **Steady State** | 25 minutes | Hold at 100% target TPS | Sustained load, validate stability |
| **Ramp-Down** | 3 minutes | Linear decrease from 100% to 0% | Graceful shutdown, observe scale-down |
| **Total** | 30 minutes | — | — |

**Implementation**: Use JMeter Ultimate Thread Group plugin for precise ramp-up control.

### 5.4 JMeter Components Required

```
Test Plan: Portfolio Processing Performance Test
├── User Defined Variables (Global)
│   └── testdata_dir: ${__P(testdata.dir,./testdata)}
├── Thread Group: TG-Small-3
│   ├── JSR223 PreProcessor: Load JSON File (holdings_3_*.json)
│   ├── Precise Throughput Timer: 17.62 TPS (baseline) / 21.15 TPS (peak)
│   ├── HTTP Request: POST /process-portfolio
│   │   └── Body Data: ${requestBody}
│   ├── Response Assertion: HTTP 200
│   └── Duration Assertion: < 200ms
├── Thread Group: TG-Small-10
│   ├── JSR223 PreProcessor: Load JSON File (holdings_10_*.json)
│   ├── Precise Throughput Timer: 17.62 TPS (baseline) / 21.15 TPS (peak)
│   ├── HTTP Request: POST /process-portfolio
│   │   └── Body Data: ${requestBody}
│   ├── Response Assertion: HTTP 200
│   └── Duration Assertion: < 250ms
├── Thread Group: TG-Medium-67
│   ├── JSR223 PreProcessor: Load JSON File (holdings_67_*.json)
│   ├── Precise Throughput Timer: 10.07 TPS (baseline) / 12.08 TPS (peak)
│   ├── HTTP Request: POST /process-portfolio
│   │   └── Body Data: ${requestBody}
│   ├── Response Assertion: HTTP 200
│   └── Duration Assertion: < 800ms
├── Thread Group: TG-Large-105
│   ├── JSR223 PreProcessor: Load JSON File (holdings_105_*.json)
│   ├── Precise Throughput Timer: 3.52 TPS (baseline) / 4.23 TPS (peak)
│   ├── HTTP Request: POST /process-portfolio
│   │   └── Body Data: ${requestBody}
│   ├── Response Assertion: HTTP 200
│   └── Duration Assertion: < 1200ms
├── Thread Group: TG-XLarge-245
│   ├── JSR223 PreProcessor: Load JSON File (holdings_245_*.json)
│   ├── Precise Throughput Timer: 1.01 TPS (baseline) / 1.21 TPS (peak)
│   ├── HTTP Request: POST /process-portfolio
│   │   └── Body Data: ${requestBody}
│   ├── Response Assertion: HTTP 200
│   └── Duration Assertion: < 2500ms
├── Thread Group: TG-XXLarge-580
│   ├── JSR223 PreProcessor: Load JSON File (holdings_580_*.json)
│   ├── Precise Throughput Timer: 0.50 TPS (baseline) / 0.60 TPS (peak)
│   ├── HTTP Request: POST /process-portfolio
│   │   └── Body Data: ${requestBody}
│   ├── Response Assertion: HTTP 200
│   └── Duration Assertion: < 5000ms
├── HTTP Header Manager (Global)
│   ├── Content-Type: application/json
│   └── Accept: application/json
├── Backend Listener: InfluxDB (for real-time monitoring)
├── Aggregate Report Listener
└── View Results Tree Listener (for debugging only, disable for full test)
```

**JSR223 PreProcessor Configuration**:
- **Script Language**: Groovy
- **Cache compiled script**: ✅ Enabled (critical for performance)
- **Parameters**: Holdings count (e.g., `3`, `10`, `67`, etc.)
- **Script**: See Appendix C for complete Groovy implementation

---

## 6. Test Data Strategy

### 6.1 JSON File Structure

Each payload size uses dedicated JSON files stored in the `testdata/` directory:

**File Naming Convention**: `holdings_{count}_{unique_id}.json`

**Available Test Data Files**:
- `holdings_3_411929.json` (3 holdings)
- `holdings_10_109757.json` (10 holdings)
- `holdings_67_981936.json` (67 holdings)
- `holdings_105_615062.json` (105 holdings)
- `holdings_245_358040.json` (245 holdings)
- `holdings_580_491573.json` (580 holdings)

**JSON File Structure**:
```json
{
  "holdings": [
    "AAPL",
    "GOOG",
    "TSLA"
  ]
}
```

**Example**: `holdings_10_109757.json`
```json
{
  "holdings": [
    "AAPL", "MSFT", "GOOG", "AMZN", "TSLA",
    "META", "NVDA", "JPM", "V", "WMT"
  ]
}
```

**Data Loading Strategy**:
- JSR223 PreProcessor loads JSON files using Groovy's `JsonSlurper`
- Files are discovered dynamically by pattern matching `holdings_{count}_*.json`
- Request body is serialized to JSON string using `JsonOutput.toJson()`
- Each thread group targets a specific holdings count size

### 6.2 Test Data Requirements

| Payload Size | Holdings | JSON File | Files Available | Usage Pattern |
|--------------|----------|-----------|-----------------|---------------|
| Small (3) | 3 | holdings_3_*.json | 1 file | Single file, reused for all requests |
| Small (10) | 10 | holdings_10_*.json | 1 file | Single file, reused for all requests |
| Medium (67) | 67 | holdings_67_*.json | 1 file | Single file, reused for all requests |
| Large (105) | 105 | holdings_105_*.json | 1 file | Single file, reused for all requests |
| XLarge (245) | 245 | holdings_245_*.json | 1 file | Single file, reused for all requests |
| XXLarge (580) | 580 | holdings_580_*.json | 1 file | Single file, reused for all requests |

**JSON File Location**: `testdata/` directory (relative to JMeter test plan)

**JSR223 Configuration Settings**:
- **Script Caching**: `Enabled` (compile once, reuse for all iterations)
- **File Loading**: Pattern-based discovery (`holdings_{count}_*.json`)
- **Error Handling**: Fail thread if JSON file not found or malformed
- **Thread Isolation**: Each thread loads JSON independently (thread-safe)

**Performance Optimization**:
- JSON files are loaded once per thread and cached in JMeter variables
- `JsonSlurper` parsing occurs only on first iteration
- Subsequent requests reuse the serialized `requestBody` variable
- No file I/O overhead during steady-state load

### 6.3 Test Data Generation Script

Test data is generated using the Python script located at:
- **Path**: `scripts/generate_holdings.py`
- **Purpose**: Generate JSON files with random stock symbol holdings
- **Output**: `testdata/holdings_{NUM_HOLDINGS}_{RANDOM_ID}.json`

**Usage**:
```bash
cd scripts/
python3 generate_holdings.py
```

**Configuration**:
Edit `NUM_HOLDINGS` variable in the script to generate different payload sizes:
```python
NUM_HOLDINGS = 580  # Set to 3, 10, 67, 105, 245, or 580
```

**Output Example**:
```
✅ Generated 580 holdings
📁 Output file: testdata/holdings_580_491573.json
📊 Sample: ['UJCW', 'RFHV', 'BSQP', 'XMTN', 'QPLA']...
```

See **Appendix A** for the complete script implementation and additional details.

---

## 7. Monitoring & Observability

### 7.1 Google Cloud Monitoring Metrics

**Required Dashboards**:
1. **Cloud Run Service Metrics**:
   - `run.googleapis.com/container/cpu/utilization` (target: < 80%)
   - `run.googleapis.com/container/memory/utilization` (target: < 80%)
   - `run.googleapis.com/request_count` (total requests)
   - `run.googleapis.com/request_latencies` (P50, P95, P99)
   - `run.googleapis.com/container/instance_count` (auto-scaling behavior)

2. **HTTP Response Metrics**:
   - `run.googleapis.com/request/response_code_class` (2xx, 4xx, 5xx counts)
   - Error rate calculation: `5xx_count / total_count` (target: ≤ 2%)

3. **Billing Metrics**:
   - `run.googleapis.com/container/billable_instance_time` (cost tracking)

### 7.2 JMeter Real-Time Monitoring

**Backend Listener Configuration** (InfluxDB + Grafana):
- **InfluxDB URL**: `http://monitoring-server:8086/write?db=jmeter`
- **Measurement Name**: `portfolio_perf_test`
- **Metrics Exported**:
  - Response time percentiles (P90, P95, P99)
  - Error rate per thread group
  - Throughput (actual vs target TPS)
  - Active threads over time

**Grafana Dashboards**:
- Real-time response time graph (all thread groups)
- Error rate heatmap
- TPS achieved vs TPS target comparison
- Thread count vs response time correlation

### 7.3 Alerting Thresholds

Configure alerts for immediate notification:

| Metric | Warning Threshold | Critical Threshold | Action |
|--------|-------------------|-------------------|--------|
| CPU Utilization | > 70% | > 80% | Pause test, investigate |
| Memory Utilization | > 70% | > 80% | Pause test, investigate |
| Error Rate | > 1% | > 2% | Continue monitoring / Stop test |
| P95 Response Time | > SLA + 20% | > SLA + 50% | Review performance |
| Instance Count | > 20 instances | > 30 instances | Check for runaway scaling |

---

## 8. Test Execution Plan

### 8.1 Pre-Test Checklist

**Infrastructure Readiness**:
- [ ] Google Cloud Run service deployed to production-equivalent environment
- [ ] Minimum instance count: 2 (avoid cold starts)
- [ ] Maximum instance count: 50 (prevent runaway scaling)
- [ ] CPU allocation: 2 vCPU per instance
- [ ] Memory allocation: 2GB per instance
- [ ] Request timeout: 10 seconds
- [ ] Concurrency: 80 requests per instance

**JMeter Environment**:
- [ ] JMeter version 5.6.3 installed
- [ ] Ultimate Thread Group plugin installed
- [ ] Precise Throughput Timer plugin installed
- [ ] JSON test data files available in `testdata/` folder
- [ ] All 6 holdings files validated (3, 10, 67, 105, 245, 580)
- [ ] JSR223 Groovy script caching enabled in `user.properties`
- [ ] InfluxDB backend listener configured
- [ ] JMeter heap size: `-Xms2g -Xmx4g` (for load generator)

**Monitoring Setup**:
- [ ] Google Cloud Monitoring dashboard configured
- [ ] Grafana dashboard created for JMeter metrics
- [ ] Alerting rules configured
- [ ] Log aggregation enabled (Cloud Logging)

**Smoke Test**:
- [ ] Run 1-minute smoke test with 5 threads per thread group
- [ ] Validate all endpoints return HTTP 200
- [ ] Validate JSON file loading and parsing works for all 6 payload sizes
- [ ] Verify request body serialization is correct (check JMeter logs)
- [ ] Validate monitoring data flows to dashboards

### 8.2 Test Execution Timeline

| Time | Activity | Duration | Responsible |
|------|----------|----------|-------------|
| T-60 min | Pre-test checklist validation | 30 min | QA Engineer |
| T-30 min | Start monitoring dashboards | 5 min | Performance Engineer |
| T-25 min | Run smoke test (1 min) | 5 min | QA Engineer |
| T-20 min | Review smoke test results | 10 min | Performance Engineer |
| T-10 min | Prepare baseline test execution | 10 min | QA Engineer |
| **T+0** | **Start Baseline Test (1.45M/day)** | **30 min** | **QA Engineer** |
| T+30 min | Collect baseline results | 10 min | Performance Engineer |
| T+40 min | Review baseline pass/fail | 15 min | Performance Engineer + QA |
| T+55 min | Prepare peak test execution | 5 min | QA Engineer |
| **T+60** | **Start Peak Test (1.74M/day)** | **30 min** | **QA Engineer** |
| T+90 min | Collect peak results | 10 min | Performance Engineer |
| T+100 min | Review peak pass/fail | 15 min | Performance Engineer + QA |
| T+115 min | Generate executive summary report | 30 min | Performance Engineer |
| **Total** | **End-to-End Test Execution** | **~3 hours** | **Team** |

### 8.3 JMeter Execution Command

**Baseline Test**:
```bash
jmeter -n -t portfolio-baseline-test.jmx \
  -l baseline-results.jtl \
  -e -o baseline-html-report/ \
  -Jthreads_small_3=11 \
  -Jthreads_small_10=12 \
  -Jthreads_medium_67=11 \
  -Jthreads_large_105=5 \
  -Jthreads_xlarge_245=3 \
  -Jthreads_xxlarge_580=2 \
  -Jtps_small_3=17.62 \
  -Jtps_small_10=17.62 \
  -Jtps_medium_67=10.07 \
  -Jtps_large_105=3.52 \
  -Jtps_xlarge_245=1.01 \
  -Jtps_xxlarge_580=0.50
```

**Peak Test**:
```bash
jmeter -n -t portfolio-peak-test.jmx \
  -l peak-results.jtl \
  -e -o peak-html-report/ \
  -Jthreads_small_3=14 \
  -Jthreads_small_10=14 \
  -Jthreads_medium_67=13 \
  -Jthreads_large_105=6 \
  -Jthreads_xlarge_245=3 \
  -Jthreads_xxlarge_580=3 \
  -Jtps_small_3=21.15 \
  -Jtps_small_10=21.15 \
  -Jtps_medium_67=12.08 \
  -Jtps_large_105=4.23 \
  -Jtps_xlarge_245=1.21 \
  -Jtps_xxlarge_580=0.60
```

---

## 9. Pass/Fail Criteria

### 9.1 Response Time Criteria

Each payload size must meet its SLA for **95th percentile response time**:

| Payload Size | SLA (P95) | Pass Criteria | Fail Criteria |
|--------------|-----------|---------------|---------------|
| Small (3) | ≤ 200ms | P95 ≤ 200ms | P95 > 200ms |
| Small (10) | ≤ 250ms | P95 ≤ 250ms | P95 > 250ms |
| Medium (67) | ≤ 800ms | P95 ≤ 800ms | P95 > 800ms |
| Large (105) | ≤ 1,200ms | P95 ≤ 1,200ms | P95 > 1,200ms |
| XLarge (245) | ≤ 2,500ms | P95 ≤ 2,500ms | P95 > 2,500ms |
| XXLarge (580) | ≤ 5,000ms | P95 ≤ 5,000ms | P95 > 5,000ms |

**Validation Query**:
```sql
SELECT
  sampler_label,
  PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY elapsed) AS p95_response_time
FROM jmeter_results
WHERE elapsed > 0
GROUP BY sampler_label;
```

### 9.2 Infrastructure Criteria

| Metric | Pass Criteria | Fail Criteria |
|--------|---------------|---------------|
| **CPU Utilization (Max)** | < 80% | ≥ 80% |
| **Memory Utilization (Max)** | < 80% | ≥ 80% |
| **Error Rate** | ≤ 2% | > 2% |
| **Success Rate** | ≥ 98% | < 98% |

**Cloud Monitoring Query (CPU)**:
```
fetch cloud_run_revision
| metric 'run.googleapis.com/container/cpu/utilization'
| filter resource.service_name == 'process-portfolio'
| group_by 1m, [value_utilization_max: max(value.utilization)]
| every 1m
```

### 9.3 Throughput Criteria

**Achieved TPS must be within 5% of target TPS**:

| Test Scenario | Target TPS | Min Acceptable TPS | Max Acceptable TPS |
|---------------|------------|-------------------|-------------------|
| Baseline | 50.35 | 47.83 (95%) | 52.87 (105%) |
| Peak | 60.42 | 57.40 (95%) | 63.44 (105%) |

**Validation**:
```bash
# Extract achieved TPS from JMeter results
awk -F',' 'NR>1 {sum+=$1} END {print "Achieved TPS:", sum/(NR-1)}' baseline-results.jtl
```

### 9.4 Overall Pass/Fail Logic

**PASS** if ALL conditions are met:
1. ✅ All payload sizes meet P95 response time SLAs
2. ✅ Error rate ≤ 2%
3. ✅ CPU utilization < 80%
4. ✅ Memory utilization < 80%
5. ✅ Achieved TPS within 5% of target

**FAIL** if ANY condition fails:
- ❌ One or more payload sizes exceed P95 SLA
- ❌ Error rate > 2%
- ❌ CPU utilization ≥ 80%
- ❌ Memory utilization ≥ 80%
- ❌ Achieved TPS outside 5% tolerance

**CONDITIONAL PASS** (requires stakeholder review):
- ⚠️ Minor SLA breach (< 10% over target) with mitigating factors
- ⚠️ Error rate between 2-3% with identified root cause and remediation plan

---

## 10. Results Analysis Template

### 10.1 Aggregate Results Table

| Thread Group | Sample Count | Avg (ms) | P50 (ms) | P90 (ms) | P95 (ms) | P99 (ms) | Error % | TPS Achieved | SLA (P95) | Pass/Fail |
|--------------|--------------|----------|----------|----------|----------|----------|---------|--------------|-----------|-----------|
| TG-Small-3 | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | 200ms | [FILL] |
| TG-Small-10 | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | 250ms | [FILL] |
| TG-Medium-67 | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | 800ms | [FILL] |
| TG-Large-105 | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | 1200ms | [FILL] |
| TG-XLarge-245 | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | 2500ms | [FILL] |
| TG-XXLarge-580 | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | 5000ms | [FILL] |
| **Overall** | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | [FILL] | — | [FILL] |

### 10.2 Infrastructure Metrics Table

| Metric | Baseline Test | Peak Test | SLA | Pass/Fail |
|--------|---------------|-----------|-----|-----------|
| **Max CPU Utilization** | [FILL]% | [FILL]% | < 80% | [FILL] |
| **Max Memory Utilization** | [FILL]% | [FILL]% | < 80% | [FILL] |
| **Avg Instance Count** | [FILL] | [FILL] | — | — |
| **Max Instance Count** | [FILL] | [FILL] | < 50 | [FILL] |
| **Cold Starts** | [FILL] | [FILL] | 0 (ideal) | [FILL] |
| **Error Rate** | [FILL]% | [FILL]% | ≤ 2% | [FILL] |

### 10.3 Bottleneck Analysis

**Instructions**: For each failed SLA, document root cause and recommendation.

#### Example:
**Issue**: TG-Large-105 P95 response time = 1,450ms (SLA: 1,200ms)
**Root Cause**: CPU throttling at 85% utilization during test minutes 15-25
**Evidence**: Cloud Monitoring shows CPU spikes correlated with large payload processing
**Recommendation**: Increase Cloud Run CPU allocation from 2 vCPU to 4 vCPU
**Risk**: Increased cost (~$50/month additional)
**Priority**: HIGH

---

## 11. Risk Mitigation

### 11.1 Identified Risks

| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|--------|---------------------|
| **Cold Start Latency** | Medium | High | Set minimum instances to 2, warm up service with smoke test |
| **External API Throttling** | High | High | Coordinate with external API providers (market data), implement circuit breakers |
| **Auto-Scaling Delays** | Medium | Medium | Monitor instance count in real-time, extend ramp-up period if needed |
| **JSON File Not Found** | Low | High | Validate all 6 JSON files exist before test, implement error handling in Groovy script |
| **Network Bandwidth Limits** | Low | High | Run JMeter from same GCP region as Cloud Run service |
| **Memory Leaks** | Low | High | Monitor memory utilization closely, set max test duration |
| **Database Connection Pool Exhaustion** | Medium | High | Validate connection pool settings before test |

### 11.2 Contingency Plans

**If CPU > 80%**:
1. Pause test immediately
2. Review Cloud Run CPU allocation settings
3. Check for inefficient code paths (profiling)
4. Consider increasing CPU to 4 vCPU
5. Re-run test after mitigation

**If Memory > 80%**:
1. Pause test immediately
2. Check for memory leaks (heap dump analysis)
3. Review in-memory caching strategy
4. Consider increasing memory to 4GB
5. Re-run test after mitigation

**If Error Rate > 2%**:
1. Continue monitoring for 5 minutes (transient vs sustained)
2. Review error logs in Cloud Logging
3. Identify error type (timeout, 503, 500, connection refused)
4. If sustained > 5 minutes, stop test
5. Remediate root cause before re-running

**If External API Throttling**:
1. Implement exponential backoff with retries (2s, 4s, 8s)
2. Cache external API responses (Redis/Memcached)
3. Negotiate higher rate limits with providers
4. Consider synthetic responses for testing

---

## 12. Test Environment Specifications

### 12.1 Service Under Test (SUT)

**Google Cloud Run Configuration**:
```yaml
service: process-portfolio
region: us-central1
platform: managed
cpu: 2
memory: 2Gi
timeout: 10s
concurrency: 80
min-instances: 2
max-instances: 50
execution-environment: gen2
```

**Environment Variables**:
```bash
NODE_ENV=production
MARKET_DATA_API_URL=https://api.marketdata.example.com
MARKET_DATA_API_KEY=[REDACTED]
ENABLE_METRICS=true
LOG_LEVEL=info
```

### 12.2 Load Generator Infrastructure

**JMeter Server Specifications**:
- **Cloud Provider**: Google Cloud Platform (same region as SUT)
- **Instance Type**: n2-standard-4 (4 vCPU, 16GB RAM)
- **OS**: Ubuntu 22.04 LTS
- **JMeter Version**: 5.6.3
- **Java Version**: OpenJDK 17
- **Network**: Same VPC as Cloud Run service (minimize latency)

**JMeter JVM Configuration**:
```bash
export HEAP="-Xms2g -Xmx4g -XX:MaxMetaspaceSize=512m"
export JVM_ARGS="-XX:+UseG1GC -XX:MaxGCPauseMillis=100"
```

### 12.3 Monitoring Infrastructure

**InfluxDB** (for JMeter metrics):
- Version: 1.8
- Retention policy: 30 days
- Write buffer: 10,000 points

**Grafana** (for visualization):
- Version: 10.x
- Dashboards: 2 (JMeter metrics + Cloud Run metrics)

---

## 13. Post-Test Activities

### 13.1 Results Packaging

After test completion, package the following artifacts:

1. **JMeter Raw Results**:
   - `baseline-results.jtl` (JMeter raw log)
   - `peak-results.jtl`

2. **HTML Reports**:
   - `baseline-html-report/` (JMeter dashboard)
   - `peak-html-report/`

3. **Cloud Monitoring Exports**:
   - CPU utilization graph (CSV export)
   - Memory utilization graph (CSV export)
   - Request latency graph (CSV export)
   - Error rate graph (CSV export)

4. **Test Artifacts**:
   - `portfolio-baseline-test.jmx` (JMeter test plan)
   - `portfolio-peak-test.jmx`
   - All CSV test data files

5. **Analysis Report**:
   - `performance-test-analysis-report.md` (complete filled template from Section 10)

### 13.2 Results Distribution

**Stakeholders**:
- Engineering Manager: Executive summary (pass/fail, key metrics)
- Development Team: Full analysis report with bottlenecks
- DevOps/SRE: Infrastructure metrics and scaling behavior
- Product Owner: Response time SLA compliance

**Distribution Channels**:
- Slack: `#engineering-performance` (summary + link to full report)
- Confluence: Store full report in "Performance Testing" space
- Jira: Attach report to performance testing epic

### 13.3 Follow-Up Actions

**If All Tests PASS**:
- ✅ Approve service for production deployment
- ✅ Establish baseline metrics for production monitoring
- ✅ Configure production alerts based on test SLAs
- ✅ Schedule quarterly performance regression testing

**If Any Test FAILS**:
- ❌ Create Jira tickets for each failed SLA (priority: HIGH)
- ❌ Assign development team to investigate root causes
- ❌ Re-run test after remediation
- ❌ Block production deployment until all SLAs pass

**Continuous Improvement**:
- Document lessons learned
- Update test plan with new insights
- Refine thread group calculations if TPS variance > 5%
- Optimize CSV test data for more realistic patterns

---

## 14. Appendices

### Appendix A: Test Data Generation Script

**File**: `generate-portfolio-test-data.py`

```python
#!/usr/bin/env python3
"""
Generate CSV test data for Portfolio Processing performance testing.
Creates realistic portfolio holdings with varying sizes.
"""

import csv
import random
from typing import List

# S&P 500 tickers (sample - expand for full list)
TICKERS = [
    "AAPL", "MSFT", "GOOG", "AMZN", "TSLA", "META", "NVDA", "JPM", "V", "WMT",
    "UNH", "JNJ", "PG", "MA", "HD", "BAC", "XOM", "DIS", "CSCO", "ADBE",
    "CRM", "NFLX", "INTC", "PFE", "CVX", "TMO", "ABT", "COST", "ACN", "MRK",
    # Add more tickers as needed...
]

def generate_portfolio(portfolio_id: str, num_holdings: int) -> dict:
    """Generate a single portfolio with random holdings."""
    holdings = random.sample(TICKERS, min(num_holdings, len(TICKERS)))
    return {
        "portfolioId": portfolio_id,
        "holdings": f'[{",".join([f\'"{t}\' for t in holdings])}]'
    }

def write_csv(filename: str, data: List[dict]):
    """Write portfolio data to CSV file."""
    with open(filename, 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['portfolioId', 'holdings'])
        writer.writeheader()
        writer.writerows(data)
    print(f"✅ Created {filename} with {len(data)} records")

def main():
    configs = [
        ("payloads-small-3.csv", 3, 500, "P-SM3-"),
        ("payloads-small-10.csv", 10, 500, "P-SM10-"),
        ("payloads-medium-67.csv", 67, 200, "P-MD-"),
        ("payloads-large-105.csv", 105, 100, "P-LG-"),
        ("payloads-xlarge-245.csv", 245, 50, "P-XL-"),
        ("payloads-xxlarge-580.csv", 580, 30, "P-XXL-"),
    ]

    for filename, num_holdings, num_records, prefix in configs:
        data = [
            generate_portfolio(f"{prefix}{i:04d}", num_holdings)
            for i in range(1, num_records + 1)
        ]
        write_csv(filename, data)

    print("\n✅ All test data files generated successfully!")

if __name__ == "__main__":
    main()
```

**Usage**:
```bash
python3 generate-portfolio-test-data.py
```

---

### Appendix B: Cloud Monitoring Query Examples

**CPU Utilization (Max over test duration)**:
```
fetch cloud_run_revision
| metric 'run.googleapis.com/container/cpu/utilization'
| filter resource.service_name == 'process-portfolio'
| group_by 1m, [value_utilization_max: max(value.utilization)]
| every 1m
| within 30m
```

**Memory Utilization (Max over test duration)**:
```
fetch cloud_run_revision
| metric 'run.googleapis.com/container/memory/utilization'
| filter resource.service_name == 'process-portfolio'
| group_by 1m, [value_utilization_max: max(value.utilization)]
| every 1m
| within 30m
```

**Error Rate Calculation**:
```
fetch cloud_run_revision
| { metric 'run.googleapis.com/request_count'
    | filter resource.service_name == 'process-portfolio'
    | filter metric.response_code_class == '5xx'
    | group_by 1m, [error_count: sum(value.request_count)]
  ;
    metric 'run.googleapis.com/request_count'
    | filter resource.service_name == 'process-portfolio'
    | group_by 1m, [total_count: sum(value.request_count)]
  }
| ratio
| every 1m
| within 30m
```

**Request Latency (P95)**:
```
fetch cloud_run_revision
| metric 'run.googleapis.com/request_latencies'
| filter resource.service_name == 'process-portfolio'
| group_by 1m, [latency_p95: percentile(value.request_latencies, 95)]
| every 1m
| within 30m
```

---

### Appendix C: JMeter Configuration Snippets

**JSR223 PreProcessor - JSON File Loader (Generic)**:
```groovy
import groovy.json.JsonSlurper
import groovy.json.JsonOutput

// Get holdings count from parameters (set in Thread Group or as variable)
def holdingsCount = Parameters  // e.g., "3", "10", "67", etc.

// Get test data directory (from User Defined Variables)
def dataDir = vars.get("testdata_dir") ?: "./testdata"

// Find JSON file matching pattern: holdings_{count}_*.json
def jsonFile = new File(dataDir).listFiles()?.find { 
    it.name.startsWith("holdings_${holdingsCount}_") && it.name.endsWith(".json")
}

if (jsonFile && jsonFile.exists()) {
    // Parse JSON file
    def jsonData = new JsonSlurper().parse(jsonFile)
    
    // Serialize to JSON string for HTTP request body
    def requestBody = JsonOutput.toJson(jsonData)
    
    // Store in JMeter variable
    vars.put("requestBody", requestBody)
    vars.put("holdingsCount", jsonData.holdings.size().toString())
    
    log.info("✅ Loaded ${jsonFile.name} with ${jsonData.holdings.size()} holdings")
} else {
    log.error("❌ JSON file not found for holdings count: ${holdingsCount}")
    throw new Exception("Test data file missing: holdings_${holdingsCount}_*.json")
}
```

**JSR223 PreProcessor Configuration**:
- **Script Language**: `groovy`
- **Parameters**: `3` (or `10`, `67`, `105`, `245`, `580` depending on thread group)
- **Cache compiled script**: ✅ **Checked** (critical for performance)

**User Defined Variables (Global)**:
```
Name: testdata_dir
Value: ${__P(testdata.dir,./testdata)}
```

**HTTP Request Sampler (POST /process-portfolio)**:
```xml
<HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="POST /process-portfolio" enabled="true">
  <boolProp name="HTTPSampler.postBodyRaw">true</boolProp>
  <elementProp name="HTTPsampler.Arguments" elementType="Arguments">
    <collectionProp name="Arguments.arguments">
      <elementProp name="" elementType="HTTPArgument">
        <boolProp name="HTTPArgument.always_encode">false</boolProp>
        <stringProp name="Argument.value">${requestBody}</stringProp>
        <stringProp name="Argument.metadata">=</stringProp>
      </elementProp>
    </collectionProp>
  </elementProp>
  <stringProp name="HTTPSampler.domain">process-portfolio-4bzwg5efpa-uc.a.run.app</stringProp>
  <stringProp name="HTTPSampler.protocol">https</stringProp>
  <stringProp name="HTTPSampler.path">/</stringProp>
  <stringProp name="HTTPSampler.method">POST</stringProp>
  <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
  <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
</HTTPSamplerProxy>
```

**JMeter Properties Configuration (user.properties)**:
```properties
# Enable JSR223 script caching (critical for performance)
jsr223.compile_cache=100

# Test data directory (can be overridden via command line)
testdata.dir=./testdata

# Groovy optimization
groovy.use.classvalue=true
```

**Command Line Override**:
```bash
jmeter -n -t portfolio-baseline-test.jmx \
  -Jtestdata.dir=/path/to/testdata \
  -l results.jtl
```

**Duration Assertion (< 200ms for small portfolios)**:
```xml
<DurationAssertion guiclass="DurationAssertionGui" testclass="DurationAssertion" testname="Duration < 200ms" enabled="true">
  <stringProp name="DurationAssertion.duration">200</stringProp>
</DurationAssertion>
```

**Advanced: JSON File Caching (Optional Optimization)**:
```groovy
import groovy.json.JsonSlurper
import groovy.json.JsonOutput

def holdingsCount = Parameters
def cacheKey = "json_cache_${holdingsCount}"

// Check if JSON already loaded in thread variables
if (!vars.get(cacheKey)) {
    def dataDir = vars.get("testdata_dir") ?: "./testdata"
    def jsonFile = new File(dataDir).listFiles()?.find { 
        it.name.startsWith("holdings_${holdingsCount}_")
    }
    
    if (jsonFile?.exists()) {
        def jsonData = new JsonSlurper().parse(jsonFile)
        def requestBody = JsonOutput.toJson(jsonData)
        
        // Cache for entire thread lifecycle
        vars.put(cacheKey, "loaded")
        vars.put("requestBody", requestBody)
        
        log.info("🔄 Cached ${jsonFile.name} for thread ${ctx.getThreadNum()}")
    } else {
        throw new Exception("Test data file missing: holdings_${holdingsCount}_*.json")
    }
}
// Else: requestBody already exists, skip file I/O
```

---

## 15. Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-12 | Performance Engineering Team | Initial production-ready test plan |
| 1.1 | 2026-01-13 | Performance Engineering Team | Updated test data strategy from CSV to JSON files with JSR223 Groovy PreProcessors |

---

## 16. Approvals

| Role | Name | Signature | Date |
|------|------|-----------|------|
| **Performance Engineering Lead** | [NAME] | [SIGNATURE] | [DATE] |
| **QA Manager** | [NAME] | [SIGNATURE] | [DATE] |
| **Engineering Manager** | [NAME] | [SIGNATURE] | [DATE] |
| **DevOps Lead** | [NAME] | [SIGNATURE] | [DATE] |

---

**END OF PERFORMANCE TEST PLAN**
