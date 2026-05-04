# Scenario Input Schema

A scenario is a distinct request pattern for the same endpoint.

## Why scenarios matter

One endpoint can process very different workloads depending on payload size, business use case, query parameters, account type, or downstream dependencies.

Example:

```text
POST /api/v1/portfolio/diagnose
```

Possible scenarios:

- Small portfolio with 10 positions
- Medium portfolio with 100 positions
- Large portfolio with 1,000 positions
- Complex portfolio with derivatives, illiquid assets, or missing metadata

## Single-scenario input

```json
{
  "scenarios": [
    {
      "name": "default",
      "description": "Default endpoint request scenario",
      "payload": {},
      "complexity": {},
      "include_in_mixed_load": true,
      "run_as_isolated_test": false
    }
  ]
}
```

## Multi-scenario input

```json
{
  "scenarios": [
    {
      "name": "small_portfolio",
      "description": "Portfolio diagnosis with a small number of positions",
      "payload": {
        "portfolioId": "example-small",
        "positions": []
      },
      "complexity": {
        "position_count": 10
      },
      "traffic_share_percent": 60,
      "include_in_mixed_load": true,
      "run_as_isolated_test": false
    },
    {
      "name": "medium_portfolio",
      "description": "Portfolio diagnosis with a medium number of positions",
      "payload": {
        "portfolioId": "example-medium",
        "positions": []
      },
      "complexity": {
        "position_count": 100
      },
      "traffic_share_percent": 30,
      "include_in_mixed_load": true,
      "run_as_isolated_test": false
    },
    {
      "name": "large_portfolio",
      "description": "Portfolio diagnosis with a large number of positions",
      "payload": {
        "portfolioId": "example-large",
        "positions": []
      },
      "complexity": {
        "position_count": 1000
      },
      "traffic_share_percent": 10,
      "include_in_mixed_load": true,
      "run_as_isolated_test": true
    }
  ]
}
```

## Scenario fields

| Field | Required | Description |
|---|---:|---|
| `name` | Yes | Unique scenario identifier. |
| `description` | Yes | Human-readable scenario description. |
| `payload` | Preferred | Example payload for this scenario. |
| `payload_source` | Optional | File path or external source for payload data. |
| `headers` | Optional | Scenario-specific headers. |
| `query_params` | Optional | Scenario-specific query parameters. |
| `complexity` | Optional | Business or payload complexity indicators. |
| `traffic_share_percent` | Optional | Scenario percentage in mixed production traffic. |
| `scenario_hit_counts` | Optional | Scenario-level hits if known. |
| `slo` | Optional | Scenario-specific SLA/SLO. |
| `include_in_mixed_load` | Preferred | Whether to include scenario in mixed production test. |
| `run_as_isolated_test` | Preferred | Whether to also create a standalone scenario test. |

## Rules

- At least one scenario must exist.
- Scenario names must be unique.
- If traffic percentages are provided, they must add up to 100.
- The model must not calculate scenario distribution manually.
- Missing traffic split must trigger a user choice: production mix, equal distribution, worst case, or separate scenario mode.
