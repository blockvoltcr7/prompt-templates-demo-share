---
description: Analyze a JIRA story or ticket to extract testable requirements and identify test scenarios.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

You are analyzing a development story/ticket to extract testable requirements and identify comprehensive test scenarios. This is the FIRST step in the QA test automation workflow.

## Execution Flow (main)

```
1. Load story details from Input
   → If JIRA key provided: Fetch from JIRA API (if configured)
   → If text provided: Parse directly
   → If empty: ERROR "No story provided"
2. Extract key information:
   → Story title, description, acceptance criteria
   → User personas/roles involved
   → Preconditions and postconditions
   → Data requirements
   → Business rules and validations
3. Identify testable scenarios:
   → Positive flow scenarios (happy path)
   → Negative flow scenarios (error cases)
   → Edge cases and boundary conditions
   → Data validation scenarios
   → Integration points with other systems
4. Classify test types needed:
   → UI tests (if frontend changes)
   → API tests (if backend changes)
   → Integration tests (if system interactions)
   → Performance tests (if load concerns)
   → Security tests (if auth/data sensitivity)
5. Extract non-functional requirements:
   → Performance expectations
   → Security/compliance needs
   → Accessibility requirements
   → Browser/device compatibility
6. Identify dependencies and risks:
   → External system dependencies
   → Test data requirements
   → Environment prerequisites
   → Potential blockers
7. Generate story analysis document
   → Store in specs/[STORY-KEY]/story-analysis.md
8. Return: SUCCESS (ready for /test-plan)
```

## Prerequisites

1. Run `.specify/scripts/powershell/create-test-feature.ps1 -Json "$ARGUMENTS"` to initialize the test feature structure.
   - This creates the branch and feature directory
   - Parse JSON output for BRANCH_NAME, STORY_KEY, ANALYSIS_FILE

## Analysis Categories

For each category, extract information from the story:

### Functional Requirements
- What functionality is being delivered?
- What user actions are involved?
- What are the expected outcomes?
- What are the acceptance criteria?

### User Personas
- Who will use this feature?
- What roles/permissions are involved?
- Are there different user types with different behaviors?

### Data Requirements
- What data is needed for testing?
- What are valid/invalid data formats?
- What are the data boundaries (min/max values)?
- Are there special characters or edge cases?

### Integration Points
- Does this interact with other services/APIs?
- Are there database operations?
- Are there third-party integrations?
- What are the failure modes for each integration?

### Non-Functional Requirements
- Performance: Response time expectations
- Security: Authentication/authorization needs
- Accessibility: WCAG compliance level
- Compatibility: Browsers, devices, OS versions

### Test Scenarios Identification
For each requirement, identify:
1. **Positive scenarios** (expected behavior)
2. **Negative scenarios** (error handling)
3. **Edge cases** (boundary conditions)
4. **Data validation scenarios** (input validation)

## Output Structure

Generate `story-analysis.md` with:

```markdown
# Story Analysis: [STORY-KEY] - [Title]

**Story Key**: [STORY-KEY]
**Created**: [DATE]
**Status**: Draft
**Analyzed By**: AI Agent

## Story Summary
[Extract from story description]

## Acceptance Criteria
- [AC1]
- [AC2]
- [AC3]

## User Personas
| Persona | Role | Permissions | Key Behaviors |
|---------|------|-------------|---------------|
| ... | ... | ... | ... |

## Functional Requirements
### FR-001: [Requirement Name]
**Description**: [What needs to be tested]
**Test Types**: UI, API, Integration
**Priority**: High/Medium/Low

## Test Scenario Categories

### Positive Flow Scenarios
1. **[Scenario Name]**: [Description]
   - **Precondition**: [What must be true before]
   - **Steps**: [High-level steps]
   - **Expected Result**: [What should happen]
   - **Test Type**: UI/API/Integration

### Negative Flow Scenarios
1. **[Scenario Name]**: [Description]
   - **Error Condition**: [What error to trigger]
   - **Expected Behavior**: [How system should handle]
   - **Test Type**: UI/API/Integration

### Edge Cases
1. **[Scenario Name]**: [Description]
   - **Boundary Condition**: [What edge to test]
   - **Expected Behavior**: [How system should handle]

### Data Validation Scenarios
1. **[Validation Rule]**: [Description]
   - **Valid Inputs**: [Examples]
   - **Invalid Inputs**: [Examples]
   - **Expected Validation Messages**: [Messages]

## Non-Functional Requirements
### Performance
- Response time: [e.g., < 2 seconds]
- Load capacity: [e.g., 100 concurrent users]

### Security
- Authentication required: Yes/No
- Authorization rules: [Describe]
- Data sensitivity: [PII, financial, etc.]

### Compatibility
- Browsers: [Chrome, Firefox, Safari, Edge]
- Devices: [Desktop, tablet, mobile]
- Screen sizes: [Responsive breakpoints]

## Test Data Requirements
| Data Type | Description | Example | Source |
|-----------|-------------|---------|--------|
| ... | ... | ... | ... |

## Integration Dependencies
| System | Endpoint/Method | Purpose | Failure Mode |
|--------|----------------|---------|--------------|
| ... | ... | ... | ... |

## Risks and Blockers
- [Risk 1]: [Description and mitigation]
- [Risk 2]: [Description and mitigation]

## Test Coverage Summary
- Total scenarios identified: [N]
- UI test scenarios: [N]
- API test scenarios: [N]
- Integration test scenarios: [N]
- Edge cases: [N]

## Next Steps
- [ ] Review story analysis with team
- [ ] Run /test-plan to create comprehensive test plan
- [ ] Identify test data sources
- [ ] Set up test environment

## Ambiguities/Questions
[NEEDS CLARIFICATION: List any unclear requirements or assumptions]
```

## Validation Rules

Before completing:
- [ ] All acceptance criteria mapped to test scenarios
- [ ] Both positive and negative flows identified
- [ ] Edge cases documented
- [ ] Test data requirements clear
- [ ] Integration points identified
- [ ] Non-functional requirements captured
- [ ] Risks documented
- [ ] No undefined acceptance criteria

## Error Handling

- If story is too vague: Mark with [NEEDS CLARIFICATION] and suggest questions to ask
- If acceptance criteria missing: Generate implied scenarios but flag for review
- If integration details missing: Flag as risk/blocker
- If test data requirements unclear: Suggest data generation approach

## Output

After analysis:
1. Report story key and analysis file path
2. List total scenarios identified by type
3. Flag any ambiguities that need clarification
4. Suggest next command: `/test-plan`

Context for analysis: $ARGUMENTS
