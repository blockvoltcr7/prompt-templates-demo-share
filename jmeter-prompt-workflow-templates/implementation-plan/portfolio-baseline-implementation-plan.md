# Portfolio Baseline Performance Test - JMeter Implementation Plan

**Version:** 1.0
**Date:** 2026-01-13
**Test Plan Reference:** `portfolio-processing-performance-test-plan.md`
**Target Output:** `portfolio-baseline-test-no-groovy.jmx`

---

## 1. Executive Summary

This implementation plan defines the exact approach, components, and configurations required to implement the **Portfolio Baseline Performance Test** in Apache JMeter. The baseline test simulates production load with 50.35 TPS distributed across 6 payload sizes over a 30-minute test window (2min ramp-up → 28min steady-state).

### Prerequisites Validated
- ✅ **Authentication:** None required (pure API load test)
- ✅ **Test Data:** All 6 JSON files present and validated in `testdata/`
- ✅ **Monitoring:** JMeter HTML Dashboard Report (no external monitoring)
- ✅ **Scope:** Baseline test only (50.35 TPS target)

### Required JMeter Components
- **Standard Thread Group** - Built-in JMeter component (no plugins required)
- **Constant Throughput Timer** - Built-in JMeter timer for rate-based load control
- **__FileToString() Function** - Built-in function for loading JSON test data (Java 24+ compatible, no Groovy scripts)

**Installation:** No plugins required - uses only built-in JMeter components

---

## 2. Test Plan Architecture

### 2.1 Component Hierarchy

```
Test Plan: Portfolio Processing - Baseline Test (No Groovy - Java 24 Compatible)
│
├── User Defined Variables (UDV-TestConfig)
│
├── HTTP Header Manager (HTTP-Headers-JSON)
│
├── Thread Group 1: TG-Small-3-Baseline (Standard Thread Group)
│   ├── Constant Timer (Timer-ThinkTime-0.5s)
│   ├── Constant Throughput Timer (CTT-Small-3)
│   ├── HTTP Request (POST-PortfolioProcessing)
│   │   └── [Body Data: ${__FileToString(${TESTDATA_DIR}/holdings_3_411929.json,,)}]
│   ├── Response Assertion (Assert-HTTP200)
│   └── Duration Assertion (Assert-ResponseTime-Small3)
│
├── Thread Group 2: TG-Small-10-Baseline (Standard Thread Group)
│   ├── Constant Timer (Timer-ThinkTime-0.5s)
│   ├── Constant Throughput Timer (CTT-Small-10)
│   ├── HTTP Request (POST-PortfolioProcessing)
│   │   └── [Body Data: ${__FileToString(${TESTDATA_DIR}/holdings_10_109757.json,,)}]
│   ├── Response Assertion (Assert-HTTP200)
│   └── Duration Assertion (Assert-ResponseTime-Small10)
│
├── Thread Group 3: TG-Medium-67-Baseline (Standard Thread Group)
│   ├── Constant Timer (Timer-ThinkTime-0.5s)
│   ├── Constant Throughput Timer (CTT-Medium-67)
│   ├── HTTP Request (POST-PortfolioProcessing)
│   │   └── [Body Data: ${__FileToString(${TESTDATA_DIR}/holdings_67_981936.json,,)}]
│   ├── Response Assertion (Assert-HTTP200)
│   └── Duration Assertion (Assert-ResponseTime-Medium67)
│
├── Thread Group 4: TG-Large-105-Baseline (Standard Thread Group)
│   ├── Constant Timer (Timer-ThinkTime-0.5s)
│   ├── Constant Throughput Timer (CTT-Large-105)
│   ├── HTTP Request (POST-PortfolioProcessing)
│   │   └── [Body Data: ${__FileToString(${TESTDATA_DIR}/holdings_105_615062.json,,)}]
│   ├── Response Assertion (Assert-HTTP200)
│   └── Duration Assertion (Assert-ResponseTime-Large105)
│
├── Thread Group 5: TG-XLarge-245-Baseline (Standard Thread Group)
│   ├── Constant Timer (Timer-ThinkTime-0.5s)
│   ├── Constant Throughput Timer (CTT-XLarge-245)
│   ├── HTTP Request (POST-PortfolioProcessing)
│   │   └── [Body Data: ${__FileToString(${TESTDATA_DIR}/holdings_245_358040.json,,)}]
│   ├── Response Assertion (Assert-HTTP200)
│   └── Duration Assertion (Assert-ResponseTime-XLarge245)
│
├── Thread Group 6: TG-XXLarge-580-Baseline (Standard Thread Group)
│   ├── Constant Timer (Timer-ThinkTime-0.5s)
│   ├── Constant Throughput Timer (CTT-XXLarge-580)
│   ├── HTTP Request (POST-PortfolioProcessing)
│   │   └── [Body Data: ${__FileToString(${TESTDATA_DIR}/holdings_580_491573.json,,)}]
│   ├── Response Assertion (Assert-HTTP200)
│   └── Duration Assertion (Assert-ResponseTime-XXLarge580)
│
├── View Results Tree (Listener-Debug)
└── Aggregate Report (Listener-Summary)
```

---

## 3. Detailed Component Configurations

### 3.1 User Defined Variables (UDV-TestConfig)

**Element Type:** `User Defined Variables`
**Scope:** Test Plan Level (Global)
**Purpose:** Centralize configuration parameters for easy modification

| Variable Name | Value | Description |
|---------------|-------|-------------|
| `TESTDATA_DIR` | `${__P(testdata_dir,/Users/samisabir-idrissi/dev/personal/prompt-templates-demo-share/jmeter-prompt-workflow-templates/testdata)}` | Path to JSON test data directory |
| `TARGET_HOST` | `${__P(target_host,process-portfolio-4bzwg5efpa-uc.a.run.app)}` | Target server hostname/IP |
| `TARGET_PORT` | `${__P(target_port,443)}` | Target server port |
| `TARGET_PROTOCOL` | `${__P(target_protocol,https)}` | Protocol (http/https) |
| `TARGET_PATH` | `/` | API endpoint path |

**Parameterization:** Uses JMeter `__P()` function for command-line overrides:
```bash
jmeter -Jtarget_host=prod-api.example.com -Jtarget_port=443 -Jtarget_protocol=https
```

---

### 3.2 HTTP Header Manager (HTTP-Headers-JSON)

**Element Type:** `HTTP Header Manager`
**Scope:** Test Plan Level (applies to all HTTP requests)
**Purpose:** Set required HTTP headers for JSON POST requests

| Header Name | Value |
|-------------|-------|
| `Content-Type` | `application/json` |
| `Accept` | `application/json` |

---

### 3.3 Thread Groups Configuration

Each payload size requires its own **Standard Thread Group** with identical structure but different parameters.

#### 3.3.1 Standard Thread Group - General Settings

**Element Type:** `ThreadGroup` (built-in JMeter component)
**Action After Sampler Error:** Continue
**Number of Threads (threads):** Calculated per payload size
**Ramp-Up Period (seconds):** 120 seconds (2 minutes)
**Loop Count:** Forever (-1)
**Duration (seconds):** 1800 seconds (30 minutes)
**Scheduler:** Enabled (checkbox checked)
**Same user on each iteration:** True

#### 3.3.2 Thread Group Scheduler Configuration

Each Standard Thread Group uses the built-in scheduler with these settings:

| Parameter | Value | Description |
|-----------|-------|-------------|
| **Number of Threads** | Varies by payload size | Total virtual users for this thread group |
| **Ramp-Up Period** | 120 seconds | 2-minute gradual thread startup |
| **Loop Count** | -1 (Forever) | Continuous execution until duration expires |
| **Duration** | 1800 seconds | Total test duration (30 minutes) |
| **Startup Delay** | 0 seconds | All thread groups start immediately |
| **Scheduler** | Enabled | Use duration-based scheduling |

**Total Test Duration:** **1800 seconds (30 minutes)**

**Note:** Standard Thread Group does NOT have independent ramp-down control. All threads terminate when the 1800-second duration expires. For gradual ramp-down (like the original plan's 3-minute ramp-down), Ultimate Thread Group plugin would be required.

#### 3.3.3 Thread Group Specific Parameters

| Thread Group Name | Threads | Ramp-Up | Duration | TPS Target | CTT Value (req/min) | Response Time SLA | JSON File |
|-------------------|---------|---------|----------|------------|---------------------|-------------------|-----------|
| `TG-Small-3-Baseline` | 11 | 120s | 1800s | 17.62 TPS | 1057.2 | 300ms | `holdings_3_411929.json` |
| `TG-Small-10-Baseline` | 12 | 120s | 1800s | 17.62 TPS | 1057.2 | 400ms | `holdings_10_109757.json` |
| `TG-Medium-67-Baseline` | 11 | 120s | 1800s | 10.07 TPS | 604.2 | 800ms | `holdings_67_981936.json` |
| `TG-Large-105-Baseline` | 5 | 120s | 1800s | 3.52 TPS | 211.2 | 1200ms | `holdings_105_615062.json` |
| `TG-XLarge-245-Baseline` | 3 | 120s | 1800s | 1.01 TPS | 60.6 | 2500ms | `holdings_245_358040.json` |
| `TG-XXLarge-580-Baseline` | 2 | 120s | 1800s | 0.50 TPS | 30.0 | 5000ms | `holdings_580_491573.json` |

**Source:** Test Plan Lines 147-163

---

### 3.4 JSON Test Data Loading (No Groovy Scripts)

**Method:** `__FileToString()` built-in JMeter function
**Scope:** Each HTTP Request Body Data
**Purpose:** Load JSON test data directly from file without Groovy scripts (Java 24+ compatible)

#### 3.4.1 __FileToString() Function Syntax

**Function:** `${__FileToString(filePath,encoding,)}`

**Parameters:**
- `filePath`: Full path to JSON file (constructed using `${TESTDATA_DIR}` variable)
- `encoding`: Character encoding (optional, defaults to platform encoding)
- Third parameter: Empty (reserved for future use)

**Example Usage:**
```
${__FileToString(${TESTDATA_DIR}/holdings_3_411929.json,,)}
```

#### 3.4.2 JSON File Loading Per Thread Group

| Thread Group | JSON File | HTTP Request Body Data Expression |
|--------------|-----------|-----------------------------------|
| TG-Small-3-Baseline | `holdings_3_411929.json` | `${__FileToString(${TESTDATA_DIR}/holdings_3_411929.json,,)}` |
| TG-Small-10-Baseline | `holdings_10_109757.json` | `${__FileToString(${TESTDATA_DIR}/holdings_10_109757.json,,)}` |
| TG-Medium-67-Baseline | `holdings_67_981936.json` | `${__FileToString(${TESTDATA_DIR}/holdings_67_981936.json,,)}` |
| TG-Large-105-Baseline | `holdings_105_615062.json` | `${__FileToString(${TESTDATA_DIR}/holdings_105_615062.json,,)}` |
| TG-XLarge-245-Baseline | `holdings_245_358040.json` | `${__FileToString(${TESTDATA_DIR}/holdings_245_358040.json,,)}` |
| TG-XXLarge-580-Baseline | `holdings_580_491573.json` | `${__FileToString(${TESTDATA_DIR}/holdings_580_491573.json,,)}` |

**Advantages:**
- ✅ No Groovy script compilation (Java 24+ compatible)
- ✅ No JSR223 PreProcessor required
- ✅ Built-in JMeter function (no plugins)
- ✅ Simpler implementation and troubleshooting

**Performance Note:** The `__FileToString()` function reads the file on **every iteration**. For high-iteration tests, this may cause higher file I/O compared to Groovy-based caching. For the baseline test with moderate iteration counts (~31,716 max), this is acceptable.

---

### 3.5 Constant Timer Configuration

**Element Type:** `Constant Timer`
**Scope:** Each Thread Group (6 total)
**Purpose:** Simulate think time between requests

| Parameter | Value | Rationale |
|-----------|-------|-----------|
| **Thread Delay (ms)** | `500` | 0.5 second think time per test plan line 163 |
| **Timer Name** | `Timer-ThinkTime-0.5s` | Descriptive naming |

**Note:** Uses Constant Timer (fixed delay) rather than Gaussian/Uniform Random Timer to maintain predictable, deterministic load patterns. This aligns with the rate-based load model using Precise Throughput Timer.

---

### 3.6 Constant Throughput Timer Configuration

**Element Type:** `ConstantThroughputTimer` (built-in JMeter component)
**Scope:** Each Thread Group (6 total)
**Purpose:** Control request rate to achieve target TPS

#### 3.6.1 Configuration Parameters

| Parameter | Description | Value Calculation |
|-----------|-------------|-------------------|
| **Target throughput** | Requests per minute | TPS × 60 (e.g., 17.62 TPS = 1057.2 req/min) |
| **Calculate Throughput based on** | Scope of throughput calculation | `this thread group` (calcMode=0) |

**Important:** Constant Throughput Timer specifies throughput in **requests per minute**, not per second. The timer adds delays between requests to achieve the target rate.

#### 3.6.2 Per-Thread-Group Configuration

| Thread Group | CTT Name | TPS Target | Throughput (req/min) | calcMode |
|--------------|----------|------------|----------------------|----------|
| TG-Small-3-Baseline | `CTT-Small-3` | 17.62 TPS | 1057.2 | 0 (this thread group) |
| TG-Small-10-Baseline | `CTT-Small-10` | 17.62 TPS | 1057.2 | 0 (this thread group) |
| TG-Medium-67-Baseline | `CTT-Medium-67` | 10.07 TPS | 604.2 | 0 (this thread group) |
| TG-Large-105-Baseline | `CTT-Large-105` | 3.52 TPS | 211.2 | 0 (this thread group) |
| TG-XLarge-245-Baseline | `CTT-XLarge-245` | 1.01 TPS | 60.6 | 0 (this thread group) |
| TG-XXLarge-580-Baseline | `CTT-XXLarge-580` | 0.50 TPS | 30.0 | 0 (this thread group) |

**Expected Samples per Thread Group (30 minutes):**
- Small-3: 17.62 TPS × 1800s = 31,716 samples
- Small-10: 17.62 TPS × 1800s = 31,716 samples
- Medium-67: 10.07 TPS × 1800s = 18,126 samples
- Large-105: 3.52 TPS × 1800s = 6,336 samples
- XLarge-245: 1.01 TPS × 1800s = 1,818 samples
- XXLarge-580: 0.50 TPS × 1800s = 900 samples

**Total Expected Samples:** 90,612 requests over 30 minutes

---

### 3.7 HTTP Request Configuration

**Element Type:** `HTTPSamplerProxy` (HTTP Request)
**Scope:** Each Thread Group (6 total, identical configuration)
**Purpose:** Send POST request with JSON payload to target API

#### 3.7.1 HTTP Request Parameters

| Field | Value | Source |
|-------|-------|--------|
| **Name** | `POST-PortfolioProcessing` | Descriptive name |
| **Protocol** | `${TARGET_PROTOCOL}` | From UDV (default: `https`) |
| **Server Name or IP** | `${TARGET_HOST}` | From UDV (default: `process-portfolio-4bzwg5efpa-uc.a.run.app`) |
| **Port Number** | `${TARGET_PORT}` | From UDV (default: `443`) |
| **Method** | `POST` | Fixed |
| **Path** | `${TARGET_PATH}` | From UDV (default: `/`) |
| **Content Encoding** | `UTF-8` | Standard |
| **Body Data** | `${__FileToString(${TESTDATA_DIR}/[filename].json,,)}` | Direct file loading via __FileToString() |
| **Implementation** | Java | Default HTTP client |

#### 3.7.2 Advanced Settings

| Parameter | Value | Rationale |
|-----------|-------|-----------|
| **Retrieve All Embedded Resources** | Disabled | API-only test, no HTML parsing |
| **Follow Redirects** | Disabled | Direct API call, no redirects expected |
| **Use KeepAlive** | Enabled | Connection reuse for performance |
| **Use multipart/form-data** | Disabled | JSON body, not form data |
| **Browser-compatible headers** | Disabled | Custom headers set via HTTP Header Manager |

**Request Structure:**
```http
POST / HTTP/1.1
Host: process-portfolio-4bzwg5efpa-uc.a.run.app:443
Content-Type: application/json
Accept: application/json

${__FileToString(${TESTDATA_DIR}/holdings_3_411929.json,,)}
```

**Note:** The `__FileToString()` function is evaluated at request time, loading the JSON file content directly into the request body.

---

### 3.8 Response Assertion Configuration

**Element Type:** `ResponseAssertion`
**Scope:** Each Thread Group (6 total, identical configuration)
**Purpose:** Validate HTTP 200 success response

| Parameter | Value |
|-----------|-------|
| **Name** | `Assert-HTTP200` |
| **Apply to** | Main sample only |
| **Response Field** | Response Code |
| **Pattern Matching Rules** | Equals |
| **Patterns to Test** | `200` |

**Failure Behavior:** If response code ≠ 200, the sample is marked as **FAILED** in results.

---

### 3.9 Duration Assertion Configuration

**Element Type:** `DurationAssertion`
**Scope:** Each Thread Group (6 instances with payload-specific SLAs)
**Purpose:** Enforce response time SLA validation per payload size

#### 3.9.1 Duration Assertion Parameters

| Thread Group | Assertion Name | Duration (ms) | SLA Source |
|--------------|----------------|---------------|------------|
| TG-Small-3-Baseline | `Assert-ResponseTime-Small3` | 300 | Line 150 |
| TG-Small-10-Baseline | `Assert-ResponseTime-Small10` | 400 | Line 153 |
| TG-Medium-67-Baseline | `Assert-ResponseTime-Medium67` | 800 | Line 156 |
| TG-Large-105-Baseline | `Assert-ResponseTime-Large105` | 1200 | Line 159 |
| TG-XLarge-245-Baseline | `Assert-ResponseTime-XLarge245` | 2500 | Line 162 |
| TG-XXLarge-580-Baseline | `Assert-ResponseTime-XXLarge580` | 5000 | Line 165 |

#### 3.9.2 Configuration Structure

| Parameter | Value |
|-----------|-------|
| **Apply to** | Main sample only |
| **Duration in milliseconds** | [Payload-specific value from table above] |

**Failure Behavior:** If actual response time > configured duration, the sample is marked as **FAILED** with assertion error.

**Pass/Fail Logic:**
- `Actual Duration ≤ SLA Duration` → ✅ PASS
- `Actual Duration > SLA Duration` → ❌ FAIL

---

### 3.10 Listeners Configuration

#### 3.10.1 View Results Tree (Debug Listener)

**Element Type:** `ViewResultsTree`
**Scope:** Test Plan Level
**Purpose:** Real-time debugging during test development (disable for production runs)

| Parameter | Value |
|-----------|-------|
| **Name** | `Listener-Debug` |
| **Write results to file** | Empty (no file output) |
| **Log/Display Only** | All samples |
| **Save successful responses** | Yes |

**Performance Note:** Disable or remove this listener for actual load tests to reduce memory consumption and improve performance.

#### 3.10.2 Aggregate Report (Summary Listener)

**Element Type:** `AggregateReport`
**Scope:** Test Plan Level
**Purpose:** Real-time summary statistics during test execution

| Parameter | Value |
|-----------|-------|
| **Name** | `Listener-Summary` |
| **Write results to file** | Empty (no file output) |

**Metrics Displayed:**
- # Samples
- Average Response Time
- Min/Max Response Time
- Std. Deviation
- Error %
- Throughput (TPS)
- Received KB/sec
- Sent KB/sec
- Average Bytes

**Performance Note:** For production tests, log to `.jtl` file instead of GUI listeners.

---

## 4. Command-Line Execution Configuration

### 4.1 HTML Dashboard Report Generation

**JMeter Command Structure:**

```bash
jmeter -n -t portfolio-baseline-test-no-groovy.jmx \
       -l results/baseline-results.jtl \
       -j logs/baseline-jmeter.log \
       -e -o reports/baseline-report
```

**Command-Line Flags:**

| Flag | Parameter | Description |
|------|-----------|-------------|
| `-n` | None | Non-GUI mode (headless execution) |
| `-t` | `<test_plan.jmx>` | Path to JMeter test plan file |
| `-l` | `<results.jtl>` | Path to results log file (CSV format) |
| `-j` | `<jmeter.log>` | Path to JMeter execution log |
| `-e` | None | Generate HTML report after test |
| `-o` | `<output_dir>` | Output directory for HTML report |

**Source:** Apache JMeter Documentation - `jmeter.sh` command reference

### 4.2 Parameterized Execution with Property Overrides

Override default User Defined Variables via command-line properties:

```bash
jmeter -n -t portfolio-baseline-test-no-groovy.jmx \
       -Jtarget_host=prod-api.example.com \
       -Jtarget_port=443 \
       -Jtarget_protocol=https \
       -Jtestdata_dir=/opt/testdata/portfolio \
       -l results/baseline-prod-results.jtl \
       -e -o reports/baseline-prod-report
```

**Property Syntax:** `-J<property_name>=<value>` maps to `${__P(property_name,default_value)}`

### 4.3 Results File Format (.jtl)

**Recommended Configuration:** CSV format with essential metrics

**JMeter Properties** (add to `user.properties` or pass via `-J`):
```properties
jmeter.save.saveservice.output_format=csv
jmeter.save.saveservice.response_code=true
jmeter.save.saveservice.response_message=true
jmeter.save.saveservice.successful=true
jmeter.save.saveservice.label=true
jmeter.save.saveservice.time=true
jmeter.save.saveservice.latency=true
jmeter.save.saveservice.connect_time=true
jmeter.save.saveservice.bytes=true
jmeter.save.saveservice.thread_counts=true
```

### 4.4 Directory Structure for Test Execution

```
jmeter-prompt-workflow-templates/
├── testdata/
│   ├── holdings_3_411929.json
│   ├── holdings_10_109757.json
│   ├── holdings_67_981936.json
│   ├── holdings_105_615062.json
│   ├── holdings_245_358040.json
│   └── holdings_580_491573.json
├── portfolio-baseline-test-no-groovy.jmx
├── results/
│   └── baseline-results.jtl
├── logs/
│   └── baseline-jmeter.log
└── reports/
    └── baseline-report/
        ├── index.html
        ├── content/
        └── sbadmin2-1.0.7/
```

---

## 5. Implementation Approach & Development Steps

### 5.1 Implementation Strategy

**Approach:** Bottom-up incremental development with validation at each step.

**Rationale:**
1. Build foundation elements first (UDV, Headers)
2. Create and test one complete thread group as template
3. Clone and customize for remaining payload sizes
4. Validate component interactions before final integration

### 5.2 Implementation Steps (Sequential)

#### Step 1: Create Test Plan Container
- Create new JMeter Test Plan
- Set Test Plan name: `Portfolio Processing - Baseline Test (No Groovy - Java 24 Compatible)`
- Enable "Run Thread Groups consecutively" = **FALSE** (parallel execution)
- Add comments documenting test purpose and reference to test plan document

#### Step 2: Add User Defined Variables
- Add `User Defined Variables` element at Test Plan level
- Configure 5 variables with these defaults:
  - `TESTDATA_DIR`: `/Users/samisabir-idrissi/dev/personal/prompt-templates-demo-share/jmeter-prompt-workflow-templates/testdata`
  - `TARGET_HOST`: `process-portfolio-4bzwg5efpa-uc.a.run.app`
  - `TARGET_PORT`: `443`
  - `TARGET_PROTOCOL`: `https`
  - `TARGET_PATH`: `/`
- Use `${__P(property,default)}` syntax for parameterization
- Validate variable references work by adding Debug Sampler temporarily

#### Step 3: Add HTTP Header Manager
- Add `HTTP Header Manager` at Test Plan level
- Add header: `Content-Type: application/json`
- Add header: `Accept: application/json`
- Validate headers will apply to all HTTP Requests

#### Step 4: Create Template Thread Group (Small-3)
- Add **Standard Thread Group** (built-in element)
- Name: `TG-Small-3-Baseline`
- Configure settings:
  - Number of Threads: 11
  - Ramp-Up Period: 120 seconds
  - Loop Count: Forever (-1)
  - Duration: 1800 seconds
  - Startup Delay: 0 seconds
  - Scheduler: Enabled (checkbox checked)
  - Same user on each iteration: True

#### Step 5: Add Constant Timer to Template
- Add `Constant Timer` under TG-Small-3-Baseline
- Name: `Timer-ThinkTime-0.5s`
- Thread Delay: 500 ms

#### Step 6: Add Constant Throughput Timer to Template
- Add **Constant Throughput Timer** (built-in) under TG-Small-3-Baseline
- Name: `CTT-Small-3`
- Target throughput: 1057.2 (requests per minute)
- Calculate Throughput based on: `this thread group` (calcMode=0)

#### Step 7: Add HTTP Request to Template
- Add `HTTP Request` under TG-Small-3-Baseline
- Name: `POST-PortfolioProcessing`
- Protocol: `${TARGET_PROTOCOL}`
- Server: `${TARGET_HOST}`
- Port: `${TARGET_PORT}`
- Method: POST
- Path: `${TARGET_PATH}`
- Body Data: `${__FileToString(${TESTDATA_DIR}/holdings_3_411929.json,,)}`

#### Step 8: Add Response Assertion to Template
- Add `Response Assertion` under HTTP Request
- Name: `Assert-HTTP200`
- Apply to: Main sample only
- Response Field: Response Code
- Pattern: `200` (Equals)

#### Step 9: Add Duration Assertion to Template
- Add `Duration Assertion` under HTTP Request
- Name: `Assert-ResponseTime-Small3`
- Duration: 300 milliseconds

#### Step 10: Validate Template Thread Group
- Add `View Results Tree` listener at Test Plan level (temporary)
- Run test with 1 thread for 10 seconds to validate:
  - JSON file loads successfully via __FileToString()
  - HTTP request sends correct payload
  - Response Assertion passes (HTTP 200)
  - Duration Assertion evaluates correctly
  - No file read errors in log
- Review JMeter log file for errors

#### Step 11: Clone and Customize Remaining Thread Groups
- **Right-click TG-Small-3-Baseline** → Duplicate 5 times
- For each duplicate, update:
  - Thread Group Name
  - Number of Threads
  - Constant Throughput Timer: Target throughput value (req/min) and name
  - HTTP Request Body Data: JSON filename in __FileToString() function
  - Duration Assertion: Duration value and name

**Thread Group 2 (Small-10):**
- Name: `TG-Small-10-Baseline`
- Threads: 12
- CTT Throughput: 1057.2 req/min (17.62 TPS)
- HTTP Body Data: `${__FileToString(${TESTDATA_DIR}/holdings_10_109757.json,,)}`
- Duration Assertion: 400ms

**Thread Group 3 (Medium-67):**
- Name: `TG-Medium-67-Baseline`
- Threads: 11
- CTT Throughput: 604.2 req/min (10.07 TPS)
- HTTP Body Data: `${__FileToString(${TESTDATA_DIR}/holdings_67_981936.json,,)}`
- Duration Assertion: 800ms

**Thread Group 4 (Large-105):**
- Name: `TG-Large-105-Baseline`
- Threads: 5
- CTT Throughput: 211.2 req/min (3.52 TPS)
- HTTP Body Data: `${__FileToString(${TESTDATA_DIR}/holdings_105_615062.json,,)}`
- Duration Assertion: 1200ms

**Thread Group 5 (XLarge-245):**
- Name: `TG-XLarge-245-Baseline`
- Threads: 3
- CTT Throughput: 60.6 req/min (1.01 TPS)
- HTTP Body Data: `${__FileToString(${TESTDATA_DIR}/holdings_245_358040.json,,)}`
- Duration Assertion: 2500ms

**Thread Group 6 (XXLarge-580):**
- Name: `TG-XXLarge-580-Baseline`
- Threads: 2
- CTT Throughput: 30.0 req/min (0.50 TPS)
- HTTP Body Data: `${__FileToString(${TESTDATA_DIR}/holdings_580_491573.json,,)}`
- Duration Assertion: 5000ms

#### Step 12: Add Summary Listeners
- Add `Aggregate Report` at Test Plan level
- Name: `Listener-Summary`
- Optionally log to file: `results/baseline-aggregate.csv`

#### Step 13: Validation Test Run (Short Duration)
- Modify all Thread Group durations temporarily:
  - Duration: 50 seconds (instead of 1800)
  - Ramp-Up: 10 seconds (instead of 120)
- Run test in GUI mode
- Verify:
  - All 6 thread groups start simultaneously
  - TPS targets are approximately met (check Aggregate Report)
  - All JSON files load without errors via __FileToString()
  - Response Assertions pass (assuming API is available)
  - Duration Assertions evaluate (may fail if API is slow)
- Review `View Results Tree` for any red (failed) samples

#### Step 14: Restore Full Test Duration
- Restore all Thread Group configurations to:
  - Duration: 1800 seconds
  - Ramp-Up: 120 seconds

#### Step 15: Final Configuration Review
- Remove or disable `View Results Tree` listener (performance)
- Verify all variable references use correct syntax
- Check thread group parallelization enabled
- Validate command-line execution command
- Document any environment-specific configuration

#### Step 16: Production Test Execution
- Execute command-line test with HTML report generation:
```bash
jmeter -n -t portfolio-baseline-test-no-groovy.jmx \
       -l results/baseline-results.jtl \
       -j logs/baseline-jmeter.log \
       -e -o reports/baseline-report
```
- Monitor `baseline-jmeter.log` for errors during execution
- Wait for test completion (30 minutes)

#### Step 17: Results Validation
- Open HTML report: `reports/baseline-report/index.html`
- Verify key metrics:
  - **Total Samples:** ~90,612 requests
  - **Overall TPS:** ~50.35 TPS
  - **Error Rate:** 0% (if API is stable)
  - **Response Time 90th %ile:** Within SLA thresholds
- Compare TPS distribution across payload sizes to expected values
- Review Duration Assertion failure rates per thread group

---

## 6. Validation Checklist

### 6.1 Pre-Implementation Validation
- [ ] JMeter 5.6+ installed
- [ ] No plugins required (uses built-in components only)
- [ ] Test data directory accessible: `testdata/`
- [ ] All 6 JSON files present and valid
- [ ] Target API endpoint reachable (if applicable)

### 6.2 Test Plan Configuration Validation
- [ ] User Defined Variables use `${__P()}` for parameterization
- [ ] HTTP Header Manager includes `Content-Type: application/json`
- [ ] All 6 Thread Groups use Standard Thread Group type (built-in)
- [ ] Thread Group scheduler enabled with 1800s duration
- [ ] Thread Group ramp-up set to 120 seconds
- [ ] Thread counts match test plan specifications (11,12,11,5,3,2)
- [ ] HTTP Requests use `${__FileToString(${TESTDATA_DIR}/[filename].json,,)}` in Body Data
- [ ] Constant Timers set to 500ms (0.5s think time)
- [ ] Constant Throughput Timers match TPS targets converted to req/min (1057.2, 1057.2, 604.2, 211.2, 60.6, 30.0)
- [ ] Response Assertions check for HTTP 200
- [ ] Duration Assertions match SLA values (300,400,800,1200,2500,5000)
- [ ] View Results Tree disabled/removed for production tests
- [ ] Aggregate Report configured for summary metrics

### 6.3 Functional Validation (Short Test Run)
- [ ] Test executes without errors
- [ ] All JSON files load successfully via __FileToString() (check JMeter log)
- [ ] HTTP requests send correct JSON payload structure
- [ ] Response Assertions pass (if API returns 200)
- [ ] Duration Assertions evaluate (pass/fail based on API performance)
- [ ] Thread ramp-up is gradual (no immediate spike)
- [ ] Threads terminate at duration expiry (1800s)
- [ ] TPS approximates target values (±10% acceptable in short tests)

### 6.4 Performance Validation (Full Test Run)
- [ ] Test completes full 30-minute duration without crashes
- [ ] JMeter log contains no OutOfMemoryErrors
- [ ] Total samples approximately equals 90,612 (±5% acceptable)
- [ ] Overall TPS approximately equals 50.35 (±5% acceptable)
- [ ] Per-thread-group TPS matches targets (check Aggregate Report)
- [ ] Error rate ≤ 1% (assuming stable API)
- [ ] Response time 90th percentile meets SLA per payload size
- [ ] HTML Dashboard Report generates successfully
- [ ] All report graphs render correctly (no blank charts)

### 6.5 Command-Line Execution Validation
- [ ] Non-GUI mode executes without GUI-related errors
- [ ] Results file (.jtl) generates successfully
- [ ] JMeter log file (.log) contains execution details
- [ ] HTML report directory created with `index.html`
- [ ] Report includes: APDEX, Statistics, Response Times Over Time, Throughput Over Time
- [ ] Property overrides work correctly (`-Jtarget_host=...`)

---

## 7. Technical Considerations & Best Practices

### 7.1 JSON File Loading Optimization

**Loading Strategy:**
- JSON files are loaded **on every iteration** using `__FileToString()` function
- No caching mechanism (unlike JSR223 Groovy approach)
- File reads occur for each HTTP request execution

**Memory Implications:**
- No memory overhead for caching JSON data in variables
- Minimal memory footprint (only temporary string during function evaluation)
- Safe for long-running tests without memory accumulation

**File Access Patterns:**
- Throughout test duration: File I/O on every request (31,716 max iterations for Small-3)
- Higher file I/O compared to Groovy caching approach
- Acceptable for baseline test with moderate iteration counts
- For very high-iteration tests, consider JSR223 caching approach

**Performance Trade-offs:**
- ✅ **Advantage:** Java 24+ compatible, no Groovy compilation issues
- ✅ **Advantage:** Simpler implementation, easier troubleshooting
- ✅ **Advantage:** No script compilation overhead
- ⚠️ **Trade-off:** Higher file I/O (acceptable for this test scale)
- ⚠️ **Trade-off:** No per-thread caching optimization

### 7.2 Constant Throughput Timer Accuracy

**Why Constant Throughput Timer:**
- Built-in JMeter component (no plugins required)
- Adds delays between requests to achieve target throughput
- Works on per-minute basis (specify requests/minute)
- Adequate for baseline testing with stable load patterns

**Configuration Notes:**
- **Target throughput:** Requests per minute (TPS × 60)
- **Calculate mode:** `this thread group` (0) - each thread group independently controls its TPS
- **Timer placement:** Must be under Thread Group, before HTTP Request

**Expected Behavior:**
- TPS ramps proportionally with thread ramp-up (0-120 seconds)
- TPS stabilizes during steady-state (120-1800 seconds)
- TPS terminates when duration expires (1800 seconds)

**Limitations vs. Precise Throughput Timer (plugin):**
- ⚠️ Less accurate in first 30-60 seconds (warm-up period)
- ⚠️ May have slight TPS drift (±5-10%) compared to plugin
- ⚠️ Does not use Poisson arrival patterns
- ✅ Acceptable for baseline testing (not precision benchmarking)

### 7.3 Standard Thread Group vs. Ultimate Thread Group

**This Implementation Uses: Standard Thread Group (Built-in)**

**Standard Thread Group Features:**
- Built-in JMeter component (no plugins required)
- Ramp-up period: Gradual thread startup over specified seconds
- Duration-based scheduling: Runs for fixed duration (1800s)
- Loop count: Forever (-1) for continuous execution until duration expires
- Termination: All threads stop immediately when duration expires

**Standard Thread Group Limitations:**
- ⚠️ **No dedicated ramp-down:** Threads terminate abruptly at duration expiry
- ⚠️ **Single ramp-up period:** Cannot define multi-phase load profiles
- ⚠️ **No visual schedule editor:** Must calculate thread distribution manually

**Ultimate Thread Group (Plugin) - Not Used:**
- Independent control of ramp-up, hold, and ramp-down phases
- Multiple schedule rows for complex load profiles (spike, gradual escalation)
- Visual schedule editor in JMeter GUI
- Requires plugin installation: `jmeter-plugins-casutg.jar`

**Why Standard Thread Group Was Chosen:**
- ✅ No plugin dependencies (Java 24+ compatibility priority)
- ✅ Simpler implementation and maintenance
- ✅ Adequate for baseline testing (30-minute sustained load)
- ✅ Ramp-down not critical for this test scenario

**Trade-off:**
The implementation **lacks the 3-minute gradual ramp-down** specified in the original test plan. Threads terminate immediately at 30 minutes instead of ramping down from minutes 27-30. For production testing requiring graceful shutdown, Ultimate Thread Group plugin is recommended.

### 7.4 Think Time Strategy

**Constant Timer (0.5s):**
- Fixed 500ms delay between iterations
- Predictable, deterministic load pattern
- Aligns with rate-based control via Precise Throughput Timer

**Why NOT Gaussian/Uniform Random Timer:**
- Random think times conflict with precise TPS targets
- Introduces variability that complicates baseline analysis
- Baseline test requires consistent, repeatable load

**Think Time Formula:**
```
Think Time = (1 / TPS) - Avg Response Time
```
Example for Small-3 (17.62 TPS, ~200ms response):
```
Think Time = (1 / 17.62) - 0.200 = 0.0568 - 0.200 = -0.143s (negative!)
```
**Implication:** With 11 threads and 17.62 TPS, think time is actually controlled by Precise Throughput Timer, not Constant Timer. The 0.5s Constant Timer adds minimal delay between sampler completion and next iteration start.

### 7.5 Assertion Failure Impact

**Response Assertion (HTTP 200):**
- Failure marks sample as FAILED in results
- Does NOT stop thread execution (thread continues)
- Affects: Error Rate %, Aggregate Report metrics
- Use Case: Detect API errors (500, 503, 404)

**Duration Assertion (SLA):**
- Failure marks sample as FAILED in results
- Does NOT stop thread execution
- Affects: Error Rate %, SLA compliance metrics
- Use Case: Identify performance degradation under load

**Recommended Behavior:** Both assertions should fail gracefully, allowing test to complete even if API degrades. Post-test analysis will identify:
- Error Rate % > 0: API stability issues
- Duration Assertion failures: Performance SLA violations

### 7.6 JMeter Memory Configuration

**Recommended Heap Settings** (for 44 threads, 30-minute test):
```bash
export HEAP="-Xms1g -Xmx2g -XX:MaxMetaspaceSize=256m"
```

**Rationale:**
- 44 threads × 2MB per thread = ~88MB thread overhead
- JSON caching: ~1.3MB
- HTTP client buffers: ~50MB
- JMeter engine overhead: ~100MB
- **Total estimated:** ~240MB (1GB heap is safe, 2GB provides headroom)

**Large-Scale Considerations:**
- For Peak test (60.42 TPS, more threads), increase heap to `-Xmx4g`
- Disable GUI listeners (View Results Tree) in production tests
- Use `-l results.jtl` instead of GUI listeners to reduce memory

### 7.7 Command-Line Best Practices

**Recommended Execution Script:**
```bash
#!/bin/bash
# portfolio-baseline-test.sh

# Configuration
TEST_PLAN="portfolio-baseline-test-no-groovy.jmx"
RESULTS_FILE="results/baseline-$(date +%Y%m%d-%H%M%S).jtl"
LOG_FILE="logs/baseline-$(date +%Y%m%d-%H%M%S).log"
REPORT_DIR="reports/baseline-$(date +%Y%m%d-%H%M%S)"

# Target Configuration (override defaults)
TARGET_HOST="${TARGET_HOST:-localhost}"
TARGET_PORT="${TARGET_PORT:-8080}"
TARGET_PROTOCOL="${TARGET_PROTOCOL:-http}"
TESTDATA_DIR="${TESTDATA_DIR:-testdata}"

# Execute Test
jmeter -n \
       -t "$TEST_PLAN" \
       -l "$RESULTS_FILE" \
       -j "$LOG_FILE" \
       -Jtarget_host="$TARGET_HOST" \
       -Jtarget_port="$TARGET_PORT" \
       -Jtarget_protocol="$TARGET_PROTOCOL" \
       -Jtestdata_dir="$TESTDATA_DIR" \
       -e -o "$REPORT_DIR"

echo "Test completed. Report: $REPORT_DIR/index.html"
```

**Usage:**
```bash
# Default (localhost:8080)
./portfolio-baseline-test.sh

# Production environment
TARGET_HOST=prod-api.example.com \
TARGET_PORT=443 \
TARGET_PROTOCOL=https \
TESTDATA_DIR=/opt/testdata/portfolio \
./portfolio-baseline-test.sh
```

---

## 8. Expected Results & Success Criteria

### 8.1 Expected Throughput Distribution

| Payload Size | TPS Target | % of Total TPS | Expected Samples (30 min) |
|--------------|------------|----------------|---------------------------|
| Small-3 | 17.62 | 35.0% | 31,716 |
| Small-10 | 17.62 | 35.0% | 31,716 |
| Medium-67 | 10.07 | 20.0% | 18,126 |
| Large-105 | 3.52 | 7.0% | 6,336 |
| XLarge-245 | 1.01 | 2.0% | 1,818 |
| XXLarge-580 | 0.50 | 1.0% | 900 |
| **Total** | **50.35** | **100%** | **90,612** |

### 8.2 Response Time SLA Targets

| Payload Size | 90th %ile Target | 95th %ile Target | 99th %ile Target |
|--------------|------------------|------------------|------------------|
| Small-3 | 300ms | 330ms | 360ms |
| Small-10 | 400ms | 440ms | 480ms |
| Medium-67 | 800ms | 880ms | 960ms |
| Large-105 | 1200ms | 1320ms | 1440ms |
| XLarge-245 | 2500ms | 2750ms | 3000ms |
| XXLarge-580 | 5000ms | 5500ms | 6000ms |

**Note:** Duration Assertions enforce 100th percentile (max) at SLA values. Some assertion failures expected if API occasionally exceeds SLA.

### 8.3 Success Criteria

**Functional Success:**
- [ ] Test completes full 30-minute duration
- [ ] All 6 thread groups execute without errors
- [ ] JSON files load successfully (no FileNotFoundExceptions)
- [ ] HTTP requests send valid JSON payloads
- [ ] Response Assertions achieve >99% pass rate (HTTP 200)

**Performance Success:**
- [ ] Total samples: 90,612 ±5% (86,082 - 95,142 acceptable)
- [ ] Overall TPS: 50.35 ±5% (47.83 - 52.87 acceptable)
- [ ] Per-thread-group TPS within ±10% of targets
- [ ] Error Rate: ≤1% (API availability: 99%+)
- [ ] Duration Assertion failures: ≤5% (95% samples meet SLA)

**Report Success:**
- [ ] HTML Dashboard Report generates without errors
- [ ] All graphs render correctly (Response Times Over Time, Throughput, etc.)
- [ ] APDEX score calculated (Target: ≥0.90 for "Satisfied")
- [ ] Statistics table shows per-sampler breakdown

---

## 9. Troubleshooting Guide

### 9.1 Common Issues & Resolutions

#### Issue 1: JSON File Not Found
**Symptom:** `FileNotFoundException` in JMeter log, samples fail immediately

**Resolution:**
1. Verify testdata directory structure: `ls -la testdata/`
2. Check `TESTDATA_DIR` variable value: `testdata` (relative) or `/full/path/testdata` (absolute)
3. Update JSR223 PreProcessor file path construction
4. Test with absolute path first, then use relative path

#### Issue 2: Constant Throughput Timer Not Achieving Target TPS
**Symptom:** Actual TPS significantly differs from target (>15% variance)

**Resolution:**
1. Verify timer placement: Must be **under** Thread Group, **before** HTTP Request
2. Check timer configuration: Throughput in requests/minute (TPS × 60)
3. Increase thread count if threads are saturated (all busy, no idle time)
4. Remove conflicting timers (multiple timers can interfere)
5. Allow warm-up period: First 30-60 seconds may show variance
6. For higher precision, consider Precise Throughput Timer plugin

#### Issue 3: JSON File Not Loading via __FileToString()
**Symptom:** Empty request body or "file not found" errors in JMeter log

**Resolution:**
1. Verify file path: Check `${TESTDATA_DIR}` variable value
2. Test with absolute path: `${__FileToString(/full/path/to/file.json,,)}`
3. Check file permissions: Ensure JMeter can read the JSON files
4. Validate file exists: `ls -la ${TESTDATA_DIR}/holdings_3_411929.json`
5. Check for typos in filename within __FileToString() function
6. Review JMeter log for detailed error messages

#### Issue 4: Duration Assertions Fail Excessively (>50%)
**Symptom:** Most samples marked as FAILED, error: "Duration was XXXms > 300ms"

**Resolution:**
1. **API Performance Issue:** Investigate API response times (not JMeter issue)
2. **SLA Too Aggressive:** Review test plan SLA values, may need adjustment
3. **Network Latency:** Add latency overhead to SLA values (e.g., 300ms → 400ms)
4. **Warm-up Period:** Exclude first 2 minutes (ramp-up) from SLA analysis
5. **Temporary Fix:** Increase Duration Assertion values for initial testing

#### Issue 5: OutOfMemoryError During Test Execution
**Symptom:** JMeter crashes mid-test, log shows: `java.lang.OutOfMemoryError: Java heap space`

**Resolution:**
1. Increase JMeter heap: Edit `jmeter.sh` or `jmeter.bat`, set `HEAP="-Xms2g -Xmx4g"`
2. Remove GUI listeners: Disable View Results Tree, limit Aggregate Report output
3. Log to file instead of memory: Use `-l results.jtl`, avoid GUI during test
4. Reduce thread count temporarily: Test with 50% threads to isolate issue
5. Split test: Run smaller batches (e.g., 3 thread groups at a time)

**Note:** This implementation does NOT cache JSON in memory, so memory usage should be lower than Groovy-based caching approaches.

#### Issue 6: HTML Report Generation Fails
**Symptom:** Test completes, but no `index.html` in report directory

**Resolution:**
1. Check JMeter log for report generation errors
2. Verify output directory is empty (JMeter won't overwrite existing reports)
3. Check .jtl file format: Must be CSV format (not XML)
4. Ensure test has samples: Empty .jtl files cannot generate reports
5. Generate report manually from existing results:
```bash
jmeter -g results/baseline-results.jtl -o reports/baseline-report
```

---

## 10. Next Steps & Future Enhancements

### 10.1 Immediate Next Steps (After Baseline Implementation)

1. **Validate Baseline Test:**
   - Execute 3 test runs
   - Compare results for consistency (TPS, response times, error rates)
   - Document any anomalies or deviations

2. **Implement Peak Test:**
   - Clone `portfolio-baseline-test-no-groovy.jmx` → `portfolio-peak-test-no-groovy.jmx`
   - Update thread counts to Peak scenario (lines 147, Test Plan)
   - Update TPS targets to 60.42 TPS total
   - Validate Peak test follows same process

3. **Create Test Execution Scripts:**
   - Write `portfolio-baseline-test.sh` with parameterization
   - Write `portfolio-peak-test.sh`
   - Document environment-specific configurations

4. **Results Analysis Framework:**
   - Define KPIs: TPS distribution, error rate, SLA compliance
   - Create Excel/CSV template for results comparison
   - Document deviation analysis methodology

### 10.2 Future Enhancements

**Advanced Monitoring:**
- Integrate Backend Listener → InfluxDB → Grafana
- Real-time dashboard with TPS, response time, error rate
- Alerting for SLA violations during test execution

**Dynamic Test Data:**
- CSV Data Set Config for rotating JSON files
- Parameterized JSON generation (user-defined holdings counts)
- Data-driven testing for edge cases (0 holdings, 10,000+ holdings)

**Enhanced Assertions:**
- JSON Response Assertion (validate response structure)
- JSONPath Assertion (validate specific fields)
- Size Assertion (validate response payload size)

**CI/CD Integration:**
- Jenkins pipeline for scheduled test execution
- Automated results comparison (baseline vs. current)
- Failure notifications (Slack, email)

**Correlation & Extraction:**
- If API requires session tokens, add JSON Extractor
- Correlation for multi-step workflows (login → process → logout)
- Dynamic portfolio generation via API calls

---

## 11. References & Documentation Sources

### 11.1 Primary Documentation

1. **Test Plan Specification:**
   - `portfolio-processing-performance-test-plan.md`
   - Lines 138-165: Thread Group configurations
   - Lines 952-971: JSR223 Groovy script (Appendix C)

2. **Apache JMeter Official Documentation:**
   - [Ultimate Thread Group](https://jmeter-plugins.org/wiki/UltimateThreadGroup/)
   - [JMeter Ramp Up Period: The Ultimate Guide | BlazeMeter](https://www.blazemeter.com/blog/jmeter-ramp-up-period)
   - [Apache JMeter - User's Manual: Component Reference](https://jmeter.apache.org/usermanual/component_reference.html)

3. **Precise Throughput Timer Documentation:**
   - [JMeter – Precise Throughput Timer | PerfMatrix](https://www.perfmatrix.com/jmeter-precise-throughput-timer/)
   - [PreciseThroughputTimer (Apache JMeter API)](https://jmeter.apache.org/api/org/apache/jmeter/timers/poissonarrivals/PreciseThroughputTimer.html)
   - [How to generate exact TPS/RPS Using Jmeter - Codekru](https://www.codekru.com/jmeter/how-to-generate-exact-tps-rps-in-jmeter)

4. **Duration Assertion Documentation:**
   - [JMeter - Duration Assertion | PerfMatrix](https://www.perfmatrix.com/jmeter-duration-assertion/)
   - [Jmeter – Using Duration Assertion With Example](https://software-testing-tutorials-automation.com/2017/07/jmeter-using-duration-assertion-with.html)
   - [How to Use JMeter Assertions in Three Easy Steps | BlazeMeter](https://www.blazemeter.com/blog/jmeter-assertions)

5. **Context7 JMeter Documentation:**
   - Apache JMeter Library (`/apache/jmeter`)
   - JSR223 Sampler Scripting (Groovy)
   - HTML Dashboard Report Generation

### 11.2 Additional Resources

- **JMeter Plugins:** [jmeter-plugins.org](https://jmeter-plugins.org/)
- **JMeter Best Practices:** [BlazeMeter Blog](https://www.blazemeter.com/blog)
- **Groovy Documentation:** [groovy-lang.org](https://groovy-lang.org/)

---

## Document Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | AI Implementation Planner | Initial implementation plan created |

---

## Appendix A: Quick Reference - Configuration Values

### Thread Group Parameters (Baseline - Standard Thread Group)
```
TG-Small-3:     Threads=11, Ramp-Up=120s, Duration=1800s, TPS=17.62, CTT=1057.2 req/min, SLA=300ms
TG-Small-10:    Threads=12, Ramp-Up=120s, Duration=1800s, TPS=17.62, CTT=1057.2 req/min, SLA=400ms
TG-Medium-67:   Threads=11, Ramp-Up=120s, Duration=1800s, TPS=10.07, CTT=604.2 req/min,  SLA=800ms
TG-Large-105:   Threads=5,  Ramp-Up=120s, Duration=1800s, TPS=3.52,  CTT=211.2 req/min,  SLA=1200ms
TG-XLarge-245:  Threads=3,  Ramp-Up=120s, Duration=1800s, TPS=1.01,  CTT=60.6 req/min,   SLA=2500ms
TG-XXLarge-580: Threads=2,  Ramp-Up=120s, Duration=1800s, TPS=0.50,  CTT=30.0 req/min,   SLA=5000ms
```

### Standard Thread Group Schedule (All Groups)
```
Ramp-Up Period: 120 seconds (2 minutes)
Duration:       1800 seconds (30 minutes)
Loop Count:     Forever (-1)
Scheduler:      Enabled
Startup Delay:  0 seconds

Note: No ramp-down period (Standard Thread Group limitation)
```

### Constant Throughput Timer (All Groups)
```
Throughput Unit:     Requests per minute
Calculate Mode:      this thread group (calcMode=0)
Target Values:       See table above (CTT column)
```

### JSON Loading Method
```
Function: __FileToString()
Syntax:   ${__FileToString(${TESTDATA_DIR}/[filename].json,,)}
Location: HTTP Request Body Data field
```

### Command-Line Execution Template
```bash
jmeter -n -t portfolio-baseline-test-no-groovy.jmx \
       -Jtarget_host=<HOSTNAME> \
       -Jtarget_port=<PORT> \
       -Jtarget_protocol=<http|https> \
       -Jtestdata_dir=<PATH> \
       -l results/baseline-results.jtl \
       -j logs/baseline-jmeter.log \
       -e -o reports/baseline-report
```

---

**END OF IMPLEMENTATION PLAN**
