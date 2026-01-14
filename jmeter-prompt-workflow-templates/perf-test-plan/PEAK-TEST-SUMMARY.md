# Portfolio Processing - Peak Performance Test Summary

**File**: `portfolio-peak-test-no-groovy.jmx`
**Created**: 2026-01-14
**Java Compatibility**: 8, 11, 17, 21, 24+ (any version)
**Plugins Required**: ❌ None (No-Groovy version)

---

## Test Scenario: Peak Load (60.42 TPS)

This test simulates **20% growth** over baseline traffic, representing projected peak load conditions.

### Load Profile

| Metric | Value |
|--------|-------|
| **Total TPS** | 60.42 requests/second |
| **Total Threads** | 53 virtual users |
| **Test Duration** | 30 minutes (1800 seconds) |
| **Ramp-Up** | 2 minutes (120 seconds) |
| **Steady State** | 28 minutes |
| **Expected Samples** | ~108,750 total requests |

---

## Thread Group Configuration

| Thread Group | Threads | TPS Target | RPM | SLA | Expected Samples | JSON File |
|--------------|---------|------------|-----|-----|------------------|-----------|
| **TG-Small-3-Peak** | 14 | 21.15 | 1269.0 | 300ms | 38,070 | holdings_3_411929.json |
| **TG-Small-10-Peak** | 14 | 21.15 | 1269.0 | 400ms | 38,070 | holdings_10_109757.json |
| **TG-Medium-67-Peak** | 13 | 12.08 | 724.8 | 800ms | 21,744 | holdings_67_981936.json |
| **TG-Large-105-Peak** | 6 | 4.23 | 253.8 | 1200ms | 7,614 | holdings_105_615062.json |
| **TG-XLarge-245-Peak** | 3 | 1.21 | 72.6 | 2500ms | 2,178 | holdings_245_358040.json |
| **TG-XXLarge-580-Peak** | 3 | 0.60 | 36.0 | 5000ms | 1,080 | holdings_580_491573.json |
| **TOTAL** | **53** | **60.42** | **3625.2** | - | **108,756** | - |

---

## Comparison: Baseline vs Peak

| Metric | Baseline | Peak | Increase |
|--------|----------|------|----------|
| **Total TPS** | 50.35 | 60.42 | +20% |
| **Total Threads** | 44 | 53 | +9 threads |
| **Expected Samples** | 90,612 | 108,756 | +18,144 |
| **Traffic** | 1,450,000 hits/day | 1,740,000 hits/day | +290,000 |

### Thread Count Changes

| Thread Group | Baseline | Peak | Change |
|--------------|----------|------|--------|
| TG-Small-3 | 11 | 14 | +3 |
| TG-Small-10 | 12 | 14 | +2 |
| TG-Medium-67 | 11 | 13 | +2 |
| TG-Large-105 | 5 | 6 | +1 |
| TG-XLarge-245 | 3 | 3 | 0 |
| TG-XXLarge-580 | 2 | 3 | +1 |

---

## How to Run Peak Test

### GUI Mode

```bash
cd /Users/samisabir-idrissi/dev/personal/prompt-templates-demo-share/jmeter-prompt-workflow-templates/perf-test-plan

# Open in JMeter GUI
jmeter -t portfolio-peak-test-no-groovy.jmx

# Click green Start button (▶️)
# View live requests in "View Results Tree"
# Monitor statistics in "Aggregate Report"
```

### Command-Line Mode (Headless)

```bash
cd /Users/samisabir-idrissi/dev/personal/prompt-templates-demo-share/jmeter-prompt-workflow-templates/perf-test-plan

jmeter -n -t portfolio-peak-test-no-groovy.jmx \
       -l results/peak-results-$(date +%Y%m%d-%H%M%S).jtl \
       -j logs/peak-jmeter-$(date +%Y%m%d-%H%M%S).log \
       -e -o reports/peak-report-$(date +%Y%m%d-%H%M%S)

# View HTML report
open reports/peak-report-*/index.html
```

### With Custom Endpoint

```bash
jmeter -n -t portfolio-peak-test-no-groovy.jmx \
       -Jtarget_host=your-api.example.com \
       -Jtarget_port=443 \
       -Jtarget_protocol=https \
       -l results/peak-results.jtl \
       -e -o reports/peak-report
```

---

## Success Criteria

### Functional

| Metric | Target | Status |
|--------|--------|--------|
| **Test Duration** | 30 minutes exact | ✅ Configured |
| **Total Samples** | ~108,750 ±5% | ✅ Expected |
| **Error Rate** | ≤1% | 🔍 To be validated |
| **HTTP 200 Rate** | ≥99% | 🔍 To be validated |

### Performance

| Metric | Target | Notes |
|--------|--------|-------|
| **Overall TPS** | 60.42 ±5% | 57.4 - 63.4 TPS |
| **Response Times** | Below SLA targets | See thread group SLAs |
| **P95 Response Time** | Below SLA | Per payload size |
| **P99 Response Time** | Below SLA | Per payload size |

### Infrastructure (Google Cloud)

| Metric | Target | Where to Check |
|--------|--------|----------------|
| **CPU Utilization** | <80% | Cloud Console → Metrics |
| **Memory Utilization** | <80% | Cloud Console → Metrics |
| **Auto-Scaling** | Responsive | Cloud Console → Instances |
| **Error Logs** | Minimal | Cloud Console → Logs |

---

## Expected Results Based on Baseline Test

### Baseline Test Actual Performance

From your baseline test run (2026-01-13):
- Actual TPS: **72.6/sec** (44% above 50.35 target)
- Total Samples: **130,569** (44% above 90,612 target)
- Error Rate: **0.51%** (well below 1% threshold)
- Response Times: **47ms average** (excellent)

### Peak Test Projections

Based on baseline performance, peak test should achieve:

| Metric | Expected | Confidence |
|--------|----------|------------|
| **TPS** | ~87 TPS | High (if API performance stays consistent) |
| **Total Samples** | ~155,000-160,000 | High |
| **Error Rate** | <1% | High |
| **Response Time Avg** | 50-60ms | High (may increase slightly with load) |

**Key Insight**: Your baseline test already exceeded peak load target (72.6 > 60.42 TPS), so your API should handle peak load easily.

---

## Differences from Baseline Test

### What Changed

✅ **Thread counts increased**: 44 → 53 threads (+9)
✅ **TPS targets increased**: 50.35 → 60.42 TPS (+20%)
✅ **Expected samples increased**: 90,612 → 108,756 (+20%)

### What Stayed the Same

✅ **Test duration**: 30 minutes
✅ **Ramp-up**: 2 minutes
✅ **SLA thresholds**: Same per payload size
✅ **Think time**: 0.5 seconds
✅ **Test data**: Same 6 JSON files
✅ **Endpoint**: Same Cloud Function
✅ **JSON loading**: `__FileToString()` (no Groovy)

---

## After Running Peak Test

### Compare with Baseline

Create a comparison summary:

```bash
# If you saved baseline results
jmeter -g results/baseline-results.jtl -o reports/baseline-comparison
jmeter -g results/peak-results.jtl -o reports/peak-comparison

# Compare metrics:
# - TPS: Should be ~20% higher in peak
# - Error rate: Should stay <1%
# - Response times: May increase slightly (10-20%)
# - CPU/Memory: Check Cloud Console for resource usage
```

### Key Metrics to Monitor

1. **TPS Stability**: Does it stabilize around 60.42 TPS?
2. **Error Rate**: Does it stay below 1%?
3. **Response Times**: Do they stay below SLA thresholds?
4. **Resource Usage**: CPU and memory under 80%?
5. **Auto-Scaling**: Does Google Cloud scale instances appropriately?

---

## Troubleshooting

### Issue: TPS Much Higher Than Target (Like Baseline)

**Symptom**: Peak test achieves 85-90 TPS instead of 60.42
**Cause**: API response times very fast (40-50ms)
**Impact**: ✅ **GOOD** - Shows system can handle significantly more than peak
**Action**: Document actual performance, consider testing at even higher loads

### Issue: Error Rate >1%

**Symptom**: More than 1% of requests failing
**Possible Causes**:
- API rate limiting
- Resource constraints (CPU/Memory)
- Network timeouts
- External service failures

**Debug Steps**:
1. Check Cloud Console logs for errors
2. Review response times (are they timing out?)
3. Check CPU/Memory metrics
4. Review "View Results Tree" for failure patterns

### Issue: Response Times Exceed SLA

**Symptom**: P95 or P99 response times above SLA thresholds
**Possible Causes**:
- Insufficient Cloud Function instances
- CPU/Memory constraints
- External API slowness
- Database queries slow

**Debug Steps**:
1. Check which payload sizes exceed SLA
2. Review Cloud Function metrics (execution time distribution)
3. Check for cold starts
4. Review concurrent request count

---

## Next Steps

### After Successful Peak Test

1. ✅ **Document results** comparing baseline vs peak
2. ✅ **Update capacity planning** with actual limits
3. ✅ **Set monitoring alerts** based on thresholds
4. ✅ **Schedule periodic tests** to catch regressions

### Optional: Stress Testing

If peak test passes easily (like baseline did), consider:

**Stress Test**: Push beyond peak to find breaking point
- Try 100 TPS (66% above peak)
- Try 150 TPS (2.5× baseline)
- Identify where errors start appearing
- Document maximum sustainable load

---

## Files Reference

| File | Purpose |
|------|---------|
| `portfolio-peak-test-no-groovy.jmx` | Peak test plan (this file) |
| `portfolio-baseline-test-no-groovy.jmx` | Baseline test plan |
| `PEAK-TEST-SUMMARY.md` | This summary document |
| `QUICKSTART-JAVA24.md` | Quick start for Java 24+ users |
| `WHICH-VERSION.md` | Version selection guide |
| `CHEATSHEET.md` | Quick reference commands |

---

**Status**: ✅ Ready to Run
**Based On**: Successful baseline test (72.6 TPS achieved)
**Expected Outcome**: Should pass easily based on baseline performance
**Date Created**: 2026-01-14
