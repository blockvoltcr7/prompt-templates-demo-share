# Traffic Input Schema

The skill requires three production traffic data points.

## Required traffic inputs

```json
{
  "traffic": {
    "last_30_days_total_hits": 0,
    "last_7_days_total_hits": 0,
    "single_day_total_hits": 0,
    "single_day_date": "YYYY-MM-DD"
  }
}
```

## Field definitions

| Field | Required | Description |
|---|---:|---|
| `last_30_days_total_hits` | Yes | Total request hits for the endpoint over the last 30 days. |
| `last_7_days_total_hits` | Yes | Total request hits for the endpoint over the last 7 days. |
| `single_day_total_hits` | Yes | Total request hits for a representative or important production day. |
| `single_day_date` | Preferred | The date used for the single-day traffic sample. |

## Optional production context

```json
{
  "observability": {
    "avg_response_time_ms": 0,
    "p95_response_time_ms": 0,
    "p99_response_time_ms": 0,
    "error_rate_percent": 0
  },
  "slo": {
    "p95_response_time_ms": 0,
    "max_error_rate_percent": 0
  },
  "environment": {
    "target_environment": "performance|staging|production",
    "production_testing_approved": false,
    "known_rate_limits": [],
    "downstream_dependencies": []
  }
}
```

## Rules

- The model must not calculate RPS from these values.
- The model must pass these values to `scripts/analyze_traffic.py`.
- The script output is the source of truth.
- If any required value is missing, the skill should ask the user for it before continuing.
- If traffic values appear inconsistent, the skill should rely on validation warnings from scripts and ask the user to confirm the inputs.
