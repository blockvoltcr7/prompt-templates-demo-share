# JMeter Test Plan Cheat Sheet

---

## ⚡ Quick Commands

### Java 24+ Users (Recommended)
```bash
# GUI mode
jmeter -t portfolio-baseline-test-no-groovy.jmx

# Headless mode
jmeter -n -t portfolio-baseline-test-no-groovy.jmx \
       -l results/test-$(date +%Y%m%d-%H%M%S).jtl \
       -e -o reports/report-$(date +%Y%m%d-%H%M%S)
```

### Java 8-19 Users (with plugins)
```bash
# GUI mode
jmeter -t portfolio-baseline-test.jmx

# Headless mode
jmeter -n -t portfolio-baseline-test.jmx \
       -l results/test.jtl -e -o reports/report
```

---

## 📁 File Selection

| Your Java | File to Use |
|-----------|-------------|
| Java 24+ | `portfolio-baseline-test-no-groovy.jmx` ⭐ |
| Java 8-19 (want accuracy) | `portfolio-baseline-test.jmx` |
| Java 8-19 (no plugins) | `portfolio-baseline-test-standard-threadgroup.jmx` |

**Check Java version:** `java --version`

---

## 🎯 Test Profile

| Metric | Value |
|--------|-------|
| **Total Threads** | 44 |
| **Total TPS** | 50.35 |
| **Duration** | 30 minutes |
| **Ramp-up** | 2 minutes |
| **Expected Samples** | ~90,612 |

---

## 🔧 Configuration Variables

**GUI:** Test Plan → User Defined Variables

| Variable | Default | Description |
|----------|---------|-------------|
| TESTDATA_DIR | `/Users/.../testdata` | JSON files location |
| TARGET_HOST | `process-portfolio-4bzwg5efpa-uc.a.run.app` | API host |
| TARGET_PORT | `443` | API port |
| TARGET_PROTOCOL | `https` | http or https |

**Command-line override:**
```bash
jmeter -n -t test.jmx \
       -Jtarget_host=api.example.com \
       -Jtarget_port=8080 \
       -Jtarget_protocol=http \
       -l results.jtl
```

---

## 📊 Expected Results

| Metric | Target | Acceptable |
|--------|--------|------------|
| TPS | 50.35 | 47.8 - 52.9 |
| Total Samples | 90,612 | 86,000 - 95,000 |
| Error Rate | 0% | ≤1% |
| HTTP 200 | 100% | ≥99% |

---

## 🐛 Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `Unsupported class file major version 68` | Java 24 + Groovy scripts | Use `*-no-groovy.jmx` |
| `CannotResolveClassException: UltimateThreadGroup` | Missing plugins | Install plugins OR use `*-no-groovy.jmx` |
| `FileNotFoundException: holdings_*.json` | Wrong TESTDATA_DIR | Update to absolute path |
| `Connection refused` | API unreachable | Check TARGET_HOST/PORT/PROTOCOL |

---

## 📂 Test Data Files

**Location:** `/Users/samisabir-idrissi/dev/personal/prompt-templates-demo-share/jmeter-prompt-workflow-templates/testdata/`

```
holdings_3_411929.json    (3 holdings, 411 KB)
holdings_10_109757.json   (10 holdings, 109 KB)
holdings_67_981936.json   (67 holdings, 981 KB)
holdings_105_615062.json  (105 holdings, 615 KB)
holdings_245_358040.json  (245 holdings, 358 KB)
holdings_580_491573.json  (580 holdings, 491 KB)
```

---

## 📖 Documentation

| File | Purpose |
|------|---------|
| `WHICH-VERSION.md` | Version selection guide |
| `QUICKSTART-JAVA24.md` | Java 24+ quick start |
| `README.md` | General setup guide |
| `STANDARD-VS-PLUGIN-COMPARISON.md` | Detailed comparison |
| `JAVA24-SOLUTION-SUMMARY.md` | Java 24 solution summary |

---

## ⌨️ JMeter GUI Shortcuts

| Action | Method |
|--------|--------|
| **Start test** | Green ▶️ button OR `Ctrl+R` (Win) / `Cmd+R` (Mac) |
| **Stop test** | Red ⏹️ button OR `Ctrl+.` |
| **Clear results** | Broom icon 🧹 OR Run → Clear All |
| **View live requests** | Click "View Results Tree" in left panel |
| **View statistics** | Click "Aggregate Report" in left panel |

---

## 🚀 First-Time Run Checklist

- [ ] Verify Java version: `java --version`
- [ ] Verify JMeter installed: `jmeter --version`
- [ ] Check test data exists: `ls testdata/*.json` (should show 6 files)
- [ ] Test API reachable: `curl -I https://process-portfolio-4bzwg5efpa-uc.a.run.app/`
- [ ] Open test plan: `jmeter -t portfolio-baseline-test-no-groovy.jmx`
- [ ] Verify config in GUI: Check User Defined Variables
- [ ] Click Start ▶️
- [ ] Watch "View Results Tree" for live requests
- [ ] Check "Aggregate Report" for TPS ~50.35

---

## 📈 Performance Tips

**Short validation run (5 minutes):**
- Edit each Thread Group
- Duration: `300` (5 min instead of 1800)
- Ramp-up: `60` (1 min instead of 120)
- Expected samples: ~15,000

**View HTML report:**
```bash
# After test completes
open reports/baseline-report-*/index.html
```

**Analyze specific metrics:**
- APDEX score (user satisfaction)
- Response time percentiles (90th, 95th, 99th)
- Error rate by thread group
- Throughput over time

---

**File:** `portfolio-baseline-test-no-groovy.jmx`
**Updated:** 2026-01-13
**Java:** 24.0.1 (compatible with 8-24+)
**Status:** ✅ Ready
