# Approval Gate

## Rule

The skill must stop after producing the performance test plan.

Do not generate the `.jmx` file until the user explicitly approves.

## Required approval message

Use this exact approval request unless the user has requested different wording:

```text
Please review this performance test plan. Reply `approve` to generate the JMeter `.jmx` file, or provide changes.
```

## Valid approval examples

The user may approve with:

```text
approve
approved
looks good, proceed
yes, generate the jmx
proceed with the jmx
```

## Non-approval examples

These do not count as approval:

```text
maybe
continue thinking
what do you recommend?
show me the plan again
make some changes
```

## After approval

After approval:

1. Use the approved plan.
2. Use deterministic script output.
3. Use available JMeter templates or examples.
4. Generate `.jmx`.
5. Do not run the test unless separately requested.

## If the user requests changes

If the user provides changes instead of approval:

1. Update the plan.
2. Re-run scripts if the changes affect calculations.
3. Present the revised plan.
4. Ask for approval again.

## Safety

Even after approval to generate `.jmx`, do not execute a load test unless the user separately asks to run it.
