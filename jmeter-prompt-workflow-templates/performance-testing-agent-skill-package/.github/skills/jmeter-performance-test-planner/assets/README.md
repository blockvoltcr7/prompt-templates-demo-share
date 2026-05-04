# JMeter Assets

This directory should contain JMeter `.jmx` templates, examples, and supporting files.

The skill should use these files as context and templates when generating JMeter test plans after user approval.

## Recommended future assets

```text
sample-single-scenario.jmx
sample-multi-scenario.jmx
sample-baseline.jmx
sample-load.jmx
sample-spike.jmx
sample-soak.jmx
```

## Purpose of assets

Assets should provide concrete examples of:

- A single-scenario API test plan
- A multi-scenario API test plan
- One Thread Group per scenario
- Throughput Controller based production mix
- Baseline load model
- Spike load model
- Soak load model
- Shared HTTP Header Manager
- HTTP Request Defaults
- CSV Data Set Config
- Response assertions
- Backend listener or result collector configuration

## Asset rules

- Do not store secrets in `.jmx` assets.
- Use placeholders for tokens, API keys, passwords, and session IDs.
- Keep templates generic enough to adapt to different endpoints.
- Label samplers clearly for scenario-level reporting.
- Prefer maintainable JMeter structures over overly complex generated plans.
