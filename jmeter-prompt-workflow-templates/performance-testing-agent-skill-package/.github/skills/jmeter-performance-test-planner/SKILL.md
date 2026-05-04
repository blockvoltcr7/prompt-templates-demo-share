---
name: jmeter-performance-test-planner
description: Use this skill when creating JMeter performance test plans from production traffic data. It collects endpoint, request payload, 30-day, 7-day, and single-day traffic inputs; supports single-scenario and multi-scenario endpoint modeling; runs bundled Python scripts for all calculations; produces a reviewable performance test plan; and only generates .jmx files after explicit user approval.
compatibility: Designed for GitHub Copilot CLI and compatible Agent Skills hosts. Requires Python 3 for deterministic scripts.
metadata:
  domain: "performance-testing"
  tool: "jmeter"
  requires-approval-before-jmx: true
  calculations: "scripts-only"
---

# JMeter Performance Test Planner

## Purpose

Create a deterministic, review-gated performance test plan for a target API endpoint using production traffic data, scenario definitions, and JMeter assets.

The first output is a human-reviewable performance test plan.

Only after explicit user approval should this skill generate a JMeter `.jmx` file.

## When to use this skill

Use this skill when the user wants to:

- Create a JMeter performance test plan
- Generate a JMeter `.jmx` file
- Convert production traffic into a load testing strategy
- Test an API endpoint under load
- Model baseline, load, stress, spike, soak, capacity, or breakpoint tests
- Create scenario-aware tests for different request payloads or business workflows

## Required endpoint inputs

Collect these inputs before proceeding:

- Endpoint URL or path
- HTTP method
- Request payload, if applicable
- Required headers, if applicable
- Authentication requirements, if applicable
- Content type
- Query parameters, if applicable

## Required production traffic inputs

Collect these production traffic inputs:

- Last 30 days total request hits
- Last 7 days total request hits
- Single production day total request hits
- Date or time window for the single-day traffic, when available

## Optional but recommended inputs

Ask for these when available:

- Average response time
- p95 response time
- p99 response time
- Current production error rate
- Existing SLA or SLO
- Target test environment
- Known rate limits
- Downstream dependency constraints
- Test data requirements
- Seasonality or known peak periods

## Scenario discovery

Do not assume that one endpoint has one workload.

Before running traffic calculations, determine whether the endpoint has one scenario or multiple scenarios.

A scenario is a distinct request pattern for the same endpoint.

Examples:

- Different payload sizes
- Different portfolio sizes
- Different number of positions
- Different account types
- Different query parameters
- Different business workflows
- Different downstream dependency behavior

Ask the user:

```text
Does this endpoint have one request scenario or multiple scenarios?

Examples:
- Same endpoint with different payload sizes
- Same endpoint with different business use cases
- Same endpoint with different query parameters
- Same endpoint with different user/account types
- Same endpoint with different downstream behavior
```

## Required scenario inputs

For a single scenario, collect:

- Scenario name
- Scenario description
- Example request payload
- Payload complexity indicators, if applicable

For multiple scenarios, collect each scenario with:

- Scenario name
- Scenario description
- Example request payload
- Scenario-specific headers or query params
- Payload complexity indicators
- Traffic share percentage, if known
- Scenario-specific hit counts, if known
- Scenario-specific SLA/SLO, if known
- Whether the scenario should be included in the mixed production load test
- Whether the scenario should also receive its own isolated test

## Scenario traffic rules

Do not calculate scenario distribution manually.

Use `scripts/validate_scenarios.py` to validate scenario input.

Use `scripts/analyze_scenarios.py` to calculate scenario-level traffic distribution.

If multiple scenarios are provided and no traffic distribution exists, stop and ask the user to select one of these modes:

- Production-mix mode: user provides traffic percentage or hit count per scenario.
- Equal-distribution mode: each scenario receives equal traffic; user must explicitly approve this assumption.
- Worst-case mode: focus test load on the heaviest scenario.
- Separate-scenario mode: generate separate test profiles for each scenario instead of mixing them.

Do not assume the mode silently.

## Critical calculation rules

Never perform calculations manually.

Always use scripts in `scripts/` for:

- Traffic normalization
- RPS calculations
- Scenario distribution
- Concurrency calculations
- Thread count strategy
- Ramp-up strategy
- Duration strategy
- Throughput target derivation
- Test profile generation

Treat script output as the source of truth.

If script output conflicts with expectations, do not correct the values manually. Ask the user to verify inputs or update the scripts.

## Available scripts

The deterministic implementation should be provided by these scripts:

- `scripts/validate_inputs.py`
- `scripts/validate_scenarios.py`
- `scripts/analyze_traffic.py`
- `scripts/analyze_scenarios.py`
- `scripts/build_test_profile.py`
- `scripts/generate_jmx.py`

The script contracts are documented in `scripts/README.md`.

## References

Use the reference files when more detail is needed:

- `references/traffic-input-schema.md`
- `references/scenario-input-schema.md`
- `references/scenario-modeling-guidelines.md`
- `references/deterministic-calculation-rules.md`
- `references/performance-test-plan-format.md`
- `references/jmeter-test-design-guidelines.md`
- `references/approval-gate.md`

## Assets

JMeter templates and examples should live in `assets/`.

Expected future assets include:

- `sample-single-scenario.jmx`
- `sample-multi-scenario.jmx`
- `sample-baseline.jmx`
- `sample-load.jmx`
- `sample-spike.jmx`
- `sample-soak.jmx`

Do not invent template behavior that is not represented by the available assets or script output.

## Required workflow

For every performance test request:

1. Collect endpoint and request details.
2. Collect production traffic inputs.
3. Ask whether the endpoint has one scenario or multiple scenarios.
4. Collect scenario details.
5. Write the collected input to a temporary JSON file.
6. Run `scripts/validate_inputs.py`.
7. Run `scripts/validate_scenarios.py`.
8. Run `scripts/analyze_traffic.py`.
9. Run `scripts/analyze_scenarios.py`.
10. Run `scripts/build_test_profile.py`.
11. Read the deterministic JSON output from the scripts.
12. Produce a human-readable performance test plan.
13. Stop and ask for approval.
14. Only after approval, run or use `scripts/generate_jmx.py` to generate the `.jmx` file.

## Output contract before approval

Return a performance test plan with:

- Endpoint summary
- HTTP method
- Payload summary
- Header and authentication assumptions
- Traffic input summary
- Scenario list
- Payload summary for each scenario
- Complexity indicators for each scenario
- Traffic allocation method
- Script-calculated traffic metrics
- Script-calculated scenario traffic profile
- Proposed JMeter test types
- Proposed JMeter structure
- Thread group strategy
- Ramp-up strategy
- Duration strategy
- Throughput targets
- Assertions
- Test data requirements
- Environment assumptions
- Risks and constraints
- Approval request

## Approval gate

After producing the test plan, stop.

Ask:

```text
Please review this performance test plan. Reply `approve` to generate the JMeter `.jmx` file, or provide changes.
```

Do not continue without explicit approval.

## After approval

After the user explicitly approves:

1. Use the approved plan and script output.
2. Use available JMeter assets as templates or examples.
3. Generate the `.jmx` file through the deterministic generation path.
4. Use placeholders for secrets.
5. Do not run the load test unless the user separately requests execution.

## Safety rules

Never recommend running load tests against production unless the user explicitly confirms production testing is approved.

Never assume the target environment can safely absorb generated load.

Always call out:

- Downstream dependency risks
- Rate limits
- Data pollution risks
- Environment capacity constraints
- Missing authentication details
- Missing test data requirements
- Missing scenario traffic distribution

## JMeter design preferences

For one scenario:

- Generate one JMeter test plan.

For multiple scenarios with known traffic mix:

- Generate one production-mix test plan.
- Prefer one Thread Group per scenario unless the user prefers Throughput Controllers.

For multiple scenarios without known traffic mix:

- Ask the user to provide the mix or approve a selected mode.

For a clearly heavy scenario:

- Include a recommendation for a separate worst-case scenario test.
