# Review Task - QA Assessment
# Purpose: Comprehensive quality assessment of user stories and tasks for testability and automation potential

## Task Overview
This task provides a systematic approach to reviewing user stories, technical tasks, and requirements from a QA perspective, focusing on testability, risk assessment, and test automation opportunities.

## Prerequisites
- Access to the story/task details
- Understanding of the application architecture
- Knowledge of testing frameworks (Serenity BDD, Cucumber)
- Access to existing test suites

## Input Requirements
- Story/Task ID and description
- Acceptance criteria
- Technical specifications (if available)
- Related dependencies
- Business context and priority

## Review Process

### Step 1: Story Analysis
**Objective:** Understand the requirement and its business context

**Actions:**
1. Read the story/task description thoroughly
2. Review acceptance criteria for clarity and completeness
3. Identify business value and user impact
4. Note any ambiguities or missing information
5. Document initial understanding

**Template Reference:** Use sections from `jira-ticket-template.md` for structure

**Output:**
- Story understanding summary
- Business value assessment
- Clarity issues identified

### Step 2: Testability Assessment
**Objective:** Evaluate how testable the story is in its current form

**Evaluation Criteria:**
- **Controllability:** Can we control inputs and preconditions?
- **Observability:** Can we observe outputs and side effects?
- **Debuggability:** Can we isolate and debug issues?
- **Test Data:** Is test data available or creatable?
- **Environment:** Are test environments available?

**Assessment Questions:**
1. Are acceptance criteria written in testable format (Given-When-Then)?
2. Are success and failure scenarios clearly defined?
3. Are all dependencies identified and controllable?
4. Can the feature be tested in isolation?
5. Are performance/non-functional requirements specified?

**Output:**
- Testability score (High/Medium/Low)
- Specific testability concerns
- Recommendations for improvement

### Step 3: Risk Analysis
**Objective:** Identify and assess potential risks

**Risk Categories:**
- **Technical Risk:** Complexity, dependencies, new technology
- **Business Risk:** Impact of defects, user experience issues
- **Integration Risk:** Cross-system dependencies
- **Data Risk:** Data quality, migration, privacy concerns
- **Performance Risk:** Load, scalability, response time issues

**Risk Assessment Matrix:**
| Risk Area | Probability | Impact | Risk Level | Mitigation Strategy |
|-----------|-------------|---------|------------|-------------------|
| [Risk 1] | [H/M/L] | [H/M/L] | [Critical/High/Medium/Low] | [Strategy] |
| [Risk 2] | [H/M/L] | [H/M/L] | [Critical/High/Medium/Low] | [Strategy] |

**Output:**
- Risk assessment summary
- High-priority risks identified
- Suggested mitigation strategies

### Step 4: Test Strategy Planning
**Objective:** Define comprehensive test approach

**Test Level Planning:**
- **Unit Tests:** What components need unit testing?
- **Integration Tests:** What integrations need testing?
- **API Tests:** What APIs need validation?
- **UI Tests:** What user workflows need testing?
- **E2E Tests:** What business scenarios need end-to-end validation?

**Test Types Assessment:**
- [ ] Functional Testing
- [ ] Performance Testing
- [ ] Security Testing
- [ ] Accessibility Testing
- [ ] Compatibility Testing
- [ ] Usability Testing
- [ ] Data Quality Testing

**BDD Scenario Planning:**
```gherkin
Feature: [Feature Name]
  As a [user type]
  I want [capability]
  So that [business value]

Scenario: [Happy Path Scenario]
  Given [precondition]
  When [action]
  Then [expected result]

Scenario: [Edge Case Scenario]
  Given [precondition]
  When [action]
  Then [expected result]

Scenario: [Error Scenario]
  Given [precondition]
  When [action]
  Then [expected error handling]
```

**Output:**
- Test strategy summary
- BDD scenarios outline
- Test types recommended

### Step 5: Automation Assessment
**Objective:** Evaluate automation potential and ROI

**Automation Criteria:**
- **Repeatability:** Will this test be run frequently?
- **Stability:** Is the feature likely to remain stable?
- **Complexity:** Is automation cost-effective vs. manual testing?
- **Risk:** Does automation reduce critical risks?
- **Maintenance:** Can automated tests be easily maintained?

**Automation Recommendations:**
- **High Priority:** [Tests that should definitely be automated]
- **Medium Priority:** [Tests that could be automated]
- **Manual Only:** [Tests better suited for manual testing]

**Framework Integration:**
- Serenity BDD + Cucumber implementation approach
- Page Object Model design considerations
- Test data management strategy
- CI/CD integration points

**Output:**
- Automation recommendation (High/Medium/Low priority)
- Implementation approach
- Estimated effort for automation

### Step 6: Quality Advisory
**Objective:** Provide actionable recommendations to improve quality

**Story Enhancement Recommendations:**
- Acceptance criteria improvements
- Additional scenarios to consider
- Non-functional requirements to define
- Dependencies to clarify

**Testing Recommendations:**
- Test approach for this story
- Test environment requirements
- Test data preparation needs
- Performance testing considerations

**Process Recommendations:**
- Review process improvements
- Definition of Done enhancements
- Quality gate suggestions
- Collaboration improvements

**Template Reference:** Use `documentation-template.md` for detailed recommendations

**Output:**
- Quality improvement recommendations
- Process enhancement suggestions
- Next steps for the development team

## Deliverables

### Review Report
Create a comprehensive review report including:
1. **Executive Summary:** Key findings and recommendations
2. **Story Assessment:** Understanding and clarity evaluation
3. **Risk Analysis:** Identified risks and mitigation strategies
4. **Test Strategy:** Comprehensive testing approach
5. **Automation Plan:** Automation recommendations and approach
6. **Quality Advisory:** Actionable improvement recommendations

### Follow-up Actions
- Schedule review meeting with development team
- Update story with additional acceptance criteria
- Create test automation tasks
- Plan test environment setup
- Document test data requirements

## Quality Gates
- [ ] Story is clearly understood
- [ ] All major risks are identified
- [ ] Test strategy is comprehensive
- [ ] Automation approach is defined
- [ ] Quality recommendations are actionable
- [ ] Next steps are clear

## Success Metrics
- Story testability score improved to High
- All critical risks have mitigation strategies
- Test automation ROI is positive
- Development team has clear quality guidance
- Quality gates are integrated into Definition of Done

## Tool Integration
- Use IDE tools: `problems`, `usages`, `search` for code analysis
- Use `findTestFiles` to analyze existing test coverage
- Use `testFailure` to understand current quality issues
- Use `runTests` to validate current test suite health