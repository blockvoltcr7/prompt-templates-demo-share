# Workflow-Driven Prompt Templates

**Principle:** Every prompt template must be tied to a real workflow stage with defined inputs, problems, and expected outputs.

---

## QA Engineer Workflow Stages

```
JIRA Task → Understand → Plan → Implement → Validate → Complete
```

Each stage has:
- **Input:** What you're starting with (the raw material)
- **Problem:** What you're trying to solve at this stage
- **Prompt Template:** The AI-assisted solution
- **Expected Output:** What Copilot should produce
- **Goal:** Why this matters / definition of done

---

## Stage 1: Understand the Requirement

### Input
- JIRA ticket (title, description, acceptance criteria)
- Attached documents (Word/PDF → converted to markdown/screenshots)
- Existing related code (if enhancement/bug fix)

### Problem
- Requirements are often vague or incomplete
- Hidden edge cases not explicitly stated
- Need to identify what's testable vs what's unclear

### Prompt Template
```
Analyze this JIRA task and identify:

**Task:**
[Paste title + description + acceptance criteria]

**Questions to answer:**
1. What are the explicit testable requirements?
2. What edge cases are implied but not stated?
3. What assumptions am I making that need clarification?
4. What test data will I need?
5. What are the integration points (APIs, databases, external systems)?

Format as a structured analysis I can use for test planning.
```

### Expected Output
- List of explicit requirements (directly from AC)
- List of implicit requirements (edge cases, error handling)
- List of questions/clarifications needed
- Initial test data requirements
- Integration dependencies identified

### Goal
Fully understand what needs to be tested before writing any code. Surface unknowns early.

---

## Stage 2: Plan Test Approach

### Input
- Completed requirement analysis (from Stage 1)
- Knowledge of test framework (Serenity BDD, REST Assured)
- Existing test patterns in codebase

### Problem
- Need to decide: API test vs UI test vs both?
- Need to identify test scenarios (positive, negative, boundary)
- Need to estimate scope and prioritize

### Prompt Template
```
Based on this requirement analysis, create a test plan:

**Requirement Summary:**
[Paste your Stage 1 output or task.md content]

**Our Stack:**
- Framework: Serenity BDD with Cucumber
- API Testing: REST Assured
- Database: [your DB]
- Test Data: [how you manage test data]

**Create:**
1. Test scenario list (categorized: happy path, negative, edge case, integration)
2. For each scenario: brief description + priority (P0/P1/P2)
3. Test type recommendation (API/UI/Database/Combined)
4. Test data requirements per scenario
5. Any setup/teardown needs

Format as a test plan I can execute against.
```

### Expected Output
- Prioritized scenario list with categories
- Test type decisions with rationale
- Test data matrix
- Setup/teardown requirements
- Estimated test count

### Goal
Have a clear, actionable test plan before writing any test code.

---

## Stage 3: Generate Gherkin Scenarios

### Input
- Test plan (from Stage 2)
- JIRA ticket ID (for tagging)
- Existing feature file patterns in codebase

### Problem
- Need consistent Gherkin format
- Need proper tagging for test execution filtering
- Need scenarios that map to implementation

### Prompt Template
```
Generate Gherkin feature file for these test scenarios:

**JIRA:** [TICKET-ID]
**Feature:** [Feature name]

**Scenarios to cover:**
[Paste scenario list from Stage 2]

**Requirements:**
- Use Serenity BDD Cucumber format
- Tags: @[TICKET-ID], @[priority], @[type] (e.g., @api, @ui, @smoke, @regression)
- Given/When/Then must be implementation-ready (specific, not vague)
- Use Scenario Outline with Examples table for data-driven scenarios
- Background section if common setup needed

**Existing pattern example:**
[Paste an example from your codebase if available]
```

### Expected Output
- Complete .feature file
- Proper tagging structure
- Scenario Outlines with Examples tables where appropriate
- Background section if needed
- Ready to implement step definitions

### Goal
Feature file that can be directly used for implementation, consistent with team patterns.

---

## Stage 4: Implement Step Definitions

### Input
- Gherkin feature file (from Stage 3)
- Existing step definition patterns
- Page objects / API clients available

### Problem
- Need step definitions that follow team patterns
- Need to use existing utilities, not reinvent
- Need clean, maintainable code

### Prompt Template
```
Generate Serenity BDD step definitions for this feature file:

**Feature file:**
[Paste .feature content]

**Our patterns:**
- Step definitions in: [package path]
- API client class: [class name if exists]
- Use @Steps annotation for Serenity actions
- Assertions: AssertJ
- [Any other team conventions]

**Existing step definition example:**
[Paste an example from your codebase]

**Generate:**
1. Step definition class with all Given/When/Then methods
2. Any new API client methods needed
3. Any helper methods for assertions
4. Follow our existing patterns exactly
```

### Expected Output
- Step definition class matching team patterns
- Reuses existing utilities where possible
- Clean separation (steps → actions → API calls)
- Ready to run (or minimal tweaks needed)

### Goal
Working test code that passes code review on first submission.

---

## Stage 5: Generate Test Data

### Input
- Test scenarios requiring data
- Database schema / API contracts
- Data constraints (valid ranges, formats, relationships)

### Problem
- Need realistic test data
- Need boundary values
- Need invalid data for negative tests
- Data must match schema constraints

### Prompt Template
```
Generate test data for these scenarios:

**Scenarios:**
[List scenarios needing data]

**Data model:**
[Paste relevant schema, API contract, or field definitions]

**Constraints:**
- [Field]: [constraint, e.g., "email must be valid format"]
- [Field]: [constraint, e.g., "age between 18-120"]
- [Field]: [constraint, e.g., "status enum: ACTIVE, INACTIVE, PENDING"]

**Generate:**
1. Valid data sets (3-5 examples covering variety)
2. Boundary value data (min, max, edge of valid range)
3. Invalid data sets (for negative testing, with expected error)
4. Format as Java test data (constants, builders, or data provider)
```

### Expected Output
- Valid test data covering happy paths
- Boundary test data
- Invalid test data with expected error messages
- Code-ready format (not just tables)

### Goal
Complete test data coverage without manual creation.

---

## Stage 6: Validate & Debug

### Input
- Test execution results (failures, errors)
- Stack traces, logs
- Expected vs actual results

### Problem
- Test failed - why?
- Is it a test bug or application bug?
- How do I fix it?

### Prompt Template
```
Help me debug this test failure:

**Test:**
[Paste failing scenario or test method]

**Error:**
[Paste stack trace or error message]

**Expected:**
[What should have happened]

**Actual:**
[What actually happened]

**Questions:**
1. What is the likely root cause?
2. Is this a test issue or application issue?
3. How should I fix it?
4. What additional logging/assertions would help?
```

### Expected Output
- Root cause analysis
- Classification (test bug vs app bug)
- Fix recommendation
- Suggestions for better debugging

### Goal
Quickly resolve failures and improve test robustness.

---

## Summary: Input → Output Mapping

| Stage | Input | Output |
|-------|-------|--------|
| 1. Understand | JIRA task + attachments | Requirement analysis, questions, test data needs |
| 2. Plan | Requirement analysis | Prioritized test plan with scenarios |
| 3. Gherkin | Test plan + ticket ID | Feature file with scenarios |
| 4. Implement | Feature file + patterns | Step definitions + helpers |
| 5. Test Data | Scenarios + schema | Valid, boundary, invalid data sets |
| 6. Debug | Failure + logs | Root cause + fix |

---

## Key Principle

**Every prompt must have:**
- Defined input (what you're feeding Copilot)
- Clear problem statement (what you're solving)
- Expected output format (what you want back)
- Context from YOUR codebase (patterns, frameworks, conventions)

**No input = No value.** Generic prompts produce generic, unusable output.
