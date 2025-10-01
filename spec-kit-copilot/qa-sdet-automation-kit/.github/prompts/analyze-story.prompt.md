---
description: Analyze a JIRA story or requirement to extract testable acceptance criteria and identify test coverage gaps.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

Goal: Analyze the provided user story, feature requirement, or JIRA ticket to understand what needs to be tested, extract acceptance criteria, identify edge cases, and prepare for comprehensive test coverage.

This is the **FIRST** step in the QA/SDET workflow. All subsequent commands depend on a complete story analysis.

Execution steps:

1. Run `.specify/scripts/powershell/create-test-feature.ps1 -Json "$ARGUMENTS"` from repo root and parse JSON output for BRANCH_NAME, STORY_ID, and ANALYSIS_FILE. All paths must be absolute.
   **IMPORTANT**: Run this script exactly once. Parse the JSON output to get file paths.

2. Parse the story input and extract:
   - **Story ID**: JIRA ticket number or story identifier
   - **Story Title**: Concise description
   - **Story Description**: Full user story or requirement text
   - **Acceptance Criteria**: Explicit criteria from the story
   - **Definition of Done**: Completion requirements
   - **Dependencies**: Related stories, APIs, services, or prerequisites

3. Analyze the story for testability:
   - **Testable Requirements**: Convert vague requirements into measurable test conditions
   - **Happy Path Scenarios**: Primary user flows that should succeed
   - **Negative Scenarios**: Error conditions, validation failures, boundary violations
   - **Edge Cases**: Boundary values, concurrent operations, race conditions
   - **Non-Functional Requirements**: Performance, security, accessibility, compatibility
   - **Data Requirements**: Test data needs, data states, data dependencies

4. Identify ambiguities and questions:
   - Mark unclear requirements with `[NEEDS CLARIFICATION: specific question]`
   - Flag missing acceptance criteria
   - Identify untestable or vague statements (e.g., "system should be fast")
   - Note assumptions being made

5. Determine test scope and coverage areas:
   - **UI Testing**: Frontend components, user interactions, visual validation
   - **API Testing**: Endpoints, request/response validation, contract testing
   - **Integration Testing**: Service interactions, database operations, third-party integrations
   - **E2E Testing**: Complete user journeys across multiple systems
   - **Performance Testing**: Load, stress, scalability requirements
   - **Security Testing**: Authentication, authorization, data protection
   - **Accessibility Testing**: WCAG compliance, screen reader support

6. Extract system components involved:
   - **Frontend Components**: Pages, forms, modals, components to test
   - **Backend Services**: APIs, microservices, databases
   - **External Systems**: Third-party APIs, payment gateways, notification services
   - **Test Environment Requirements**: Test data, mock services, environment configurations

7. Identify test automation feasibility:
   - **High Priority for Automation**: Repetitive, stable, critical path scenarios
   - **Manual Testing Required**: Exploratory, visual validation, usability testing
   - **Automation Challenges**: Dynamic content, third-party dependencies, timing issues

8. Generate the story analysis document using `.specify/templates/story-analysis-template.md`:
   - Replace all placeholders with concrete information
   - Include all extracted and analyzed content
   - Preserve all `[NEEDS CLARIFICATION]` markers
   - Add risk assessment and testing recommendations

9. Write the analysis to ANALYSIS_FILE (test-stories/[STORY_ID]/story-analysis.md).

10. Validation checks:
    - [ ] Story ID and title captured
    - [ ] All acceptance criteria extracted or marked as missing
    - [ ] At least 3 test scenarios identified (happy path + negative cases)
    - [ ] Test scope areas defined
    - [ ] Ambiguities clearly marked
    - [ ] System components mapped
    - [ ] Automation feasibility assessed

11. Report completion:
    - Story ID and branch name
    - Path to analysis file
    - Number of acceptance criteria found
    - Number of test scenarios identified
    - Critical clarifications needed (if any)
    - Suggested next command: `/test-plan` or `/clarify-story` if ambiguities exist

Behavior rules:
- If the story input is insufficient, request more details
- Do NOT make assumptions about technical implementation details
- Focus on WHAT to test, not HOW to automate (that comes in strategy phase)
- Mark every ambiguity explicitly - better to over-clarify than under-clarify
- If acceptance criteria are missing, infer them from the story description but mark as `[INFERRED]`
- Extract both functional and non-functional test requirements

Context: $ARGUMENTS
