---
description: Create a comprehensive test plan document based on story analysis.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

You are creating a comprehensive test plan document that defines the testing approach, scope, resources, and schedule for the story. This runs AFTER `/analyze-story`.

## Execution Flow (main)

```
1. Run `.specify/scripts/powershell/check-test-prerequisites.ps1 -Json` to get paths
   → Parse STORY_DIR, ANALYSIS_FILE, TEST_PLAN_FILE
   → If story-analysis.md missing: ERROR "Run /analyze-story first"
2. Load story analysis document
   → Extract scenarios, requirements, risks
3. Load test plan template
   → From `.specify/templates/test-plan-template.md`
4. Define test scope:
   → In-scope: What will be tested
   → Out-of-scope: What will NOT be tested
   → Rationale for scope decisions
5. Define test strategy:
   → Test levels (Unit, Integration, E2E, API, UI)
   → Test types (Functional, Non-functional, Regression)
   → Automation approach (what to automate vs manual)
   → Test framework and tools (Serenity, Cucumber, etc.)
6. Map scenarios to test cases:
   → Each scenario from analysis → Test case ID
   → Assign priority (P0/P1/P2/P3)
   → Assign test type (UI/API/Integration)
7. Define test environment requirements:
   → Test environments needed (dev, staging, prod-like)
   → Test data requirements
   → Access/permissions needed
8. Create test schedule:
   → Test design phase
   → Test implementation phase
   → Test execution phase
   → Defect triage phase
9. Identify test dependencies and risks
10. Generate test plan document
    → Store in specs/[STORY-KEY]/test-plan.md
11. Return: SUCCESS (ready for /gherkin-scenarios)
```

## Test Plan Structure

Generate `test-plan.md` with:

```markdown
# Test Plan: [STORY-KEY] - [Title]

**Story Key**: [STORY-KEY]
**Test Plan Version**: 1.0
**Created**: [DATE]
**Status**: Draft
**Created By**: AI Agent

## 1. Introduction

### 1.1 Purpose
[Describe the purpose of this test plan]

### 1.2 Scope
This test plan covers testing for [story description].

**In Scope:**
- [Feature/functionality 1]
- [Feature/functionality 2]
- [Feature/functionality 3]

**Out of Scope:**
- [Explicitly excluded items]
- [Rationale for exclusions]

### 1.3 References
- Story Analysis: `story-analysis.md`
- JIRA Story: [STORY-KEY]
- Requirements Document: [If applicable]

## 2. Test Strategy

### 2.1 Test Levels
| Test Level | Description | Responsibility | Automation |
|------------|-------------|----------------|------------|
| Unit Tests | [Description] | Developers | 100% |
| API Tests | [Description] | QA/SDET | 100% |
| Integration Tests | [Description] | QA/SDET | 100% |
| UI Tests | [Description] | QA/SDET | 80% |
| E2E Tests | [Description] | QA/SDET | 70% |

### 2.2 Test Types

#### Functional Testing
- **Approach**: [Describe functional testing approach]
- **Coverage**: [What functional areas]
- **Automation**: [Percentage to automate]

#### Non-Functional Testing
- **Performance Testing**: [Response time, load testing approach]
- **Security Testing**: [Auth, authorization, data validation]
- **Accessibility Testing**: [WCAG compliance level]
- **Compatibility Testing**: [Browsers, devices]

#### Regression Testing
- **Scope**: [What existing functionality to verify]
- **Frequency**: [When to run regression]
- **Automation**: [Regression test suite]

### 2.3 Test Automation Strategy
**Framework**: Serenity Cucumber BDD (Java)
**Tools**:
- Build Tool: Maven/Gradle
- Test Framework: JUnit/TestNG
- BDD Framework: Cucumber
- Reporting: Serenity Reports
- CI/CD: Jenkins/GitHub Actions

**Automation Approach**:
- API tests: 100% automated (RestAssured/Serenity Rest)
- UI tests: 80% automated (Selenium WebDriver + Serenity)
- Data-driven tests: Cucumber Examples tables
- Page Object Model: Yes

### 2.4 Entry and Exit Criteria

**Entry Criteria:**
- [ ] Story analysis completed and reviewed
- [ ] Test environment available
- [ ] Test data prepared
- [ ] Access to required systems granted
- [ ] Build deployed to test environment

**Exit Criteria:**
- [ ] All P0/P1 test cases executed
- [ ] 95% pass rate achieved
- [ ] All critical defects resolved
- [ ] Test report generated
- [ ] Code coverage meets threshold (if applicable)

## 3. Test Cases

### 3.1 Test Case Summary
| Test Case ID | Scenario | Priority | Type | Automation | Status |
|--------------|----------|----------|------|------------|--------|
| TC-001 | [Scenario name] | P0 | UI | Yes | Not Started |
| TC-002 | [Scenario name] | P1 | API | Yes | Not Started |
| TC-003 | [Scenario name] | P1 | Integration | Yes | Not Started |

### 3.2 Test Case Mapping

#### Positive Flow Tests
- TC-001: [Description] → [Acceptance Criteria AC-001]
- TC-002: [Description] → [Acceptance Criteria AC-002]

#### Negative Flow Tests
- TC-010: [Description] → [Error handling requirement]
- TC-011: [Description] → [Validation requirement]

#### Edge Case Tests
- TC-020: [Description] → [Boundary condition]
- TC-021: [Description] → [Edge case scenario]

#### Data Validation Tests
- TC-030: [Description] → [Validation rule]
- TC-031: [Description] → [Input sanitization]

## 4. Test Environment

### 4.1 Environment Configuration
| Environment | Purpose | URL/Access | Database | Status |
|-------------|---------|------------|----------|--------|
| Dev | Development testing | [URL] | [DB] | Available |
| Staging | Pre-prod testing | [URL] | [DB] | Available |
| Prod-Like | Performance testing | [URL] | [DB] | Pending |

### 4.2 Test Data Requirements
| Data Type | Description | Volume | Source | Prepared |
|-----------|-------------|--------|--------|----------|
| User accounts | Test users with various roles | 10 | Test data service | No |
| Product data | Sample products | 50 | Database seed | No |
| Transaction data | Historical transactions | 100 | API mock | No |

### 4.3 Tools and Access
- JIRA: Access granted (Yes/No)
- Test Management: [Tool name]
- Test Automation Framework: Serenity Cucumber BDD
- API Testing: RestAssured
- UI Testing: Selenium WebDriver
- Performance Testing: JMeter (if needed)

## 5. Test Schedule

| Phase | Activities | Duration | Start Date | End Date |
|-------|------------|----------|------------|----------|
| Test Planning | Create test plan, review | 1 day | [DATE] | [DATE] |
| Scenario Design | Write Gherkin scenarios | 2 days | [DATE] | [DATE] |
| Test Implementation | Implement test automation | 3 days | [DATE] | [DATE] |
| Test Execution | Run tests, log defects | 2 days | [DATE] | [DATE] |
| Defect Triage | Verify fixes, retest | 1 day | [DATE] | [DATE] |
| Test Closure | Generate report, lessons learned | 1 day | [DATE] | [DATE] |

**Total Estimated Duration**: [X] days

## 6. Risks and Mitigation

| Risk | Impact | Probability | Mitigation Strategy | Owner |
|------|--------|-------------|---------------------|-------|
| Test environment unavailable | High | Medium | Reserve backup environment | DevOps |
| Test data not available | High | Low | Create data generation scripts | QA |
| API not ready | High | Medium | Use API mocks for early testing | QA/Dev |
| Unclear requirements | Medium | Medium | Conduct clarification session | QA/BA |

## 7. Dependencies

### 7.1 Internal Dependencies
- Development team completes feature by [DATE]
- Test environment provisioned by [DATE]
- API documentation available by [DATE]

### 7.2 External Dependencies
- Third-party service access granted
- Test accounts created in external system
- Mock services configured

## 8. Roles and Responsibilities

| Role | Name | Responsibilities |
|------|------|------------------|
| QA Lead | [Name] | Test plan approval, resource allocation |
| SDET/QA Engineer | [Name] | Test implementation, execution, reporting |
| Developer | [Name] | Unit tests, defect fixes |
| Product Owner | [Name] | Acceptance criteria clarification |

## 9. Defect Management

### 9.1 Defect Severity Definitions
- **Critical (P0)**: System crash, data loss, security breach
- **High (P1)**: Major functionality broken, no workaround
- **Medium (P2)**: Functionality impaired, workaround exists
- **Low (P3)**: Minor issue, cosmetic

### 9.2 Defect Workflow
1. QA logs defect in JIRA
2. Dev triages and assigns priority
3. Dev fixes and marks "Ready for Retest"
4. QA verifies fix
5. QA closes defect or reopens if not fixed

## 10. Test Deliverables

- [ ] Test Plan Document (this document)
- [ ] Gherkin BDD Scenarios (feature files)
- [ ] Test Automation Code (Java + Serenity)
- [ ] Test Execution Report (Serenity Report)
- [ ] Defect Report (JIRA export)
- [ ] Test Coverage Report
- [ ] Test Closure Report

## 11. Assumptions

- [Assumption 1]
- [Assumption 2]
- [Assumption 3]

## 12. Open Items

- [NEEDS CLARIFICATION: Item 1]
- [NEEDS CLARIFICATION: Item 2]

## 13. Approval

| Name | Role | Signature | Date |
|------|------|-----------|------|
| [Name] | QA Lead | | |
| [Name] | Engineering Manager | | |
| [Name] | Product Owner | | |

---

## Execution Status
*Updated during workflow*

- [ ] Test plan created
- [ ] Test plan reviewed by team
- [ ] Test environment verified
- [ ] Test data prepared
- [ ] Ready for /gherkin-scenarios command

**Next Command**: `/gherkin-scenarios`
```

## Validation Checklist

Before completing test plan:
- [ ] All scenarios from story-analysis.md mapped to test cases
- [ ] Test strategy clearly defined
- [ ] Automation approach specified
- [ ] Entry/exit criteria defined
- [ ] Test environment requirements documented
- [ ] Risks identified with mitigation
- [ ] Dependencies documented
- [ ] Schedule is realistic
- [ ] All stakeholders identified

## Output

After test plan creation:
1. Report test plan file path
2. List total test cases by priority (P0/P1/P2/P3)
3. List test cases by type (UI/API/Integration)
4. Flag any open items or risks
5. Suggest next command: `/gherkin-scenarios`

Context for test planning: $ARGUMENTS
