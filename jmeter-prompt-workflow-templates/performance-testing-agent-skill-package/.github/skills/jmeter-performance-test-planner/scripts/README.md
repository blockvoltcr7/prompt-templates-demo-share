# Script Contracts

This directory should contain deterministic Python scripts used by the `jmeter-performance-test-planner` skill.

The model must not calculate performance metrics manually. All math and statistics must come from these scripts.

## General script requirements

Each script should:

- Accept structured JSON input.
- Emit structured JSON output.
- Avoid interactive prompts.
- Provide `--help` output.
- Return non-zero exit codes for validation failures.
- Include clear error messages.
- Avoid printing non-JSON content to stdout when called in machine-readable mode.

Recommended CLI pattern:

```bash
python scripts/<script_name>.py --input input.json --output output.json
```

## `validate_inputs.py`

Purpose:

Validate endpoint, request, and production traffic inputs.

Should validate:

- Endpoint is present.
- HTTP method is present.
- Required production traffic windows are present.
- Traffic values are numeric and non-negative.
- Payload is valid JSON when provided.
- Header structure is valid when provided.

Expected output:

```json
{
  "valid": true,
  "errors": [],
  "warnings": []
}
```

## `validate_scenarios.py`

Purpose:

Validate single-scenario or multi-scenario request modeling.

Should validate:

- At least one scenario exists.
- Every scenario has a unique name.
- Every scenario has a description.
- Every scenario has a payload or payload source.
- Complexity indicators are valid if provided.
- Traffic percentages add to 100 when percentages are used.
- Scenario-specific hit counts are valid if hit counts are used.
- No scenario has negative values.

Expected output:

```json
{
  "valid": true,
  "scenario_count": 3,
  "mode": "production_mix",
  "errors": [],
  "warnings": []
}
```

## `analyze_traffic.py`

Purpose:

Calculate normalized production traffic metrics from the three required traffic windows.

Required inputs:

- Last 30 days total hits
- Last 7 days total hits
- Single day total hits

Optional inputs:

- Average response time
- p95 response time
- p99 response time
- Error rate

Should calculate:

- 30-day average RPS
- 7-day average RPS
- Single-day average RPS
- Relative traffic trend
- Recommended traffic source window for test profile calculations
- Warning flags for suspicious traffic data

Expected output shape:

```json
{
  "traffic_metrics": {
    "rps_30_day_avg": 0,
    "rps_7_day_avg": 0,
    "rps_1_day_avg": 0,
    "trend": "stable|increasing|decreasing|unknown",
    "selected_profile_basis": "30_day|7_day|single_day"
  },
  "warnings": []
}
```

## `analyze_scenarios.py`

Purpose:

Calculate scenario-level traffic distribution based on validated scenario input and traffic analysis output.

Should support modes:

- `production_mix`
- `equal_distribution`
- `worst_case`
- `separate_scenario`

Should calculate:

- Scenario traffic share
- Scenario 30-day hits
- Scenario 7-day hits
- Scenario single-day hits
- Scenario RPS values
- Scenario weighted contribution
- Scenario complexity grouping

Expected output shape:

```json
{
  "scenario_metrics": [
    {
      "name": "small_portfolio",
      "traffic_share_percent": 60,
      "rps_30_day_avg": 0,
      "rps_7_day_avg": 0,
      "rps_1_day_avg": 0,
      "complexity_group": "small"
    }
  ],
  "warnings": []
}
```

## `build_test_profile.py`

Purpose:

Convert traffic metrics and scenario metrics into a JMeter-ready test profile.

Should calculate:

- Test type recommendations
- Per-scenario thread group values
- Per-scenario throughput targets
- Per-scenario ramp-up
- Per-scenario duration
- Pacing strategy
- Whether to combine or separate scenarios
- Assertion thresholds when inputs provide SLO/SLA data

Expected output shape:

```json
{
  "test_profile": {
    "test_types": ["baseline", "load", "spike"],
    "jmeter_strategy": "one_thread_group_per_scenario",
    "scenarios": [
      {
        "name": "small_portfolio",
        "thread_group_name": "TG - Small Portfolio",
        "threads": 0,
        "ramp_up_seconds": 0,
        "duration_seconds": 0,
        "target_throughput_per_minute": 0
      }
    ],
    "assertions": [],
    "warnings": []
  }
}
```

## `generate_jmx.py`

Purpose:

Generate the final JMeter `.jmx` file after user approval.

Inputs:

- Approved performance test plan
- Test profile JSON
- Endpoint details
- Scenario definitions
- JMeter asset/template path

Should produce:

- A valid `.jmx` file
- Optional scenario payload files
- Optional README for running the test

Rules:

- Do not include real secrets.
- Use placeholders for tokens, passwords, API keys, and session IDs.
- Preserve scenario labels for reporting.
- Use clear Thread Group and Sampler names.
- Fail clearly if required inputs are missing.

Expected output shape:

```json
{
  "generated": true,
  "jmx_file": "output/performance-test.jmx",
  "supporting_files": [],
  "warnings": []
}
```
