# GitHub Copilot CLI Setup

## Project-level installation

Place the custom agent and skill inside the repository:

```text
.github/
├── agents/
│   └── performance-test-engineer.agent.md
└── skills/
    └── jmeter-performance-test-planner/
        ├── SKILL.md
        ├── scripts/
        ├── references/
        └── assets/
```

## Personal installation

For personal reuse across repositories, use:

```text
~/.copilot/
├── agents/
│   └── performance-test-engineer.agent.md
└── skills/
    └── jmeter-performance-test-planner/
        ├── SKILL.md
        ├── scripts/
        ├── references/
        └── assets/
```

## Agent file naming

The custom agent file should use the `.agent.md` suffix:

```text
performance-test-engineer.agent.md
```

## Skill file naming

The skill entry point must be:

```text
SKILL.md
```

Do not use:

```text
skill.yaml
prompt.md
```

The skill metadata belongs in YAML frontmatter inside `SKILL.md`.

## Activating the custom agent

Inside Copilot CLI interactive mode:

```text
/agent
```

Select:

```text
performance-test-engineer
```

Or invoke it from the command line:

```bash
copilot --agent performance-test-engineer --prompt "Prepare a JMeter performance test plan."
```

## Invoking the skill

The agent instructions require use of the skill for performance testing tasks.

The skill may also be invoked directly by name:

```text
/jmeter-performance-test-planner
```

## Recommended session prompt

```text
Use the performance-test-engineer agent and prepare a JMeter performance test plan for this API endpoint.
First ask whether the endpoint has one scenario or multiple request/payload scenarios.
Do not generate the .jmx until I approve the plan.
```
