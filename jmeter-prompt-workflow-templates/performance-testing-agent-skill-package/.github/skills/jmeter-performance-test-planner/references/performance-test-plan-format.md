# Performance Test Plan Format

The first deliverable must be a human-reviewable performance test plan.

Do not generate a `.jmx` file until the user approves this plan.

## Required sections

```markdown
# Performance Test Plan

## 1. Endpoint Summary

## 2. Request Details

## 3. Production Traffic Inputs

## 4. Scenario Model

## 5. Script-Calculated Traffic Metrics

## 6. Script-Calculated Scenario Metrics

## 7. Proposed Test Types

## 8. JMeter Design

## 9. Load Profile

## 10. Assertions and Success Criteria

## 11. Test Data and Environment Assumptions

## 12. Risks and Constraints

## 13. Approval Gate
```

## Example structure

```markdown
# Performance Test Plan

## 1. Endpoint Summary

- Method: POST
- Endpoint: /api/v1/portfolio/diagnose
- Content type: application/json

## 2. Request Details

- Payload source: Provided by user
- Authentication: Placeholder required
- Headers: To be confirmed

## 3. Production Traffic Inputs

- Last 30 days total hits: Provided by user
- Last 7 days total hits: Provided by user
- Single production day total hits: Provided by user

## 4. Scenario Model

### Scenario 1: Small Portfolio

- Description: Portfolio diagnosis with 10 positions
- Payload source: Provided by user
- Complexity indicator: 10 positions

### Scenario 2: Medium Portfolio

- Description: Portfolio diagnosis with 100 positions
- Payload source: Provided by user
- Complexity indicator: 100 positions

### Scenario 3: Large Portfolio

- Description: Portfolio diagnosis with 1,000 positions
- Payload source: Provided by user
- Complexity indicator: 1,000 positions

## 5. Script-Calculated Traffic Metrics

Use values returned by:

- scripts/analyze_traffic.py

## 6. Script-Calculated Scenario Metrics

Use values returned by:

- scripts/analyze_scenarios.py

## 7. Proposed Test Types

- Baseline
- Load
- Spike
- Soak

Use script output and user context to select final test types.

## 8. JMeter Design

Recommended structure:

- One Thread Group per scenario
- Shared HTTP Request Defaults
- Shared Header Manager
- Scenario-specific HTTP samplers
- Scenario-specific payload data
- Response assertions
- Backend listener or result collection

## 9. Load Profile

Use values returned by:

- scripts/build_test_profile.py

## 10. Assertions and Success Criteria

Use user-provided SLA/SLO when available.

Do not invent thresholds if the user has not provided them. Instead, call them out as missing.

## 11. Test Data and Environment Assumptions

Document:

- Target environment
- Required auth
- Required test data
- Downstream dependencies
- Rate limits

## 12. Risks and Constraints

Document:

- Missing scenario split
- Missing p95/p99 latency
- Missing error rate
- Missing environment capacity
- Missing auth details
- Data pollution risks

## 13. Approval Gate

Please review this performance test plan. Reply `approve` to generate the JMeter `.jmx` file, or provide changes.
```
