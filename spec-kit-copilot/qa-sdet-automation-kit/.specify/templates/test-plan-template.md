# Test Plan: [STORY-KEY] - [Title]

**Story Key**: [STORY-KEY]
**Test Plan Version**: 1.0
**Created**: [DATE]
**Status**: Draft
**Created By**: [Your Name / AI Agent]

---

## 1. Introduction

### 1.1 Purpose
This test plan defines the testing approach, scope, resources, and schedule for [STORY-KEY]: [Story Title].

### 1.2 Scope

This test plan covers testing for [brief description of functionality].

**In Scope:**
- [Feature/functionality 1]
- [Feature/functionality 2]
- [Feature/functionality 3]

**Out of Scope:**
- [Explicitly excluded item 1]
- [Explicitly excluded item 2]
- **Rationale**: [Why these are out of scope]

### 1.3 References
- **Story Analysis**: `story-analysis.md`
- **JIRA Story**: [STORY-KEY]
- **Requirements Document**: [Link if applicable]
- **Related Stories**: [Dependencies or related work]

---

## 2. Test Strategy

### 2.1 Test Levels

| Test Level | Description | Responsibility | Automation % |
|------------|-------------|----------------|--------------|
| Unit Tests | [Component-level testing] | Developers | 100% |
| API Tests | [Backend endpoint testing] | QA/SDET | 100% |
| Integration Tests | [Component interaction testing] | QA/SDET | 100% |
| UI Tests | [User interface testing] | QA/SDET | 80% |
| E2E Tests | [Full user journey testing] | QA/SDET | 70% |

### 2.2 Test Types

#### Functional Testing
- **Approach**: [Describe how functional requirements will be tested]
- **Coverage**: [What functional areas will be covered]
- **Automation**: [Percentage to automate and rationale]

#### Non-Functional Testing

**Performance Testing**:
- Response time targets: [e.g., < 2 seconds for page load]
- Load testing approach: [e.g., 100 concurrent users]
- Performance metrics to track: [Response time, throughput, resource usage]

**Security Testing**:
- Authentication testing: [Login, session management]
- Authorization testing: [Role-based access control]
- Data validation: [Input sanitization, SQL injection prevention]
- Sensitive data protection: [PII handling, encryption]

**Accessibility Testing**:
- WCAG Compliance Level: [A / AA / AAA]
- Screen reader compatibility: [JAWS, NVDA, VoiceOver]
- Keyboard navigation: [Tab order, keyboard shortcuts]

**Compatibility Testing**:
- Browsers: [Chrome, Firefox, Safari, Edge - versions]
- Devices: [Desktop, Tablet, Mobile]
- Operating Systems: [Windows, macOS, iOS, Android]
- Screen sizes: [Responsive breakpoints]

#### Regression Testing
- **Scope**: [What existing functionality to verify]
- **Frequency**: [When to run - every commit, nightly, weekly]
- **Automation**: [Regression test suite details]

### 2.3 Test Automation Strategy

**Framework**: Serenity Cucumber BDD (Java)

**Tools**:
- **Build Tool**: Maven / Gradle
- **Test Framework**: JUnit 5 / TestNG
- **BDD Framework**: Cucumber
- **UI Automation**: Selenium WebDriver
- **API Automation**: RestAssured
- **Reporting**: Serenity Reports

**Automation Approach**:
- API tests: 100% automated
- UI tests: 80% automated (critical paths and happy flows)
- Data-driven tests: Cucumber Scenario Outlines with Examples tables
- Design Pattern: Page Object Model (UI) + API Client Pattern (API)

### 2.4 Entry and Exit Criteria

**Entry Criteria** (must be met before testing begins):
- [ ] Story analysis completed and reviewed
- [ ] Test environment available and stable
- [ ] Test data prepared and accessible
- [ ] Access to required systems granted
- [ ] Build deployed to test environment
- [ ] Test plan reviewed and approved

**Exit Criteria** (must be met before testing complete):
- [ ] All P0/P1 test cases executed
- [ ] 95% pass rate achieved for executed tests
- [ ] All critical defects resolved or deferred with approval
- [ ] Test report generated and reviewed
- [ ] Code coverage meets threshold (if applicable)
- [ ] Performance targets met
- [ ] Security requirements validated

---

## 3. Test Cases

### 3.1 Test Case Summary

| Test Case ID | Scenario | Priority | Type | Automation | Status |
|--------------|----------|----------|------|------------|--------|
| TC-001 | [Scenario name] | P0 | UI | Yes | Not Started |
| TC-002 | [Scenario name] | P1 | API | Yes | Not Started |
| TC-003 | [Scenario name] | P1 | Integration | Yes | Not Started |
| TC-004 | [Scenario name] | P2 | UI | No | Not Started |

**Priority Definitions**:
- **P0 (Critical)**: Blocker if fails, must pass before release
- **P1 (High)**: Important functionality, should pass before release
- **P2 (Medium)**: Nice to have, can be deferred if time constrained
- **P3 (Low)**: Optional, future enhancement

### 3.2 Test Case Mapping

#### Positive Flow Tests (Happy Path)

| Test Case | Description | Acceptance Criteria | Priority | Type |
|-----------|-------------|---------------------|----------|------|
| TC-001 | [Scenario] | AC-001 | P0 | UI |
| TC-002 | [Scenario] | AC-002 | P0 | API |
| TC-003 | [Scenario] | AC-003 | P1 | UI |

#### Negative Flow Tests (Error Handling)

| Test Case | Description | Error Condition | Expected Behavior | Priority | Type |
|-----------|-------------|----------------|-------------------|----------|------|
| TC-010 | [Scenario] | [Error to trigger] | [How system handles] | P1 | UI |
| TC-011 | [Scenario] | [Error to trigger] | [How system handles] | P1 | API |

#### Edge Case Tests (Boundary Conditions)

| Test Case | Description | Boundary Condition | Expected Behavior | Priority | Type |
|-----------|-------------|-------------------|-------------------|----------|------|
| TC-020 | [Scenario] | [Edge case] | [How system handles] | P1 | UI |
| TC-021 | [Scenario] | [Edge case] | [How system handles] | P2 | API |

#### Data Validation Tests

| Test Case | Description | Validation Rule | Invalid Inputs | Expected Message | Priority | Type |
|-----------|-------------|----------------|----------------|------------------|----------|------|
| TC-030 | [Scenario] | [Rule] | [Invalid values] | [Error message] | P1 | UI |
| TC-031 | [Scenario] | [Rule] | [Invalid values] | [Error message] | P1 | API |

---

## 4. Test Environment

### 4.1 Environment Configuration

| Environment | Purpose | URL/Access | Database | Status |
|-------------|---------|------------|----------|--------|
| Dev | Development testing | [URL] | [DB Connection] | Available |
| Staging | Pre-prod testing | [URL] | [DB Connection] | Available |
| Prod-Like | Performance testing | [URL] | [DB Connection] | Pending |

### 4.2 Test Data Requirements

| Data Type | Description | Volume | Source | Prepared |
|-----------|-------------|--------|--------|----------|
| User accounts | Test users with various roles | 10 | Test data service | No |
| [Entity] data | [Description] | [N] | [Source] | No |
| Transaction data | [Description] | [N] | [Source] | No |

**Test Data Management**:
- Data generation approach: [Faker library / manual creation / database seed]
- Data cleanup strategy: [After each test / after test suite]
- Data isolation: [Unique data per test run / shared test data pool]

### 4.3 Tools and Access

**Required Access**:
- [ ] JIRA access (for story/defect management)
- [ ] Test environment access (URLs and credentials)
- [ ] Database access (for data setup/verification)
- [ ] API access (endpoints and authentication)
- [ ] Version control (Git repository access)

**Tools**:
- Test Management: [JIRA Xray / TestRail / Zephyr]
- Test Automation Framework: Serenity Cucumber BDD
- API Testing: RestAssured
- UI Testing: Selenium WebDriver
- Performance Testing: [JMeter / Gatling] (if applicable)
- CI/CD: [Jenkins / GitHub Actions / GitLab CI]

---

## 5. Test Schedule

| Phase | Activities | Duration | Start Date | End Date | Owner |
|-------|------------|----------|------------|----------|-------|
| Test Planning | Create test plan, review with team | 0.5 days | [DATE] | [DATE] | [Name] |
| Test Design | Write Gherkin scenarios | 1 day | [DATE] | [DATE] | [Name] |
| Test Implementation | Implement test automation | 2 days | [DATE] | [DATE] | [Name] |
| Test Execution | Run tests, log defects | 1 day | [DATE] | [DATE] | [Name] |
| Defect Triage | Verify fixes, retest | 0.5 days | [DATE] | [DATE] | [Name] |
| Test Closure | Generate report, lessons learned | 0.5 days | [DATE] | [DATE] | [Name] |

**Total Estimated Duration**: [X] days

**Milestones**:
- Test plan approval: [DATE]
- Test automation complete: [DATE]
- Test execution complete: [DATE]
- Ready for release: [DATE]

---

## 6. Risks and Mitigation

| Risk ID | Risk Description | Impact | Probability | Mitigation Strategy | Owner | Status |
|---------|------------------|--------|-------------|---------------------|-------|--------|
| R-001 | Test environment unavailable | High | Medium | Reserve backup environment, implement retries | DevOps | Open |
| R-002 | Test data not available | High | Low | Create data generation scripts | QA | Open |
| R-003 | API not ready on time | High | Medium | Use API mocks for early testing | QA/Dev | Open |
| R-004 | Unclear requirements | Medium | Medium | Conduct clarification session with PO | QA/BA | Open |
| R-005 | Time constraints | Medium | High | Prioritize P0/P1 tests, defer P2/P3 | QA Lead | Open |

**Impact Levels**:
- **High**: Significant delay or major quality impact
- **Medium**: Moderate delay or quality impact
- **Low**: Minor delay or quality impact

**Probability Levels**:
- **High**: > 70% chance of occurring
- **Medium**: 30-70% chance of occurring
- **Low**: < 30% chance of occurring

---

## 7. Dependencies

### 7.1 Internal Dependencies
- [ ] Development team completes feature by [DATE]
- [ ] Test environment provisioned by [DATE]
- [ ] API documentation available by [DATE]
- [ ] UI mockups/prototypes available by [DATE]

### 7.2 External Dependencies
- [ ] Third-party service access granted
- [ ] Test accounts created in external system
- [ ] Mock services configured for external APIs
- [ ] SSL certificates for test environments

---

## 8. Roles and Responsibilities

| Role | Name | Responsibilities | Availability |
|------|------|------------------|--------------|
| QA Lead | [Name] | Test plan approval, resource allocation, stakeholder communication | Full-time |
| SDET/QA Engineer | [Name] | Test implementation, execution, defect logging, reporting | Full-time |
| Developer | [Name] | Unit tests, defect fixes, test environment support | As needed |
| Product Owner | [Name] | Acceptance criteria clarification, UAT, sign-off | As needed |
| DevOps Engineer | [Name] | Environment setup, CI/CD pipeline, deployment | As needed |

---

## 9. Defect Management

### 9.1 Defect Severity Definitions

| Severity | Definition | Example | Response Time |
|----------|------------|---------|---------------|
| Critical (P0) | System crash, data loss, security breach | Login not working, payment failure | Immediate |
| High (P1) | Major functionality broken, no workaround | Search returns no results | < 4 hours |
| Medium (P2) | Functionality impaired, workaround exists | Slow page load, minor UI issue | < 24 hours |
| Low (P3) | Minor issue, cosmetic | Typo, alignment issue | < 48 hours |

### 9.2 Defect Workflow

```
1. QA discovers defect during testing
2. QA logs defect in JIRA with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual results
   - Screenshots/logs/evidence
   - Severity and priority
3. Dev triages defect and assigns priority
4. Dev fixes defect and marks "Ready for Retest"
5. QA verifies fix in test environment
6. If fixed: QA closes defect
7. If not fixed: QA reopens defect with details
```

### 9.3 Defect Metrics
- Total defects found
- Defects by severity
- Defect resolution time
- Defect reopen rate
- Defects found by phase (dev, test, UAT, production)

---

## 10. Test Deliverables

- [ ] **Test Plan Document** (this document)
- [ ] **Gherkin BDD Scenarios** (feature files)
- [ ] **Test Automation Code** (Java + Serenity Cucumber)
- [ ] **Test Execution Report** (Serenity HTML report)
- [ ] **Defect Report** (JIRA export or summary)
- [ ] **Test Coverage Report** (Requirements coverage)
- [ ] **Test Metrics Dashboard** (Pass rate, execution time, trends)
- [ ] **Test Closure Report** (Summary, lessons learned, recommendations)

---

## 11. Assumptions

1. [Assumption about test environment availability]
2. [Assumption about test data availability]
3. [Assumption about feature functionality]
4. [Assumption about timelines]
5. [Assumption about resources]

**Note**: If any assumption proves invalid, this test plan may need to be revised.

---

## 12. Constraints

1. **Time**: Testing must complete by [DATE] for release on [DATE]
2. **Resources**: Only [N] QA engineers available
3. **Environment**: Only [N] test environments available, shared with other teams
4. **Budget**: No budget for additional tools or licenses
5. **Access**: Limited access to production data, must use synthetic test data

---

## 13. Open Items / Questions

- [ ] **[NEEDS CLARIFICATION: Question 1]**
- [ ] **[NEEDS CLARIFICATION: Question 2]**
- [ ] **[Action Item: Task 1]** - Owner: [Name], Due: [Date]
- [ ] **[Action Item: Task 2]** - Owner: [Name], Due: [Date]

---

## 14. Approval

This test plan requires approval from the following stakeholders before test execution begins:

| Name | Role | Signature | Date |
|------|------|-----------|------|
| [Name] | QA Lead | | |
| [Name] | Engineering Manager | | |
| [Name] | Product Owner | | |

---

## 15. Appendices

### Appendix A: Test Case Details

[Link to detailed test case documentation if needed]

### Appendix B: Test Data Specifications

[Detailed test data requirements and generation approach]

### Appendix C: Environment Setup Guide

[Step-by-step guide for setting up test environment]

---

## Execution Status
*Updated by workflow automation*

- [ ] Test plan created
- [ ] Test plan reviewed by team
- [ ] Test plan approved
- [ ] Test environment verified
- [ ] Test data prepared
- [ ] Ready for `/gherkin-scenarios` command

---

**Next Command**: `/gherkin-scenarios`

**Document Version**: 1.0
**Last Updated**: [DATE]
**Template Source**: `.specify/templates/test-plan-template.md`
