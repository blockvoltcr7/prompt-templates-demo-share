# Scenario Modeling Guidelines

## Definition

A scenario is a distinct way an endpoint is exercised.

Same endpoint does not always mean same performance cost.

Different payloads, user types, account structures, or business operations can create different backend work.

## Common scenario types

- Different payload sizes
- Different object counts
- Different portfolio sizes
- Different query parameter combinations
- Different user roles
- Different account types
- Different business workflows
- Different downstream dependency paths
- Different data setup requirements
- Different response sizes

## Portfolio example

Endpoint:

```text
POST /api/v1/portfolio/diagnose
```

Scenarios:

```text
small_portfolio     = 10 positions
medium_portfolio    = 100 positions
large_portfolio     = 1,000 positions
complex_portfolio   = derivatives, options, illiquid assets, missing metadata
```

The large and complex scenarios may have much higher backend cost even if their production traffic share is small.

## Required scenario discovery question

Always ask:

```text
Does this endpoint have one request scenario or multiple scenarios?

Examples:
- Same endpoint with different payload sizes
- Same endpoint with different business use cases
- Same endpoint with different query parameters
- Same endpoint with different user/account types
- Same endpoint with different downstream behavior
```

## Scenario traffic modes

### 1. Production-mix mode

Use this when the user knows the traffic share or hit count per scenario.

The scripts calculate each scenario's derived load profile.

### 2. Equal-distribution mode

Use this only when the user explicitly approves equal distribution.

The model must not silently assume equal traffic.

### 3. Worst-case mode

Use this when the goal is to test the most expensive scenario.

This is useful for large payloads, high-complexity business cases, or capacity-risk analysis.

### 4. Separate-scenario mode

Use this when each scenario should have its own profile or `.jmx` file.

This is useful for isolated benchmarking and finding breakpoints.

## JMeter mapping options

### Option 1: One Thread Group per scenario

Recommended when per-scenario control and reporting are important.

```text
Test Plan
├── Thread Group - Small Portfolio
│   └── HTTP Sampler - Diagnose Small Portfolio
├── Thread Group - Medium Portfolio
│   └── HTTP Sampler - Diagnose Medium Portfolio
└── Thread Group - Large Portfolio
    └── HTTP Sampler - Diagnose Large Portfolio
```

### Option 2: One Thread Group with Throughput Controllers

Recommended when the test should simulate a blended production mix.

```text
Test Plan
└── Thread Group - Production Mix
    ├── Throughput Controller - Small Portfolio
    │   └── HTTP Sampler
    ├── Throughput Controller - Medium Portfolio
    │   └── HTTP Sampler
    └── Throughput Controller - Large Portfolio
        └── HTTP Sampler
```

### Option 3: Separate `.jmx` files per scenario

Recommended for isolated capacity and breakpoint testing.

```text
portfolio-small-load-test.jmx
portfolio-medium-load-test.jmx
portfolio-large-load-test.jmx
```

## Recommended default behavior

```text
If one scenario:
  Generate one test plan.

If multiple scenarios with known traffic mix:
  Generate one production-mix test plan.
  Prefer one Thread Group per scenario unless the user prefers controllers.

If multiple scenarios without known traffic mix:
  Ask the user to provide the mix or approve a selected mode.

If one scenario is clearly heavier:
  Include a recommendation for a separate worst-case scenario test.
```
