# Architecture Overview

## What we are building

We are building a dedicated performance testing workflow for GitHub Copilot CLI.

The workflow has two main components:

1. **Custom Agent**: `performance-test-engineer.agent.md`
2. **Agent Skill**: `jmeter-performance-test-planner/SKILL.md`

The agent provides the specialized role and operating behavior. The skill provides the reusable implementation workflow.

## Why use both an agent and a skill?

A skill alone can perform a task when invoked. A custom agent improves the overall session because the user can switch into a dedicated performance testing persona.

The agent makes Copilot behave like a senior API performance testing engineer for the whole session.

The skill provides the structured workflow for collecting data, running deterministic scripts, producing a plan, gating approval, and generating JMeter assets.

## Responsibility separation

```text
Performance Test Engineer Agent
├── Owns the role
├── Owns the session behavior
├── Knows when to use the JMeter skill
├── Requires scenario discovery
├── Requires deterministic calculations
└── Requires approval before JMX generation

JMeter Performance Test Planner Skill
├── Owns the repeatable workflow
├── Collects endpoint and traffic inputs
├── Validates data through scripts
├── Runs deterministic calculations through scripts
├── Produces the performance test plan
└── Generates .jmx only after approval

Python Scripts
├── Validate inputs
├── Validate scenarios
├── Analyze production traffic
├── Analyze scenario distribution
├── Build test profiles
└── Generate JMeter files
```

## High-level execution flow

```text
User selects performance-test-engineer agent
        ↓
Agent receives performance testing request
        ↓
Agent invokes or relies on /jmeter-performance-test-planner skill
        ↓
Skill collects endpoint, payload, traffic, and scenario inputs
        ↓
Skill runs validation scripts
        ↓
Skill runs traffic and scenario analysis scripts
        ↓
Skill runs test profile builder script
        ↓
Agent presents a human-reviewable performance test plan
        ↓
Agent stops for approval
        ↓
User replies approve or requests changes
        ↓
After approval, skill generates JMeter .jmx
```

## Key design decision

The model must not calculate performance numbers.

The model may:

- Ask questions
- Structure the plan
- Explain the test strategy
- Identify missing information
- Present script outputs
- Use the skill workflow
- Generate or modify files after approval

The model must not:

- Calculate RPS manually
- Calculate concurrency manually
- Calculate thread counts manually
- Calculate ramp-up values manually
- Calculate scenario traffic split manually
- Invent production traffic values
- Generate `.jmx` before approval

## Scenario-aware design

The workflow must not assume one endpoint equals one workload.

The same endpoint can have different payloads, business flows, request sizes, or computational complexity.

Example:

```text
POST /api/v1/portfolio/diagnose

Scenario 1: Small portfolio, 10 positions
Scenario 2: Medium portfolio, 100 positions
Scenario 3: Large portfolio, 1,000 positions
Scenario 4: Complex portfolio with derivatives or missing metadata
```

The test plan must model these as one or more scenarios.

## Approval gate

The first deliverable is always the performance test plan.

The `.jmx` file is generated only after explicit user approval.

This prevents unsafe or incorrect test generation and gives the user a review point before committing to a load profile.
