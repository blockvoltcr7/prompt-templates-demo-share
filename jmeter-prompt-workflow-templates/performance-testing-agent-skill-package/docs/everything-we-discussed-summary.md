# Everything Discussed: Consolidated Summary

## 1. Initial skill idea

The original idea was to create a performance testing skill that works inside GitHub Copilot CLI and helps a user prepare a JMeter performance test plan.

The skill should collect:

- Endpoint
- Request payload
- Production traffic

The first output should be a performance test plan.

The workflow should stop after the plan and wait for user approval before generating the `.jmx` file.

## 2. Correct skill anatomy

The correct Agent Skill structure is a folder with one required file:

```text
SKILL.md
```

Optional folders include:

```text
scripts/
references/
assets/
```

The earlier idea of using `skill.yaml` or `prompt.md` was corrected. The skill metadata and instructions belong in `SKILL.md`.

## 3. Deterministic math requirement

The model should not perform calculations.

Instead:

- The model collects inputs.
- The model invokes scripts.
- Python scripts calculate traffic statistics and test profile values.
- The model reads script output and formats the plan.

This prevents hallucinated or inconsistent numbers.

## 4. Traffic inputs

The skill should collect three production traffic data points:

- Last 30 days total hits
- Last 7 days total hits
- A single production day total hits

Optional recommended data:

- Average response time
- p95 response time
- p99 response time
- Current error rate
- SLA/SLO
- Target environment

## 5. Dedicated performance test engineer agent

A dedicated custom agent should be created for GitHub Copilot CLI.

The file should be:

```text
.github/agents/performance-test-engineer.agent.md
```

The agent provides the specialized performance testing role and must use the JMeter performance test planner skill.

## 6. Agent and skill relationship

```text
Agent = specialized persona and operating mode
Skill = repeatable workflow
Scripts = deterministic math and generation logic
Assets = JMeter examples/templates
References = supporting documentation
```

The user can toggle into the performance testing agent during a Copilot CLI session.

## 7. Scenario support

The workflow should not assume that one endpoint has only one request pattern.

The agent and skill should ask whether the endpoint has:

- One scenario
- Multiple scenarios
- Multiple payload sizes
- Multiple business workflows
- Multiple query parameter combinations
- Multiple user/account types
- Different downstream dependency paths

For example, a portfolio diagnosis endpoint might process:

- Small portfolios
- Medium portfolios
- Large portfolios
- Complex portfolios

Each scenario may require different JMeter modeling.

## 8. Scenario input

For each scenario, collect:

- Scenario name
- Scenario description
- Example payload
- Scenario-specific headers or query params
- Payload size or complexity indicators
- Traffic share percentage, if known
- Scenario-specific hit counts, if known
- Scenario-specific SLA/SLO, if known
- Whether it should be included in the mixed production load test
- Whether it should also receive its own isolated test

## 9. Scenario traffic rules

The model must not calculate scenario distribution.

If the user does not know the traffic split, ask the user to choose one of these modes:

1. Production-mix mode
2. Equal-distribution mode, with explicit approval
3. Worst-case mode
4. Separate-scenario mode

## 10. JMeter design options

For multiple scenarios, the JMeter design may use:

- One Thread Group per scenario
- One Thread Group with Throughput Controllers
- Separate `.jmx` files per scenario

Recommended default:

- Use one Thread Group per scenario for better control and reporting.
- Use mixed production mode when scenario traffic split is known.
- Recommend separate worst-case testing for heavy scenarios.

## 11. Approval gate

The workflow must always stop after generating the performance test plan.

The approval request should be explicit:

```text
Please review this performance test plan. Reply `approve` to generate the JMeter `.jmx` file, or provide changes.
```

No `.jmx` should be generated before approval.

## 12. Final recommended structure

```text
.github/
├── agents/
│   └── performance-test-engineer.agent.md
└── skills/
    └── jmeter-performance-test-planner/
        ├── SKILL.md
        ├── scripts/
        │   └── README.md
        ├── references/
        │   ├── approval-gate.md
        │   ├── deterministic-calculation-rules.md
        │   ├── jmeter-test-design-guidelines.md
        │   ├── performance-test-plan-format.md
        │   ├── scenario-input-schema.md
        │   ├── scenario-modeling-guidelines.md
        │   └── traffic-input-schema.md
        └── assets/
            └── README.md
```
