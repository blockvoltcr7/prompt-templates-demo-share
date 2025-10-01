# QA/SDET Test Automation Kit

## Overview
This kit is specifically designed for QA/SDET professionals working with test automation. Unlike developer-focused spec kits, this kit addresses the unique workflow and requirements of test automation engineers who follow a structured approach from Jira story analysis to test automation implementation.

## Kit Structure

```
qa-sdet-automation-kit/
├── .specify/
│   ├── memory/
│   │   └── constitution.md          # QA/SDET principles and standards
│   ├── prompts/
│   │   ├── jira-story-analysis-prompt.md
│   │   ├── gherkin-bdd-scenario-prompt.md
│   │   ├── test-automation-strategy-prompt.md
│   │   └── serenity-cucumber-implementation-prompt.md
│   ├── templates/
│   │   ├── test-plan-template.md
│   │   ├── test-automation-strategy-template.md
│   │   ├── gherkin-feature-template.md
│   │   └── test-case-documentation-template.md
│   └── scripts/
│       └── powershell/
│           ├── New-QAAutomationProject.ps1
│           └── Generate-TestReport.ps1
└── README.md
```

## QA/SDET Workflow Supported

### 1. Jira Story Analysis
- **Input**: Jira story/task with acceptance criteria
- **Process**: Analyze requirements and create comprehensive test plan
- **Output**: Structured test plan document
- **Prompt**: `jira-story-analysis-prompt.md`
- **Template**: `test-plan-template.md`

### 2. Test Planning
- **Input**: Business requirements and acceptance criteria
- **Process**: Create detailed test strategy and approach
- **Output**: Test automation strategy document
- **Template**: `test-automation-strategy-template.md`

### 3. Gherkin BDD Scenario Creation
- **Input**: Test plan and acceptance criteria
- **Process**: Convert requirements into Gherkin BDD scenarios
- **Output**: Feature files with comprehensive test scenarios
- **Prompt**: `gherkin-bdd-scenario-prompt.md`
- **Template**: `gherkin-feature-template.md`

### 4. Test Automation Implementation
- **Input**: Gherkin scenarios and application details
- **Process**: Implement Serenity Cucumber BDD automation code
- **Output**: Java classes with step definitions, page objects, and API services
- **Prompt**: `serenity-cucumber-implementation-prompt.md`

### 5. Test Execution & Reporting
- **Input**: Automated test suite
- **Process**: Execute tests and generate comprehensive reports
- **Output**: Test execution reports and metrics
- **Script**: `Generate-TestReport.ps1`

## Technology Stack Focus

### Primary Framework: Serenity BDD + Cucumber
- **Language**: Java
- **BDD Framework**: Cucumber with Gherkin
- **Reporting**: Serenity Reports
- **Build Tool**: Maven/Gradle
- **Web Automation**: Selenium WebDriver
- **API Testing**: REST Assured
- **Test Runner**: TestNG/JUnit

### Supported Testing Types
- **UI Automation**: Web application testing
- **API Testing**: REST API validation
- **Database Testing**: Data validation and integrity
- **Integration Testing**: Cross-system validation
- **Regression Testing**: Automated regression suites
- **Smoke Testing**: Critical path validation

## Quick Start Guide

### 1. Create New Test Automation Project
```powershell
# Run the project generator script
.\scripts\powershell\New-QAAutomationProject.ps1 -ProjectName "MyApp-Tests" -BasePackage "com.company.automation"
```

### 2. Analyze Jira Story
```
Use: prompts/jira-story-analysis-prompt.md
Input: Jira story details
Output: Comprehensive test plan
```

### 3. Create Test Scenarios
```
Use: prompts/gherkin-bdd-scenario-prompt.md
Input: Test plan summary
Output: Gherkin feature files
```

### 4. Implement Automation
```
Use: prompts/serenity-cucumber-implementation-prompt.md
Input: Gherkin scenarios
Output: Java automation code
```

### 5. Execute and Report
```powershell
# Build and run tests
mvn clean test serenity:aggregate

# Generate comprehensive report
.\scripts\powershell\Generate-TestReport.ps1 -OpenReport
```

## Key Differentiators from Developer Kits

### 1. **Test-First Approach**
- Emphasizes test planning before automation development
- Requires stakeholder approval before coding
- Focuses on business-readable scenarios

### 2. **BDD-Driven Workflow**
- All scenarios written in Gherkin format
- Living documentation approach
- Business stakeholder collaboration

### 3. **Comprehensive Test Strategy**
- Test pyramid considerations
- Risk-based testing approach
- ROI analysis for automation candidates

### 4. **Quality Gates & Metrics**
- Test coverage tracking
- Pass rate monitoring
- Defect detection metrics
- Maintenance effort tracking

### 5. **Traceability & Documentation**
- Jira story linkage
- Acceptance criteria mapping
- Test result tracking
- Comprehensive reporting

## Usage Examples

### Example 1: Login Feature Testing
```gherkin
@login @critical @smoke
Feature: User Authentication
  As a registered user
  I want to login to the application
  So that I can access my account features

  Scenario: Successful login with valid credentials
    Given I am on the login page
    When I enter valid username and password
    Then I should be redirected to dashboard
```

### Example 2: API Testing
```java
@Component
public class UserApiSteps {
    
    @Steps
    private UserApiService userApiService;
    
    @When("I create a new user via API")
    public void createUserViaApi() {
        userApiService.createUser(userData);
    }
    
    @Then("the user should be created successfully")
    public void verifyUserCreation() {
        assertThat(response.getStatusCode()).isEqualTo(201);
    }
}
```

## Best Practices

### 1. **Test Planning**
- Always start with comprehensive test plan
- Get stakeholder approval before automation
- Map test scenarios to acceptance criteria
- Consider both positive and negative scenarios

### 2. **Gherkin Writing**
- Use business-readable language
- Avoid technical implementation details
- Keep scenarios focused and atomic
- Use scenario outlines for data-driven tests

### 3. **Code Quality**
- Follow Page Object Model patterns
- Implement proper error handling
- Use meaningful variable and method names
- Ensure thread-safe implementation

### 4. **Maintenance**
- Regular test review and updates
- Monitor test stability and performance
- Implement self-healing capabilities where possible
- Maintain comprehensive documentation

## Framework Architecture

```
Test Automation Framework
├── Test Planning Layer
│   ├── Jira Integration
│   ├── Test Strategy
│   └── Risk Assessment
├── Test Design Layer
│   ├── Gherkin Features
│   ├── Test Scenarios
│   └── Test Data Management
├── Test Implementation Layer
│   ├── Step Definitions
│   ├── Page Objects
│   ├── API Services
│   └── Database Utilities
├── Test Execution Layer
│   ├── Test Runners
│   ├── Parallel Execution
│   ├── CI/CD Integration
│   └── Environment Management
└── Reporting Layer
    ├── Serenity Reports
    ├── Custom Dashboards
    ├── Metrics & Analytics
    └── Stakeholder Communication
```

## Integration Points

### 1. **Jira Integration**
- Story/task import and analysis
- Test case linking and traceability
- Defect tracking and management

### 2. **CI/CD Pipeline**
- Automated test execution
- Build quality gates
- Test result reporting
- Failure notifications

### 3. **Test Management Tools**
- Test case management
- Test execution tracking
- Results archiving

### 4. **Monitoring & Analytics**
- Test metrics dashboards
- Performance monitoring
- Quality trends analysis

## Support and Maintenance

### Framework Updates
- Regular dependency updates
- New feature implementations
- Performance optimizations
- Bug fixes and improvements

### Training Materials
- Framework documentation
- Best practices guides
- Video tutorials
- Code examples

### Community Support
- Knowledge sharing sessions
- Code review guidelines
- Troubleshooting guides
- FAQ documentation

---

**Version**: 1.0.0  
**Created**: October 2025  
**Maintained By**: QA/SDET Team  
**License**: Internal Use Only