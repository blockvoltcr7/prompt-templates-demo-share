# Deterministic Calculation Rules

## Core rule

The model must not perform performance test calculations manually.

All calculations must be delegated to deterministic scripts.

## Why this matters

Performance test parameters can directly affect infrastructure load, downstream dependencies, and test validity.

Incorrect calculations can lead to:

- Unsafe load tests
- Invalid results
- Under-testing
- Over-testing
- Misleading stakeholder reports
- Production or environment impact

## The model may do this

The model may:

- Collect input
- Ask clarifying questions
- Identify missing data
- Invoke scripts
- Read script outputs
- Format a plan
- Explain strategy
- Apply approval gates
- Generate files after approval using script outputs

## The model must not do this

The model must not manually calculate:

- Average RPS
- Peak RPS
- Concurrency
- Thread counts
- Ramp-up seconds
- Duration
- Throughput per minute
- Scenario distribution
- Weighted traffic contribution
- Any derived JMeter parameter

## Script source of truth

Scripts must calculate:

- Traffic normalization
- Scenario-level traffic allocation
- Traffic trends
- Test profile values
- JMeter parameter values

The model must treat the script output as authoritative.

## Handling suspicious script output

If script output appears wrong, the model should not correct it manually.

Instead, the model should:

1. Report the warning.
2. Ask the user to verify input data.
3. Suggest checking the script logic.
4. Stop until corrected data or approval is provided.

## Required script output style

Scripts should output JSON.

Example:

```json
{
  "valid": true,
  "metrics": {},
  "warnings": [],
  "errors": []
}
```

Avoid free-text output that the model would need to interpret loosely.
