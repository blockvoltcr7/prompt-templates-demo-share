# Performance Test Engineer Agent + JMeter Skill Package

This package consolidates the architecture discussed for a dedicated GitHub Copilot CLI performance testing workflow.

The design separates responsibilities clearly:

```text
Custom Agent = role, behavior, operating mode, session guidance
Skill        = repeatable JMeter performance-testing workflow
Scripts      = deterministic calculations and JMX generation logic
References   = detailed guidance loaded only when needed
Assets       = JMeter templates and examples
```

## Goal

Create a dedicated **Performance Test Engineer** custom agent for GitHub Copilot CLI that uses a reusable **JMeter Performance Test Planner** skill.

The user selects the agent in Copilot CLI, describes the API endpoint and production traffic, and the agent uses the skill to:

1. Collect required endpoint, request, payload, and traffic inputs.
2. Ask whether the endpoint has a single scenario or multiple scenarios.
3. Validate the input structure.
4. Run deterministic Python scripts for all math and statistics.
5. Generate a human-reviewable performance test plan.
6. Stop for approval.
7. Only after approval, generate a JMeter `.jmx` file.

## Critical principle

The model must **not** perform calculations manually.

The model should orchestrate, explain, and structure the workflow. Python scripts should calculate:

- RPS
- Scenario traffic distribution
- Concurrency
- Thread count strategy
- Ramp-up strategy
- Duration strategy
- Throughput targets
- Any derived JMeter profile parameters

## Recommended repository structure

```text
.github/
├── agents/
│   └── performance-test-engineer.agent.md
│
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

## Included files

- `.github/agents/performance-test-engineer.agent.md`  
  The dedicated Copilot CLI custom agent profile.

- `.github/skills/jmeter-performance-test-planner/SKILL.md`  
  The Agent Skill entry point. This is the only required file for the skill.

- `.github/skills/jmeter-performance-test-planner/references/*.md`  
  Supporting guidance for traffic input, scenarios, JMeter design, deterministic math, output format, and approval gates.

- `.github/skills/jmeter-performance-test-planner/scripts/README.md`  
  Contracts for the deterministic Python scripts that should be implemented later.

- `.github/skills/jmeter-performance-test-planner/assets/README.md`  
  Guidance for adding `.jmx` templates and examples.

- `docs/*.md`  
  Consolidated architecture and implementation notes.

## Usage in GitHub Copilot CLI

Inside Copilot CLI interactive mode:

```text
/agent
```

Select:

```text
performance-test-engineer
```

Then ask for a performance test plan, for example:

```text
Prepare a JMeter performance test plan for POST /api/v1/portfolio/diagnose.
The endpoint accepts different portfolio payload scenarios.
```

Or start from the command line:

```bash
copilot --agent performance-test-engineer --prompt "Prepare a JMeter performance test plan for this API endpoint."
```

## Next implementation step

Implement the Python scripts described in:

```text
.github/skills/jmeter-performance-test-planner/scripts/README.md
```

The first script to build should be:

```text
validate_inputs.py
```

Then:

```text
validate_scenarios.py
analyze_traffic.py
analyze_scenarios.py
build_test_profile.py
generate_jmx.py
```
