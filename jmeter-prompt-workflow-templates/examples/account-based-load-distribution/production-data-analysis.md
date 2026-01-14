# Production Data Analysis: Account-Based API Load

## Executive Summary

Analysis of 30 days of production API logs reveals that account size (number of positions) significantly impacts response time and drives load distribution patterns. This analysis informs our performance testing strategy to mirror real-world usage.

---

## Business Context

**API**: Portfolio Management API - `/api/v1/accounts/{accountId}/positions`

**Business Function**: Retrieves all position data (stocks, bonds, mutual funds) for a client account

**Usage Pattern**: Financial advisors and automated systems query position data throughout the trading day

**Performance Impact**: Larger accounts (more positions) require more database queries, JSON serialization, and network bandwidth

---

## Data Collection Methodology

### Data Source
- Production API gateway logs
- Collection period: December 1-31, 2025 (30 days)
- Total API calls analyzed: 2,847,392 calls
- Time range: 24/7 operation (market hours + after-hours processing)

### Metrics Captured
- Account ID
- Position count (from response payload metadata)
- Response time (API gateway → response complete)
- HTTP status code
- Time of day

---

## Key Findings

### Call Volume by Account Size

| Account Size (Positions) | API Calls | % of Total | Avg Positions | Avg Response Time | 95th Percentile |
|-------------------------|-----------|------------|---------------|-------------------|-----------------|
| **1-50 positions**      | 1,708,435 | **60%**    | 26            | 150ms            | 180ms           |
| **51-200 positions**    | 854,218   | **30%**    | 120           | 450ms            | 520ms           |
| **201-500 positions**   | 256,265   | **9%**     | 350           | 1200ms           | 1350ms          |
| **500+ positions**      | 28,474    | **1%**     | 750           | 2800ms           | 3100ms          |

### Visual Distribution

```
Account Size Distribution (Production)
┌────────────────────────────────────────────────────┐
│ 1-50 positions:    ████████████████████  60%        │
│ 51-200 positions:  ██████████  30%                  │
│ 201-500 positions: ███  9%                          │
│ 500+ positions:    █  1%                            │
└────────────────────────────────────────────────────┘
```

---

## Response Time Analysis

### Response Time vs Account Size

Strong correlation between position count and response time:

```
Response Time Trend
3000ms │                                        ●
       │                                       ╱
2500ms │                                      ╱
       │                                     ╱
2000ms │                                    ╱
       │                              ●    ╱
1500ms │                            ╱│   ╱
       │                           ╱ │  ╱
1000ms │                ●         ╱  │ ╱
       │              ╱ │        ╱   │╱
 500ms │   ●         ╱  │       ╱    ●
       │  ╱│        ╱   │      ╱
   0ms │ ╱ │       ╱    │     ╱
       └──────────────────────────────
         26   120   350   750 positions
```

**Correlation**: R² = 0.94 (strong positive correlation)

**Formula**: `Response Time (ms) ≈ 3.5 × Position Count + 50`

### Statistical Summary

| Metric | Small | Medium | Large | XLarge |
|--------|-------|--------|-------|--------|
| **Mean** | 150ms | 450ms | 1200ms | 2800ms |
| **Median** | 145ms | 440ms | 1180ms | 2750ms |
| **Std Dev** | 25ms | 50ms | 100ms | 200ms |
| **Min** | 100ms | 350ms | 900ms | 2500ms |
| **Max** | 250ms | 600ms | 1500ms | 3100ms |

---

## Weighted Average Calculation

Based on production distribution, expected weighted average response time:

```
Weighted Avg Response Time = Σ (Percentage × Response Time)

= (0.60 × 150ms) + (0.30 × 450ms) + (0.09 × 1200ms) + (0.01 × 2800ms)
= 90ms + 135ms + 108ms + 28ms
= 361ms
```

**Validation**: Production logs show overall average of 358ms (within 1% of calculation)

---

## Load Distribution Strategy for Testing

### Thread Group Sizing (100 Total Threads)

Based on 60/30/9/1% distribution:

| Thread Group | Threads | Percentage | CSV File | Account Size |
|--------------|---------|------------|----------|--------------|
| **Small Accounts** | 60 | 60% | small-accounts.csv | 1-50 positions (avg 26) |
| **Medium Accounts** | 30 | 30% | medium-accounts.csv | 51-200 positions (avg 120) |
| **Large Accounts** | 9 | 9% | large-accounts.csv | 201-500 positions (avg 350) |
| **XLarge Accounts** | 1 | 1% | xlarge-accounts.csv | 500+ positions (avg 750) |

### Expected Test Results

If test accurately mirrors production:

**Aggregate Response Time**: ~361ms (weighted average)
**95th Percentile**: ~550ms (dominated by large account outliers)
**Throughput**: Proportional to production (adjust for environment capacity)
**Error Rate**: < 1% (matching production)

---

## Business Insights

### 1. Majority of Customers Are Small Accounts
- **60% of accounts** have fewer than 50 positions
- These are typically:
  - New investors
  - Retirement accounts (target-date funds)
  - Conservative portfolios (index funds only)
- **Implication**: Performance for small accounts is critical to user experience

### 2. Medium Accounts Drive Significant Load
- **30% of accounts** with 51-200 positions
- Represent:
  - Active traders
  - Diversified portfolios
  - Managed accounts
- **Implication**: Cannot be ignored despite being minority

### 3. Large Accounts Are Edge Cases But Critical
- **9% of accounts** with 201-500 positions
- Typically:
  - High-net-worth individuals
  - Institutional accounts
  - Complex trading strategies
- **Implication**: May breach SLAs (1200ms > 500ms target) - requires optimization

### 4. XLarge Accounts Are Rare But Problematic
- **1% of accounts** with 500+ positions
- Outliers:
  - Ultra-high-net-worth clients
  - Hedge fund accounts
  - Legacy accounts with historical positions
- **Implication**: 2800ms response time is unacceptable - requires architectural review

---

## Recommendations

### Performance Testing Priorities

1. **Baseline Test**: Use 60/30/9/1% distribution (this example)
2. **Peak Load Test**: 2x normal load to test Black Monday scenarios
3. **Stress Test**: Focus on large accounts (increase 9% → 20%)
4. **Spike Test**: Simulate market open rush (8x load for 5 minutes)

### System Optimization Priorities

1. **Database Indexing**: Optimize queries for accounts with 200+ positions
2. **Caching Strategy**: Cache position data for small accounts (high volume, low change rate)
3. **Response Pagination**: Implement pagination for accounts with 100+ positions
4. **Async Processing**: Large account queries should be asynchronous

### SLA Recommendations

Current SLA (95th percentile < 500ms) is failing for large accounts:

| Account Size | Recommended SLA | Rationale |
|--------------|----------------|-----------|
| 1-50 positions | < 200ms | Fast response critical for majority of users |
| 51-200 positions | < 600ms | Reasonable for moderate complexity |
| 201-500 positions | < 1500ms | Users expect slower response for large portfolios |
| 500+ positions | < 3000ms | Rare case; async notification acceptable |

**Overall SLA**: 95th percentile < 600ms (adjusted for reality)

---

## Data Validation

### Cross-Reference with Business Metrics

| Metric | API Logs | CRM Data | Match? |
|--------|----------|----------|--------|
| Total accounts | 427,318 | 428,502 | ✅ 99.7% |
| Avg positions per account | 87 | 89 | ✅ 97.8% |
| Small account % | 60% | 62% | ✅ 96.7% |
| Large account % | 10% | 9.5% | ✅ 95.0% |

**Conclusion**: Production data is reliable and representative

---

## Appendix: Raw Data Sample

```sql
-- Query used to generate distribution
SELECT
  CASE
    WHEN position_count BETWEEN 1 AND 50 THEN '1-50'
    WHEN position_count BETWEEN 51 AND 200 THEN '51-200'
    WHEN position_count BETWEEN 201 AND 500 THEN '201-500'
    ELSE '500+'
  END AS account_size_category,
  COUNT(*) AS api_calls,
  AVG(position_count) AS avg_positions,
  AVG(response_time_ms) AS avg_response_time,
  PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY response_time_ms) AS p95_response_time
FROM api_logs
WHERE endpoint = '/api/v1/accounts/{accountId}/positions'
  AND status_code = 200
  AND date BETWEEN '2025-12-01' AND '2025-12-31'
GROUP BY account_size_category
ORDER BY account_size_category;
```

---

**Analysis Date**: January 2, 2026
**Analyst**: Performance Engineering Team
**Version**: 1.0
