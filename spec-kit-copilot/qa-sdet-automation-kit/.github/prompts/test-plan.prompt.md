---
description: Generate a comprehensive test plan document based on story analysis, defining test objectives, scope, approach, and resource requirements.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

Goal: Create a detailed test plan that defines testing strategy, scope, test types, environment needs, risks, and success criteria for the story.

This command runs AFTER `/analyze-story` (and optionally `/clarify-story`).

Execution steps:

1. Run `.specify/scripts/powershell/check-test-prerequisites.ps1 -Json -RequireAnalysis` from repo root and parse STORY_DIR, ANALYSIS_FILE, and TEST_PLAN_FILE paths.

2. Load and analyze the story analysis document to understand:
   - Acceptance criteria (all must be testable)
   - Test scenarios identified
   - System components involved
   - Test scope areas (UI, API, Integration, etc.)
   - Risks and dependencies

3. Read the QA constitution at `.specify/memory/qa-constitution.md` to understand:
   - Testing principles (e.g., automation-first, BDD mandatory, test data management)
   - Quality gates and coverage requirements
   - Tool standards and framework requirements

4. Load the test plan template at `.specify/templates/test-plan-template.md`.

5. Generate the test plan with these sections:

   **A. Test Overview**
   - Story ID and title
   - Test objectives (what we're validating)
   - In-scope test areas
   - Out-of-scope areas (explicitly state what won't be tested)

   **B. Test Approach**
   - Testing levels: Unit, Integration, System, E2E, Performance, Security
   - Test types for each level
   - Manual vs. Automated testing breakdown
   - Regression testing requirements

   **C. Test Scope Breakdown**
   - **Functional Testing**: Features and workflows to validate
   - **Non-Functional Testing**: Performance, security, accessibility, compatibility
   - **Regression Testing**: Existing features that might be affected
   - **Integration Testing**: Service interactions, API contracts, database operations

   **D. Test Environment Requirements**
   - Environment configurations needed (dev, staging, pre-prod)
   - Test data requirements (volume, types, special conditions)
   - Mock services or stubs needed
   - Third-party integrations to test or mock

   **E. Entry and Exit Criteria**
   - **Entry Criteria**: When testing can begin (code complete, environment ready, test data loaded)
   - **Exit Criteria**: When testing is complete (all tests passed, coverage met, defects resolved)

   **F. Test Deliverables**
   - Test scenarios (Gherkin BDD format)
   - Automated test scripts
   - Test data sets
   - Test execution reports
   - Defect reports

   **G. Risks and Mitigation**
   - Technical risks (flaky tests, environment instability, data dependencies)
   - Schedule risks (blocked by dependencies, environment delays)
   - Resource risks (tool limitations, skill gaps)
   - Mitigation strategies for each risk

   **H. Success Metrics**
   - Test coverage targets (% of acceptance criteria covered)
   - Pass/fail criteria
   - Defect severity thresholds
   - Performance benchmarks (if applicable)

   **I. Schedule and Milestones**
   - Test design completion
   - Automation implementation completion
   - Test execution and reporting
   - Defect resolution and retest

6. Constitution alignment check:
   - Verify test plan follows QA constitution principles
   - Flag any deviations with justification
   - Ensure coverage requirements met
   - Confirm tool and framework choices align with standards

7. Write the test plan to TEST_PLAN_FILE (test-stories/[STORY_ID]/test-plan.md).

8. Validation checklist:
   - [ ] All acceptance criteria from analysis are covered
   - [ ] Entry/exit criteria are clear and measurable
   - [ ] Test scope explicitly defines in-scope and out-of-scope
   - [ ] Environment and data requirements are specific
   - [ ] Risks identified with mitigation strategies
   - [ ] Success metrics are measurable
   - [ ] Constitution principles are followed

9. Report completion:
   - Path to test plan file
   - Number of test areas defined
   - Number of risks identified
   - Critical dependencies highlighted
   - Suggested next command: `/test-scenarios` to generate BDD scenarios

Behavior rules:
- Test plan must be comprehensive but concise (avoid fluff)
- Every test objective must map to an acceptance criterion
- Be explicit about what will NOT be tested
- Risk assessment should be realistic, not generic
- If story analysis has unresolved `[NEEDS CLARIFICATION]`, warn user but proceed with assumptions clearly documented
- Do NOT include automation implementation details (that comes in strategy phase)

Context: $ARGUMENTS
