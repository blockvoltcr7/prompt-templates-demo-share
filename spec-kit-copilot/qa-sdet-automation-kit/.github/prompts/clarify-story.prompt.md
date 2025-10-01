---
description: Identify underspecified areas in the story analysis by asking targeted clarification questions.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

Goal: Detect and reduce ambiguity or missing information in the story analysis before creating the test plan.

Note: This clarification workflow is expected to run AFTER `/analyze-story` and BEFORE `/test-plan`.

## Execution Flow (main)

```
1. Run `.specify/scripts/powershell/check-test-prerequisites.ps1 -Json -PathsOnly`
   → Parse STORY_DIR, ANALYSIS_FILE
   → If story-analysis.md missing: ERROR "Run /analyze-story first"
2. Load story analysis document
3. Perform ambiguity scan using QA-specific taxonomy
4. Generate prioritized queue of clarification questions (maximum 5)
5. Present questions ONE AT A TIME (interactive loop)
6. After each answer, integrate immediately into story-analysis.md
7. Continue until all critical ambiguities resolved or 5 questions asked
8. Report completion and suggest next command: /test-plan
```

## QA-Specific Ambiguity Taxonomy

Scan for the following categories and mark status: Clear / Partial / Missing

### Test Scope & Coverage
- What specific functionality should be tested?
- What is explicitly out of scope?
- What test levels are required (UI/API/Integration/E2E)?
- Are there specific edge cases mentioned?

### User Personas & Permissions
- Who are the users involved?
- What permissions/roles do they have?
- Are there different user types with different behaviors?
- What authentication/authorization is required?

### Acceptance Criteria Clarity
- Are acceptance criteria testable and measurable?
- Are there vague terms ("user-friendly", "fast", "reliable")?
- Are success conditions clearly defined?
- Are failure conditions defined?

### Test Data Requirements
- What data is needed for testing?
- What are valid data formats and ranges?
- What are invalid data scenarios?
- Are there specific data constraints or business rules?

### Integration & Dependencies
- What external systems are involved?
- What APIs or services are called?
- What happens when dependencies fail?
- Are there mock/stub requirements?

### Non-Functional Requirements
- Performance expectations (response time, load)?
- Security requirements (encryption, auth, authorization)?
- Accessibility requirements (WCAG level)?
- Compatibility requirements (browsers, devices, OS)?

### Error Handling & Validation
- What error messages should appear?
- How should validation failures be handled?
- What are the error recovery mechanisms?
- Are there specific error codes or formats?

### Workflow & State Transitions
- What is the complete user journey?
- What states can the system be in?
- What transitions are allowed?
- What are the preconditions for each step?

### Business Rules & Logic
- What business rules apply?
- Are there calculations or transformations?
- Are there conditional behaviors?
- What are the edge cases for business logic?

### Environment & Configuration
- What test environments are needed?
- What configuration is required?
- Are there feature flags or toggles?
- What database state is needed?

## Question Generation Rules

For each category with Partial/Missing status:

1. **Maximum 5 questions total** across the entire session
2. **Question format**: Either multiple-choice (2-5 options) OR short answer (≤5 words)
3. **Prioritize by impact**:
   - HIGH: Ambiguity blocks test design or execution
   - MEDIUM: Ambiguity affects test coverage or completeness
   - LOW: Nice-to-have clarification

4. **Question criteria**:
   - Must materially impact test planning or execution
   - Must be answerable by Product Owner / Business Analyst
   - Must reduce downstream rework risk
   - Must enable better test coverage

## Interactive Questioning Loop

Present EXACTLY ONE question at a time:

### Multiple Choice Format:
```
**Question [N/5]**: [Question text]

| Option | Description |
|--------|-------------|
| A | [Option A description] |
| B | [Option B description] |
| C | [Option C description] |
| Other | Provide a different short answer (≤5 words) |

Please select an option or provide your answer.
```

### Short Answer Format:
```
**Question [N/5]**: [Question text]

**Format**: Short answer (≤5 words)

Please provide your answer.
```

## Integration After Each Answer

After user provides an answer:

1. **Validate Answer**:
   - Ensure it maps to an option or meets format requirement
   - If ambiguous, ask for quick disambiguation (doesn't count as new question)

2. **Record in Clarifications Section**:
   - Ensure `## Clarifications` section exists in story-analysis.md
   - Create `### Session YYYY-MM-DD` subheading if not present
   - Append: `- Q: [question] → A: [answer]`

3. **Update Relevant Sections**:
   - **Acceptance Criteria**: Add/refine criteria based on answer
   - **Test Scenarios**: Update scenarios with clarified information
   - **Test Data**: Add data constraints or examples
   - **Non-Functional Requirements**: Add measurable criteria
   - **Business Rules**: Document clarified rules
   - **Edge Cases**: Add newly identified edge cases
   - **Risks**: Update or remove risks that were clarified

4. **Remove Contradictions**:
   - If answer invalidates earlier assumptions, update or remove them
   - Ensure no conflicting information remains

5. **Save Immediately**:
   - Write updated story-analysis.md after each answer
   - Preserve formatting and structure

## Example Questions

### Test Scope
```
**Question 1/5**: What level of testing is required for this story?

| Option | Description |
|--------|-------------|
| A | UI testing only (user interface behavior) |
| B | API testing only (backend endpoints) |
| C | Both UI and API testing |
| D | Integration testing with external systems |

Please select an option.
```

### User Permissions
```
**Question 2/5**: What user roles can perform this action?

**Format**: Short answer (≤5 words)

Please provide your answer. (Example: "Admin and Manager only")
```

### Performance Requirements
```
**Question 3/5**: What is the expected response time for this operation?

| Option | Description |
|--------|-------------|
| A | < 1 second |
| B | < 2 seconds |
| C | < 5 seconds |
| D | No specific requirement |

Please select an option.
```

### Error Handling
```
**Question 4/5**: How should the system handle duplicate entries?

| Option | Description |
|--------|-------------|
| A | Show error message, prevent save |
| B | Auto-merge with existing entry |
| C | Allow duplicates |
| D | Ask user for confirmation |

Please select an option.
```

### Data Validation
```
**Question 5/5**: What is the maximum length for the email field?

**Format**: Short answer (≤5 words)

Please provide your answer. (Example: "255 characters maximum")
```

## Termination Conditions

Stop asking questions when:
- All critical ambiguities resolved (remaining items become unnecessary)
- User signals completion ("done", "good", "no more")
- 5 questions asked
- User explicitly requests to proceed

## Validation After Each Update

- [ ] Clarifications section contains one bullet per answered question
- [ ] Relevant sections updated with clarified information
- [ ] No contradictory information remains
- [ ] Markdown structure intact
- [ ] NEEDS CLARIFICATION markers removed where answered

## Final Report

After questioning loop ends:

```
### Clarification Summary

**Questions Asked**: [N] of 5
**File Updated**: specs/[STORY-KEY]/story-analysis.md

### Coverage Status

| Category | Status | Notes |
|----------|--------|-------|
| Test Scope | Resolved | UI and API testing required |
| User Permissions | Resolved | Admin and Manager roles |
| Performance | Resolved | < 2 seconds response time |
| Error Handling | Deferred | Low impact, can decide during implementation |
| Data Validation | Clear | Already specified in AC |

### Sections Updated
- Acceptance Criteria (added measurable criteria)
- Test Scenarios (refined based on user roles)
- Non-Functional Requirements (added performance target)

### Recommendation
- **Ready to proceed**: Run `/test-plan` to create comprehensive test plan
- **OR** Run `/clarify-story` again if more clarifications needed
```

## Output

After clarification session:
1. Number of questions asked & answered
2. Path to updated story-analysis.md
3. Sections touched
4. Coverage summary table
5. Recommendation (proceed to /test-plan OR another /clarify-story round)

Context for clarification: $ARGUMENTS
