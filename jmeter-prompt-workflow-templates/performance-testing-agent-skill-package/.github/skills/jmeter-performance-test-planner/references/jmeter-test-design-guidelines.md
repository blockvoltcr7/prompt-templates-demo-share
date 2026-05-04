# JMeter Test Design Guidelines

## Core JMeter components

When generating or reviewing `.jmx` output, prefer these structures:

- Test Plan
- Thread Group
- HTTP Request Defaults
- HTTP Header Manager
- HTTP Cookie Manager, when needed
- HTTP Authorization Manager, when applicable
- CSV Data Set Config, when test data is required
- HTTP Samplers
- Timers or pacing controls
- Throughput Controllers, when a mixed scenario model is required
- Response Assertions
- Duration Assertions, when appropriate
- Backend Listener or result collection configuration

## Single-scenario design

For a single scenario:

```text
Test Plan
└── Thread Group - Main Scenario
    ├── HTTP Request Defaults
    ├── HTTP Header Manager
    ├── HTTP Sampler - Main Scenario
    └── Assertions
```

## Multi-scenario design: one Thread Group per scenario

Recommended when per-scenario metrics and control are important.

```text
Test Plan
├── HTTP Request Defaults
├── HTTP Header Manager
├── Thread Group - Scenario A
│   └── HTTP Sampler - Scenario A
├── Thread Group - Scenario B
│   └── HTTP Sampler - Scenario B
└── Thread Group - Scenario C
    └── HTTP Sampler - Scenario C
```

## Multi-scenario design: production mix controllers

Recommended when one blended production workload is needed.

```text
Test Plan
└── Thread Group - Production Mix
    ├── Throughput Controller - Scenario A
    │   └── HTTP Sampler - Scenario A
    ├── Throughput Controller - Scenario B
    │   └── HTTP Sampler - Scenario B
    └── Throughput Controller - Scenario C
        └── HTTP Sampler - Scenario C
```

## Payload handling

For scenario-specific payloads:

- Use inline JSON only for simple payloads.
- Use payload files for large or complex payloads.
- Use CSV Data Set Config when payload data is parameterized.
- Do not hard-code secrets.
- Use placeholders for tokens and IDs when necessary.

## Assertions

Assertions should be based on user-provided requirements when possible.

Possible assertions:

- HTTP status code
- Response body contains expected field
- JSON path exists
- Error response is not returned
- Response time threshold, when an SLO exists

## Reporting

Use clear naming so results can be analyzed by scenario.

Example sampler labels:

```text
POST /portfolio/diagnose - small_portfolio
POST /portfolio/diagnose - medium_portfolio
POST /portfolio/diagnose - large_portfolio
```

## Secret handling

Never include real secrets in `.jmx` files.

Use placeholders:

```text
${AUTH_TOKEN}
${API_KEY}
${USERNAME}
${PASSWORD}
```

## Safety

Do not assume production testing is approved.

Do not assume the target environment can handle production-level load.

Always call out:

- Rate limits
- Downstream systems
- Test data pollution
- Capacity constraints
- Monitoring requirements
- Rollback or stop conditions
