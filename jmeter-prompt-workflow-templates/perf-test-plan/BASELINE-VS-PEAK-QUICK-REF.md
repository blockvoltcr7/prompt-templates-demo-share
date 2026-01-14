# Baseline vs Peak Test - Quick Reference

## Side-by-Side Comparison

| Aspect | Baseline Test | Peak Test |
|--------|---------------|-----------|
| **File** | `portfolio-baseline-test-no-groovy.jmx` | `portfolio-peak-test-no-groovy.jmx` |
| **Scenario** | Current daily traffic | +20% growth projection |
| **Total TPS** | 50.35 req/sec | 60.42 req/sec |
| **Total RPM** | 3,021 req/min | 3,625.2 req/min |
| **Total Threads** | 44 virtual users | 53 virtual users |
| **Test Duration** | 30 minutes | 30 minutes |
| **Expected Samples** | ~90,612 | ~108,750 |
| **Daily Traffic** | 1,450,000 hits | 1,740,000 hits |

---

## Thread Group Comparison

| Thread Group | Baseline Threads | Peak Threads | Baseline TPS | Peak TPS | Change |
|--------------|------------------|--------------|--------------|----------|--------|
| TG-Small-3 | 11 | **14** | 17.62 | **21.15** | +3 threads, +20% TPS |
| TG-Small-10 | 12 | **14** | 17.62 | **21.15** | +2 threads, +20% TPS |
| TG-Medium-67 | 11 | **13** | 10.07 | **12.08** | +2 threads, +20% TPS |
| TG-Large-105 | 5 | **6** | 3.52 | **4.23** | +1 thread, +20% TPS |
| TG-XLarge-245 | 3 | 3 | 1.01 | **1.21** | No thread change, +20% TPS |
| TG-XXLarge-580 | 2 | **3** | 0.50 | **0.60** | +1 thread, +20% TPS |

---

## Running the Tests

### Baseline Test

```bash
# GUI mode
jmeter -t portfolio-baseline-test-no-groovy.jmx

# Headless mode
jmeter -n -t portfolio-baseline-test-no-groovy.jmx \
       -l results/baseline-results.jtl \
       -e -o reports/baseline-report
```

### Peak Test

```bash
# GUI mode
jmeter -t portfolio-peak-test-no-groovy.jmx

# Headless mode
jmeter -n -t portfolio-peak-test-no-groovy.jmx \
       -l results/peak-results.jtl \
       -e -o reports/peak-report
```

---

## Expected Results Comparison

### Based on Your Baseline Test (Actual Results)

| Metric | Baseline Target | Baseline Actual | Peak Target | Peak Expected |
|--------|-----------------|-----------------|-------------|---------------|
| **TPS** | 50.35 | **72.6** | 60.42 | **~87** |
| **Total Samples** | 90,612 | **130,569** | 108,750 | **~156,000** |
| **Error Rate** | <1% | **0.51%** | <1% | **~0.5-1%** |
| **Avg Response Time** | Various | **47ms** | Various | **50-60ms** |

**Key Finding**: Your baseline test already exceeded peak load targets, so peak test should pass easily!

---

## Success Criteria

### Baseline Test ✅ PASSED

- ✅ Completed 30 minutes
- ✅ Error rate 0.51% (below 1%)
- ✅ Response times 47ms avg (well below all SLAs)
- ✅ Achieved 72.6 TPS (44% above target)

### Peak Test 🔍 TO RUN

**Minimum Requirements:**
- ⏱️ Complete 30 minutes
- 📊 Error rate ≤1%
- 🎯 TPS ≥60.42 (±5%)
- ⚡ Response times below SLA per payload

**Likely Outcome** (based on baseline):
- ✅ Should achieve 85-90 TPS
- ✅ Error rate should stay <1%
- ✅ Response times should stay <60ms average

---

## What to Watch During Peak Test

### In JMeter GUI

1. **Aggregate Report** - Watch TPS stabilize around 60-90/sec
2. **View Results Tree** - Check for errors
3. **Response times** - Should stay below SLA thresholds

### In Google Cloud Console

1. **CPU Usage** - Should stay <80%
2. **Memory Usage** - Should stay <80%
3. **Instance Count** - Watch auto-scaling response
4. **Error Logs** - Monitor for any failures

---

## Quick Decision Guide

### When to Run Each Test

**Run Baseline Test:**
- ✅ First time validating the system
- ✅ After code changes
- ✅ Weekly/nightly regression tests
- ✅ Establishing performance baseline

**Run Peak Test:**
- ✅ Before major releases
- ✅ Quarterly capacity planning
- ✅ After infrastructure changes
- ✅ Validating growth projections

**Run Both:**
- ✅ Production readiness validation
- ✅ Performance regression testing suite
- ✅ Capacity planning exercises

---

## Files You Now Have

| File | Purpose | Status |
|------|---------|--------|
| `portfolio-baseline-test-no-groovy.jmx` | Baseline test (50.35 TPS) | ✅ Tested |
| `portfolio-peak-test-no-groovy.jmx` | Peak test (60.42 TPS) | ✅ Ready |
| `BASELINE-VS-PEAK-QUICK-REF.md` | This comparison | 📄 Reference |
| `PEAK-TEST-SUMMARY.md` | Peak test details | 📄 Reference |
| `JAVA24-SOLUTION-SUMMARY.md` | Java 24 compatibility | 📄 Reference |
| `QUICKSTART-JAVA24.md` | Quick start guide | 📄 Reference |
| `WHICH-VERSION.md` | Version selector | 📄 Reference |
| `CHEATSHEET.md` | Command reference | 📄 Reference |

---

## Next Steps

1. **✅ Baseline Test Complete** - You already ran this successfully (72.6 TPS achieved)

2. **🚀 Run Peak Test Next**:
   ```bash
   cd /Users/samisabir-idrissi/dev/personal/prompt-templates-demo-share/jmeter-prompt-workflow-templates/perf-test-plan
   jmeter -t portfolio-peak-test-no-groovy.jmx
   ```

3. **📊 Compare Results**:
   - Expected: Peak test achieves ~85-90 TPS (similar performance to baseline)
   - Error rate should stay <1%
   - Response times should stay fast (50-60ms average)

4. **📈 Optional Stress Test**:
   - If peak passes easily, test at 100-150 TPS to find limits
   - Document maximum capacity

---

**Date**: 2026-01-14
**Status**: Both tests ready to run
**Recommendation**: Run peak test to validate 20% growth capacity
