# Portfolio Processing Performance Test - JMeter Implementation

## 🚀 Which Test Plan Should I Use?

**Three versions available - choose based on your Java version and requirements:**

| Version | File | Java Version | Plugins | Best For |
|---------|------|--------------|---------|----------|
| **No-Groovy** ⭐ | `portfolio-baseline-test-no-groovy.jmx` | 8-24+ (ANY) | ❌ No | **Java 24+ users** |
| **Plugin** | `portfolio-baseline-test.jmx` | 8-19 | ✅ Yes | **Maximum accuracy** (±1% TPS) |
| **Standard** | `portfolio-baseline-test-standard-threadgroup.jmx` | 8-19 | ❌ No | **No plugins, Java 8-19** |

**Quick decision:**
- Running **Java 24+**? → Use **No-Groovy** version ([Quick Start Guide](QUICKSTART-JAVA24.md))
- Want **best accuracy** and can install plugins? → Use **Plugin** version
- On **Java 8-19** without plugins? → Use **Standard** version

📖 **Detailed comparison:** See [WHICH-VERSION.md](WHICH-VERSION.md)

---

## Files Created

1. **`portfolio-baseline-test.jmx`** - Plugin version (Ultimate Thread Group, Precise Throughput Timer)
2. **`portfolio-baseline-test-standard-threadgroup.jmx`** - Standard version (no plugins, Groovy caching)
3. **`portfolio-baseline-test-no-groovy.jmx`** - No-Groovy version (Java 24+ compatible)
4. **`portfolio-processing-performance-test-plan.md`** - Original test plan specification
5. **`implementation-plan/portfolio-baseline-implementation-plan.md`** - Detailed implementation guide
6. **`STANDARD-VS-PLUGIN-COMPARISON.md`** - Version comparison guide
7. **`QUICKSTART-JAVA24.md`** - Quick start for Java 24+ users

## Quick Start

### Prerequisites

1. **JMeter 5.6+** installed
2. **Required Plugins:**
   - Ultimate Thread Group
   - Precise Throughput Timer (Variable Throughput Timer)

   Install via JMeter Plugins Manager:
   - Open JMeter GUI → Options → Plugins Manager
   - Search for "Ultimate Thread Group" and "Throughput Shaping Timer"
   - Install both plugins and restart JMeter

3. **Test Data:** Ensure `testdata/` directory contains all 6 JSON files:
   ```
   testdata/
   ├── holdings_3_411929.json
   ├── holdings_10_109757.json
   ├── holdings_67_981936.json
   ├── holdings_105_615062.json
   ├── holdings_245_358040.json
   └── holdings_580_491573.json
   ```

### Running the Test

#### Option 1: Default Configuration (localhost:8080)

```bash
jmeter -n -t portfolio-baseline-test.jmx \
       -l results/baseline-results.jtl \
       -j logs/baseline-jmeter.log \
       -e -o reports/baseline-report
```

#### Option 2: Custom Target Configuration

```bash
jmeter -n -t portfolio-baseline-test.jmx \
       -Jtarget_host=api.example.com \
       -Jtarget_port=443 \
       -Jtarget_protocol=https \
       -Jtestdata_dir=testdata \
       -l results/baseline-results.jtl \
       -j logs/baseline-jmeter.log \
       -e -o reports/baseline-report
```

#### Option 3: Using Shell Script

Create `run-baseline-test.sh`:

```bash
#!/bin/bash

# Configuration
TARGET_HOST="${TARGET_HOST:-localhost}"
TARGET_PORT="${TARGET_PORT:-8080}"
TARGET_PROTOCOL="${TARGET_PROTOCOL:-http}"
TESTDATA_DIR="${TESTDATA_DIR:-testdata}"

# Create output directories
mkdir -p results logs reports

# Generate timestamped filenames
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
RESULTS_FILE="results/baseline-${TIMESTAMP}.jtl"
LOG_FILE="logs/baseline-${TIMESTAMP}.log"
REPORT_DIR="reports/baseline-${TIMESTAMP}"

# Execute Test
jmeter -n \
       -t portfolio-baseline-test.jmx \
       -Jtarget_host="$TARGET_HOST" \
       -Jtarget_port="$TARGET_PORT" \
       -Jtarget_protocol="$TARGET_PROTOCOL" \
       -Jtestdata_dir="$TESTDATA_DIR" \
       -l "$RESULTS_FILE" \
       -j "$LOG_FILE" \
       -e -o "$REPORT_DIR"

echo ""
echo "=========================================="
echo "Test Completed!"
echo "=========================================="
echo "Results: $RESULTS_FILE"
echo "Log:     $LOG_FILE"
echo "Report:  $REPORT_DIR/index.html"
echo ""
```

Make executable and run:
```bash
chmod +x run-baseline-test.sh
./run-baseline-test.sh
```

Or with custom target:
```bash
TARGET_HOST=prod-api.example.com TARGET_PORT=443 TARGET_PROTOCOL=https ./run-baseline-test.sh
```

### Viewing Results

After test completion, open the HTML report:

```bash
# Mac
open reports/baseline-report/index.html

# Linux
xdg-open reports/baseline-report/index.html

# Windows
start reports/baseline-report/index.html
```

The HTML Dashboard includes:
- APDEX Score (Application Performance Index)
- Statistics Table (per payload size)
- Response Times Over Time
- Throughput Over Time
- Transactions Per Second
- Response Time Percentiles

---

## Test Plan Summary

### Load Distribution

| Thread Group | Virtual Users | TPS Target | SLA | Expected Samples (30 min) | % of Total Load |
|--------------|--------------|------------|-----|---------------------------|-----------------|
| TG-Small-3 | 11 | 17.62 | 300ms | 31,716 | 35% |
| TG-Small-10 | 12 | 17.62 | 400ms | 31,716 | 35% |
| TG-Medium-67 | 11 | 10.07 | 800ms | 18,126 | 20% |
| TG-Large-105 | 5 | 3.52 | 1200ms | 6,336 | 7% |
| TG-XLarge-245 | 3 | 1.01 | 2500ms | 1,818 | 2% |
| TG-XXLarge-580 | 2 | 0.50 | 5000ms | 900 | 1% |
| **TOTAL** | **44** | **50.35** | - | **90,612** | **100%** |

### Test Timeline

```
0-2 minutes:   Ramp-Up Phase (threads start gradually)
2-27 minutes:  Steady-State Phase (all 44 threads running)
27-30 minutes: Ramp-Down Phase (threads stop gradually)
Total:         30 minutes
```

### Key Features

- **Ultimate Thread Group**: Precise ramp-up/ramp-down control
- **Precise Throughput Timer**: Accurate TPS enforcement (±1% accuracy)
- **JSON Caching**: Test data loaded once per thread, cached for performance
- **SLA Enforcement**: Duration Assertions validate response time targets
- **Parameterization**: Command-line properties for flexible configuration
- **HTML Dashboard**: Automatic report generation with comprehensive metrics

---

## Configuration Parameters

### User Defined Variables

| Variable | Default | Override Flag | Description |
|----------|---------|---------------|-------------|
| `TESTDATA_DIR` | `testdata` | `-Jtestdata_dir` | Path to JSON test data directory |
| `TARGET_HOST` | `localhost` | `-Jtarget_host` | API hostname or IP |
| `TARGET_PORT` | `8080` | `-Jtarget_port` | API port number |
| `TARGET_PROTOCOL` | `http` | `-Jtarget_protocol` | Protocol (http/https) |
| `TARGET_PATH` | `/` | (hardcoded) | API endpoint path |

### Thread Group Schedule (All Groups)

- **Initial Delay**: 0 seconds
- **Startup Time (Ramp-Up)**: 120 seconds (2 minutes)
- **Hold Load For (Steady-State)**: 1500 seconds (25 minutes)
- **Shutdown Time (Ramp-Down)**: 180 seconds (3 minutes)

---

## Expected Results

### Success Criteria

**Functional:**
- Test completes full 30-minute duration without errors
- All JSON files load successfully (no FileNotFoundExceptions)
- HTTP 200 response rate: >99%

**Performance:**
- Total samples: ~90,612 (±5%)
- Overall TPS: ~50.35 (±5%)
- Per-thread-group TPS: Within ±10% of targets
- Error Rate: ≤1%
- Duration Assertion failures: ≤5% (95% samples meet SLA)

### Key Metrics to Monitor

1. **Throughput (TPS)**: Should stabilize at ~50.35 requests/second during steady-state
2. **Response Time**: 90th percentile should meet SLA per payload size
3. **Error Rate**: Should remain at 0% (assuming API is stable)
4. **Thread Behavior**: Smooth ramp-up and ramp-down (no spikes)
5. **Resource Usage**: JMeter memory < 2GB, CPU reasonable

---

## Troubleshooting

### Issue: FileNotFoundException for JSON Files

**Symptom**: Test fails immediately with `JSON file not found` errors

**Solution**:
1. Verify testdata directory structure:
   ```bash
   ls -la testdata/
   ```
2. If using relative path, run JMeter from project root directory
3. Or use absolute path:
   ```bash
   -Jtestdata_dir=/full/path/to/testdata
   ```

### Issue: TPS Target Not Met

**Symptom**: Actual TPS significantly lower than 50.35

**Solution**:
1. Check JMeter log for "Not enough threads" warnings
2. Verify Precise Throughput Timer plugin is installed
3. Increase thread counts if threads are saturated
4. Check API response times (slow responses = low TPS)

### Issue: OutOfMemoryError

**Symptom**: JMeter crashes during test with heap space error

**Solution**:
1. Increase JMeter heap size:
   ```bash
   export HEAP="-Xms2g -Xmx4g"
   ```
2. Disable View Results Tree listener (already disabled by default)
3. Ensure you're running in non-GUI mode (`-n` flag)

### Issue: HTML Report Not Generated

**Symptom**: Test completes but no `index.html` in report directory

**Solution**:
1. Ensure output directory is empty or doesn't exist
2. Check JMeter log for report generation errors
3. Verify .jtl file is not empty
4. Generate report manually:
   ```bash
   jmeter -g results/baseline-results.jtl -o reports/baseline-report
   ```

### Issue: Plugin Not Found Error

**Symptom**: `kg.apc.jmeter.threads.UltimateThreadGroup not found`

**Solution**:
1. Install JMeter Plugins Manager
2. Open JMeter GUI → Options → Plugins Manager
3. Install "Ultimate Thread Group" and "Throughput Shaping Timer"
4. Restart JMeter

---

## Validation Checklist

Before running the full 30-minute test:

- [ ] JMeter 5.6+ installed
- [ ] Ultimate Thread Group plugin installed
- [ ] Precise Throughput Timer plugin installed
- [ ] All 6 JSON files present in testdata/
- [ ] Target API endpoint is reachable
- [ ] JMeter heap size configured (2-4GB)
- [ ] Output directories created: `results/`, `logs/`, `reports/`

For initial validation (5-minute test):
1. Open `portfolio-baseline-test.jmx` in JMeter GUI
2. Temporarily modify all thread group schedules:
   - Startup Time: 10s
   - Hold Load For: 180s (3 minutes)
   - Shutdown Time: 10s
3. Run test in GUI mode
4. Verify:
   - All threads start without errors
   - TPS approximately matches targets
   - JSON files load successfully
   - Response Assertions pass (if API is available)
5. Restore original schedule before production run

---

## Next Steps

1. **Validate Baseline Test**: Run 2-3 baseline tests and compare results
2. **Implement Peak Test**: Clone and modify for peak scenario (60.42 TPS)
3. **CI/CD Integration**: Add to Jenkins/GitHub Actions pipeline
4. **Enhanced Monitoring**: Integrate with InfluxDB + Grafana
5. **Results Analysis**: Create comparison framework for regression testing

---

## Files Reference

- **Test Plan**: `portfolio-baseline-test.jmx`
- **Implementation Guide**: `implementation-plan/portfolio-baseline-implementation-plan.md`
- **Test Specification**: `portfolio-processing-performance-test-plan.md`
- **Test Data**: `../testdata/*.json`

---

## Support

For issues or questions:
1. Review the troubleshooting section above
2. Check JMeter log file: `logs/baseline-jmeter.log`
3. Consult implementation plan for detailed component specifications
4. Refer to test plan document for requirements clarification

---

**Test Created**: 2026-01-13
**JMeter Version**: 5.6.3
**Test Duration**: 30 minutes
**Total Virtual Users**: 44
**Target TPS**: 50.35
