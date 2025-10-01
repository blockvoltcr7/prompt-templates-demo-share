# QA Engineer Onboarding Guide
## Spec-Driven Test Automation with AI Agent Collaboration

**Version**: 1.0.0
**Last Updated**: 2025-01-XX
**Target Audience**: QA Engineers, SDETs, Test Automation Engineers

---

## 📖 Table of Contents

1. [Introduction](#introduction)
2. [What is the QA SDET Automation Kit?](#what-is-the-qa-sdet-automation-kit)
3. [Prerequisites](#prerequisites)
4. [Setup Instructions](#setup-instructions)
5. [Understanding the Workflow](#understanding-the-workflow)
6. [Complete Walkthrough with Example](#complete-walkthrough-with-example)
7. [Command Reference](#command-reference)
8. [Best Practices](#best-practices)
9. [Troubleshooting](#troubleshooting)
10. [FAQ](#faq)
11. [Tips for Effective AI Agent Collaboration](#tips-for-effective-ai-agent-collaboration)

---

## Introduction

Welcome to the QA SDET Automation Kit! This onboarding guide will help you understand how to leverage **AI-assisted test automation** to transform JIRA stories into comprehensive, maintainable test suites.

### What You'll Learn
- How to collaborate with AI agents to design and implement tests
- How to create test plans from JIRA stories
- How to write Gherkin BDD scenarios
- How to implement test automation using Serenity Cucumber framework
- How to follow best practices and quality standards

### Time to Proficiency
- **Basic Usage**: 30-60 minutes
- **Intermediate**: 2-3 hours of practice
- **Advanced**: 1-2 weeks of regular use

---

## What is the QA SDET Automation Kit?

The QA SDET Automation Kit is a **specification-driven test automation framework** that uses AI agents to guide you through the entire test automation lifecycle.

### Key Concept: Spec-Driven Test Automation

Unlike traditional development where you write code first, this kit follows a **specification-first approach**:

```
Traditional Approach:
JIRA Story → Write Tests → Hope for Good Coverage

Spec-Driven Approach:
JIRA Story → Analyze Requirements → Plan Tests →
Write Gherkin Scenarios → Define Strategy → Generate Code →
Execute Tests with Comprehensive Coverage
```

### Why This Matters

1. **Structured Thinking**: Forces systematic test planning before implementation
2. **Comprehensive Coverage**: Ensures all scenarios (positive, negative, edge cases) are identified
3. **AI Collaboration**: AI agent helps design tests following best practices
4. **Living Documentation**: Gherkin scenarios serve as executable documentation
5. **Consistency**: Everyone follows the same workflow and standards

---

## Prerequisites

### Required Software

#### 1. AI Agent Access
You need access to one of these AI coding agents:
- **Claude Code** (Recommended)
- GitHub Copilot
- Cursor IDE
- Windsurf
- Or any agent that supports custom slash commands

#### 2. Development Tools
```bash
# Java Development Kit (JDK)
java --version  # Should be Java 11 or higher

# Build Tool (choose one)
mvn --version   # Maven 3.6+
# OR
gradle --version  # Gradle 7.0+

# Git
git --version

# PowerShell (for scripts)
pwsh --version  # PowerShell Core 7.0+
```

#### 3. IDE (Integrated Development Environment)
- IntelliJ IDEA (Community or Ultimate) - Recommended
- Eclipse
- Visual Studio Code (with Java extensions)

#### 4. Browser (for UI tests)
- Chrome (latest)
- Firefox (latest)
- WebDriver Manager will auto-download drivers

### Optional Tools
- **JIRA Access**: For fetching story details
- **Postman/Insomnia**: For manual API testing
- **Docker**: If your test environment uses containers

### Knowledge Prerequisites

**Required**:
- Basic understanding of software testing concepts
- Familiarity with JIRA or similar project management tools
- Basic Git knowledge (clone, commit, push, pull)
- Understanding of REST APIs (for API testing)

**Nice to Have**:
- Java programming basics
- Selenium WebDriver experience
- Cucumber/BDD experience
- Maven/Gradle build tools

**Don't Worry If You Don't Know Java Well!**
The AI agent will generate most of the code for you. You'll learn by reviewing and modifying the generated code.

---

## Setup Instructions

### Step 1: Clone the Repository

```bash
# Clone the project repository
git clone <repository-url>
cd <repository-name>

# Verify the QA SDET kit exists
ls spec-kit-copilot/qa-sdet-automation-kit/
```

You should see:
```
README.md
.github/prompts/
.specify/
```

### Step 2: Configure Your AI Agent

#### For Claude Code:

1. **Locate the prompts directory**:
   ```
   spec-kit-copilot/qa-sdet-automation-kit/.github/prompts/
   ```

2. **Ensure your AI agent can access these prompts**:
   - Claude Code automatically detects `.github/prompts/` directory
   - Prompts become available as slash commands (e.g., `/analyze-story`)

3. **Verify commands are available**:
   In your AI agent, type `/` and look for:
   - `/analyze-story`
   - `/clarify-story`
   - `/test-plan`
   - `/gherkin-scenarios`
   - `/test-strategy`
   - `/implement-tests`

#### For Other AI Agents:

Refer to your agent's documentation for:
- How to configure custom slash commands
- How to load prompt files
- How to set working directory

### Step 3: Verify PowerShell Scripts

```bash
# Navigate to scripts directory
cd spec-kit-copilot/qa-sdet-automation-kit/.specify/scripts/powershell/

# Make scripts executable (macOS/Linux)
chmod +x *.ps1

# Test script execution
pwsh ./common.ps1
```

If you encounter permission issues, consult your system administrator.

### Step 4: Set Up Test Automation Framework (Optional)

If you already have a test automation project:

1. **Verify project structure**:
   ```
   your-test-project/
   ├── src/test/java/
   ├── src/test/resources/
   ├── pom.xml (or build.gradle)
   └── serenity.conf
   ```

2. **Verify dependencies** (Maven example):
   ```xml
   <dependencies>
       <!-- Serenity BDD -->
       <dependency>
           <groupId>net.serenity-bdd</groupId>
           <artifactId>serenity-cucumber</artifactId>
           <version>3.x.x</version>
       </dependency>

       <!-- Cucumber -->
       <dependency>
           <groupId>io.cucumber</groupId>
           <artifactId>cucumber-java</artifactId>
           <version>7.x.x</version>
       </dependency>

       <!-- RestAssured (for API tests) -->
       <dependency>
           <groupId>io.rest-assured</groupId>
           <artifactId>rest-assured</artifactId>
           <version>5.x.x</version>
       </dependency>
   </dependencies>
   ```

If you don't have a test project yet, the AI agent will help you set one up.

### Step 5: Read the Constitution

```bash
# Review the QA testing principles
cat spec-kit-copilot/qa-sdet-automation-kit/.specify/memory/constitution.md
```

**Important**: The constitution defines the non-negotiable principles you must follow:
- Test-First Mindset
- BDD as Communication Protocol
- Test Independence
- Page Object Model (UI tests)
- API Client Pattern (API tests)

Take 10-15 minutes to read and understand these principles.

---

## Understanding the Workflow

### The 6-Step Test Automation Workflow

```
┌─────────────────────────────────────────────────────────────┐
│  1. ANALYZE STORY                                           │
│  Input: JIRA story (PROJ-123)                               │
│  Output: story-analysis.md                                  │
│  Purpose: Extract testable requirements, identify scenarios │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│  2. CLARIFY STORY (Optional but Recommended)                │
│  Input: story-analysis.md                                   │
│  Output: Enhanced story-analysis.md                         │
│  Purpose: Resolve ambiguities with targeted questions       │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│  3. CREATE TEST PLAN                                        │
│  Input: story-analysis.md                                   │
│  Output: test-plan.md                                       │
│  Purpose: Define test strategy, scope, cases, schedule      │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│  4. GENERATE GHERKIN SCENARIOS                              │
│  Input: test-plan.md                                        │
│  Output: gherkin/*.feature files                            │
│  Purpose: Convert test cases to Given/When/Then format      │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│  5. DEFINE TEST STRATEGY                                    │
│  Input: gherkin/*.feature files                             │
│  Output: test-automation-strategy.md                        │
│  Purpose: Define framework architecture and patterns        │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│  6. IMPLEMENT TESTS                                         │
│  Input: test-automation-strategy.md + gherkin files         │
│  Output: Java test automation code                          │
│  Purpose: Generate step definitions, page objects, clients  │
└─────────────────────────────────────────────────────────────┘
                          ↓
                  Execute Tests!
```

### What Gets Generated

After completing the workflow, you'll have:

```
specs/PROJ-123/
├── story-analysis.md              # Testable requirements
├── test-plan.md                   # Comprehensive test plan
├── test-automation-strategy.md    # Technical strategy
├── implementation-summary.md      # What was implemented
├── gherkin/                       # BDD scenarios
│   ├── user_login.feature
│   └── user_profile.feature
└── step-definitions-guide.md      # Step definitions needed

your-test-project/src/test/java/
├── stepdefinitions/
│   ├── UserLoginSteps.java
│   └── UserProfileSteps.java
├── pages/
│   ├── LoginPage.java
│   └── UserProfilePage.java
├── api/
│   └── UserApiClient.java
├── models/
│   └── User.java
├── utils/
│   ├── TestDataGenerator.java
│   └── ConfigManager.java
└── runners/
    ├── SmokeTestRunner.java
    └── ApiTestRunner.java
```

---

## Complete Walkthrough with Example

Let's walk through the entire workflow with a real example.

### Example JIRA Story

```
Story: PROJ-456
Title: Password Reset Functionality

Description:
As a user, I want to reset my password via email so that I can
regain access to my account if I forget my password.

Acceptance Criteria:
1. User can request password reset from login page
2. System sends email with reset link to registered email
3. Reset link expires after 24 hours
4. User can set new password using valid reset link
5. Old password no longer works after reset
6. User receives confirmation email after successful reset
```

### Step 1: Analyze the Story

**Command**:
```
/analyze-story PROJ-456: Password Reset Functionality
```

**What Happens**:

1. AI agent runs the script:
   ```bash
   .specify/scripts/powershell/create-test-feature.ps1 -Json "PROJ-456: Password Reset Functionality"
   ```

2. Creates directory structure:
   ```
   specs/proj-456/
   ├── story-analysis.md
   └── gherkin/
   ```

3. Generates `story-analysis.md` with:
   - Story summary
   - Acceptance criteria breakdown
   - **Positive flow scenarios** (successful reset)
   - **Negative flow scenarios** (invalid link, expired link)
   - **Edge cases** (multiple reset requests, link already used)
   - **Data validation scenarios** (password complexity rules)
   - Non-functional requirements (email delivery time)
   - Test data requirements (test users, test emails)
   - Integration dependencies (email service)

**Expected Output**:
```
✅ Story analysis completed
📄 File created: specs/proj-456/story-analysis.md
📊 Scenarios identified:
   - Positive flows: 3
   - Negative flows: 5
   - Edge cases: 3
   - Validation scenarios: 2
🎯 Total test scenarios: 13

⚠️  Ambiguities found:
   - [NEEDS CLARIFICATION: Password complexity rules not specified]
   - [NEEDS CLARIFICATION: Email delivery SLA not defined]

Next step: Run /clarify-story to resolve ambiguities
```

**Review the Output**:
```bash
cat specs/proj-456/story-analysis.md
```

Take 5-10 minutes to review:
- Are all scenarios captured?
- Are there any missing test cases?
- Do the test data requirements make sense?

### Step 2: Clarify Ambiguities

**Command**:
```
/clarify-story
```

**What Happens**:

The AI agent asks targeted questions to resolve ambiguities:

**Question 1/5**: What are the password complexity requirements?

| Option | Description |
|--------|-------------|
| A | Minimum 8 characters, 1 uppercase, 1 lowercase, 1 number |
| B | Minimum 10 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character |
| C | Minimum 12 characters with at least 3 character types |
| D | Custom (specify) |

**Your Answer**: B

**Question 2/5**: What is the expected email delivery time?

| Option | Description |
|--------|-------------|
| A | < 1 minute |
| B | < 5 minutes |
| C | < 15 minutes |
| D | No specific requirement |

**Your Answer**: B

**Question 3/5**: What happens if user requests multiple password reset emails?

| Option | Description |
|--------|-------------|
| A | Only the latest link works, previous links invalidated |
| B | All links work until used or expired |
| C | System blocks additional requests for X minutes |
| D | Not specified (needs product owner input) |

**Your Answer**: A

*AI agent stops asking questions (resolved critical ambiguities)*

**Expected Output**:
```
✅ Clarifications completed
📝 Questions asked: 3 of 5
📄 File updated: specs/proj-456/story-analysis.md

📋 Clarifications recorded:
   - Password complexity: Min 10 chars, upper/lower/number/special
   - Email delivery SLA: < 5 minutes
   - Multiple reset requests: Latest link only, previous invalidated

📊 Updated sections:
   - Acceptance Criteria (added password rules)
   - Non-Functional Requirements (added SLA)
   - Test Scenarios (updated with clarified behavior)

Next step: Run /test-plan
```

### Step 3: Create Test Plan

**Command**:
```
/test-plan
```

**What Happens**:

AI agent generates a comprehensive test plan document including:
- Test scope (in-scope / out-of-scope)
- Test strategy (UI tests, API tests, integration tests)
- Test cases mapped to acceptance criteria
- Test environment requirements
- Test data requirements
- Test schedule
- Risks and mitigation
- Entry/exit criteria

**Expected Output**:
```
✅ Test plan created
📄 File created: specs/proj-456/test-plan.md

📊 Test Plan Summary:
   - Total test cases: 15
   - Priority breakdown:
     * P0 (Critical): 5 test cases
     * P1 (High): 7 test cases
     * P2 (Medium): 3 test cases
   - Test types:
     * UI tests: 8 test cases
     * API tests: 5 test cases
     * Integration tests: 2 test cases

⏱️  Estimated effort: 3 days
   - Test design: 0.5 days
   - Test implementation: 1.5 days
   - Test execution: 0.5 days
   - Defect triage: 0.5 days

Next step: Run /gherkin-scenarios
```

**Review the Test Plan**:
```bash
cat specs/proj-456/test-plan.md
```

Check:
- Is test scope appropriate?
- Are priorities correct?
- Is the schedule realistic?
- Are all risks identified?

### Step 4: Generate Gherkin Scenarios

**Command**:
```
/gherkin-scenarios
```

**What Happens**:

AI agent converts test cases into Gherkin BDD scenarios following Given/When/Then format.

**Expected Output**:
```
✅ Gherkin scenarios generated
📁 Directory created: specs/proj-456/gherkin/

📄 Feature files created:
   - password_reset_request.feature (5 scenarios)
   - password_reset_execution.feature (6 scenarios)
   - password_reset_api.feature (4 scenarios)

📊 Scenario Breakdown:
   - Total scenarios: 15
   - By tag:
     * @smoke: 3 scenarios
     * @regression: 12 scenarios
     * @P0: 5 scenarios
     * @ui: 8 scenarios
     * @api: 4 scenarios
     * @integration: 2 scenarios

📋 Step definitions guide created:
   - specs/proj-456/step-definitions-guide.md
   - Required steps: 32
   - Page objects needed: 3
   - API clients needed: 1

Next step: Run /test-strategy
```

**Review Generated Gherkin**:
```bash
cat specs/proj-456/gherkin/password_reset_request.feature
```

Example output:
```gherkin
@PROJ-456 @password-reset @smoke @P0 @ui
Feature: Password Reset Request
  As a user
  I want to request a password reset via email
  So that I can regain access to my account

  Background:
    Given I am on the login page

  @positive
  Scenario: Successfully request password reset with registered email
    Given a user exists with email "user@test.com"
    When I click the "Forgot Password" link
    And I enter "user@test.com" in the email field
    And I click the "Send Reset Link" button
    Then I should see "Password reset email sent successfully"
    And an email should be sent to "user@test.com"
    And the email should contain a valid reset link

  @negative
  Scenario: Request password reset with unregistered email
    Given no user exists with email "nonexistent@test.com"
    When I click the "Forgot Password" link
    And I enter "nonexistent@test.com" in the email field
    And I click the "Send Reset Link" button
    Then I should see "If this email is registered, you will receive a reset link"
    And no email should be sent
```

### Step 5: Define Test Automation Strategy

**Command**:
```
/test-strategy
```

**What Happens**:

AI agent creates a comprehensive test automation strategy document defining:
- Technology stack (Java 11, Serenity Cucumber, Maven)
- Framework architecture (layers, packages)
- Design patterns (Page Object Model for UI, API Client Pattern for APIs)
- Project structure
- Coding standards
- CI/CD integration
- Reporting approach

**Expected Output**:
```
✅ Test automation strategy created
📄 File created: specs/proj-456/test-automation-strategy.md

🏗️  Framework Architecture:
   - Language: Java 11
   - Build Tool: Maven
   - BDD Framework: Cucumber 7.x
   - Automation Framework: Serenity BDD 3.x
   - UI Automation: Selenium WebDriver 4.x
   - API Automation: RestAssured 5.x

📐 Design Patterns:
   - Page Object Model (for UI tests)
   - API Client Pattern (for API tests)
   - Test Data Builder Pattern

📦 Project Structure:
   src/test/java/
   ├── stepdefinitions/
   ├── pages/
   ├── api/
   ├── models/
   ├── utils/
   ├── hooks/
   └── runners/

Next step: Run /implement-tests
```

**Review the Strategy**:
```bash
cat specs/proj-456/test-automation-strategy.md
```

Ensure:
- Technology choices match your project
- Design patterns are appropriate
- Project structure aligns with your existing codebase

### Step 6: Implement Test Automation Code

**Command**:
```
/implement-tests
```

**What Happens**:

AI agent generates all the test automation code:

1. **Step Definitions** (glue between Gherkin and code)
2. **Page Objects** (for UI interactions)
3. **API Clients** (for API testing)
4. **Model Classes** (POJOs/DTOs)
5. **Utility Classes** (test data generators, config managers)
6. **Test Runners** (Cucumber test executors)
7. **Configuration** (Serenity properties)

**Expected Output**:
```
✅ Test automation code generated
📊 Implementation Summary:

📄 Files Created:

Step Definitions:
   ✓ stepdefinitions/ui/PasswordResetSteps.java (12 step definitions)
   ✓ stepdefinitions/api/PasswordResetApiSteps.java (8 step definitions)

Page Objects:
   ✓ pages/LoginPage.java
   ✓ pages/ForgotPasswordPage.java
   ✓ pages/ResetPasswordPage.java
   ✓ pages/BasePage.java

API Clients:
   ✓ api/PasswordResetApiClient.java
   ✓ api/BaseApiClient.java

Models:
   ✓ models/User.java
   ✓ models/PasswordResetRequest.java
   ✓ models/PasswordResetToken.java

Utilities:
   ✓ utils/TestDataGenerator.java
   ✓ utils/ConfigManager.java
   ✓ utils/EmailHelper.java

Test Runners:
   ✓ runners/SmokeTestRunner.java
   ✓ runners/PasswordResetTestRunner.java
   ✓ runners/ApiTestRunner.java

Configuration:
   ✓ serenity.conf
   ✓ application.properties

📈 Code Statistics:
   - Total files created: 18
   - Total step definitions: 20
   - Page objects: 4
   - API clients: 2
   - Lines of code generated: ~1,200

Next steps:
1. Compile code: mvn clean compile
2. Run tests: mvn clean verify
3. View report: open target/site/serenity/index.html
```

**Review Generated Code**:

Example Page Object:
```java
// pages/ForgotPasswordPage.java
public class ForgotPasswordPage extends PageObject {

    @FindBy(id = "email")
    private WebElementFacade emailField;

    @FindBy(css = "button[type='submit']")
    private WebElementFacade sendResetLinkButton;

    @FindBy(css = ".success-message")
    private WebElementFacade successMessage;

    public void enterEmail(String email) {
        emailField.clear();
        emailField.type(email);
    }

    public void clickSendResetLink() {
        sendResetLinkButton.click();
    }

    public String getSuccessMessage() {
        return successMessage.waitUntilVisible().getText();
    }
}
```

Example Step Definition:
```java
// stepdefinitions/ui/PasswordResetSteps.java
public class PasswordResetSteps {

    @Steps
    private LoginPage loginPage;

    @Steps
    private ForgotPasswordPage forgotPasswordPage;

    @When("I click the {string} link")
    public void iClickTheLink(String linkText) {
        if (linkText.equals("Forgot Password")) {
            loginPage.clickForgotPasswordLink();
        }
    }

    @When("I enter {string} in the email field")
    public void iEnterInTheEmailField(String email) {
        forgotPasswordPage.enterEmail(email);
    }

    @When("I click the {string} button")
    public void iClickTheButton(String buttonText) {
        if (buttonText.equals("Send Reset Link")) {
            forgotPasswordPage.clickSendResetLink();
        }
    }

    @Then("I should see {string}")
    public void iShouldSee(String expectedMessage) {
        assertThat(forgotPasswordPage.getSuccessMessage())
            .contains(expectedMessage);
    }
}
```

### Step 7: Execute Tests

**Compile the code**:
```bash
cd your-test-project
mvn clean compile
```

**Run smoke tests**:
```bash
mvn verify -Dcucumber.filter.tags="@smoke"
```

**Run all tests**:
```bash
mvn clean verify
```

**View Serenity Report**:
```bash
# After tests complete
open target/site/serenity/index.html
```

The Serenity report shows:
- Test execution results (pass/fail)
- Screenshots for failures
- Step-by-step test execution details
- Test coverage by feature
- Trend analysis (if run multiple times)

---

## Command Reference

### `/analyze-story`

**Purpose**: Extract testable requirements from JIRA story

**Syntax**:
```
/analyze-story <JIRA-KEY>: <Story description>
```

**Examples**:
```
/analyze-story PROJ-123: User authentication feature
/analyze-story PROJ-456: Password reset functionality
/analyze-story User can filter products by category
```

**Output**: `specs/<story-key>/story-analysis.md`

**When to Use**: Always run this first when starting test automation for a new story

---

### `/clarify-story`

**Purpose**: Resolve ambiguities in story analysis

**Syntax**:
```
/clarify-story
```

**Prerequisites**: Requires `story-analysis.md` to exist

**Output**: Enhanced `story-analysis.md` with clarifications section

**When to Use**:
- When story-analysis.md contains `[NEEDS CLARIFICATION]` markers
- When requirements are vague or incomplete
- Before creating test plan (recommended)

**Tips**:
- Answer questions thoughtfully
- If you don't know the answer, consult Product Owner or BA
- You can run this multiple times if needed

---

### `/test-plan`

**Purpose**: Create comprehensive test plan document

**Syntax**:
```
/test-plan
```

**Prerequisites**: Requires `story-analysis.md`

**Output**: `specs/<story-key>/test-plan.md`

**When to Use**: After story analysis and clarifications are complete

**What It Contains**:
- Test scope and strategy
- Test cases with priorities
- Test environment requirements
- Test schedule
- Risks and mitigation
- Entry/exit criteria

---

### `/gherkin-scenarios`

**Purpose**: Generate BDD scenarios in Given/When/Then format

**Syntax**:
```
/gherkin-scenarios
```

**Prerequisites**: Requires `test-plan.md`

**Output**:
- `specs/<story-key>/gherkin/*.feature` files
- `specs/<story-key>/step-definitions-guide.md`

**When to Use**: After test plan is reviewed and approved

**Generated Artifacts**:
- Feature files with Gherkin scenarios
- Proper tags (@smoke, @P0, @ui, @api)
- Scenario Outlines for data-driven tests
- Step definitions guide

---

### `/test-strategy`

**Purpose**: Define test automation framework architecture

**Syntax**:
```
/test-strategy
```

**Prerequisites**: Requires `gherkin/*.feature` files

**Output**: `specs/<story-key>/test-automation-strategy.md`

**When to Use**: After Gherkin scenarios are finalized

**What It Contains**:
- Technology stack
- Framework architecture
- Design patterns
- Project structure
- Coding standards
- CI/CD integration

---

### `/implement-tests`

**Purpose**: Generate test automation code

**Syntax**:
```
/implement-tests
```

**Prerequisites**: Requires `test-automation-strategy.md` and `gherkin/*.feature` files

**Output**:
- Java test automation code
- `specs/<story-key>/implementation-summary.md`

**When to Use**: After test strategy is defined

**Generated Code**:
- Step definitions
- Page objects (UI tests)
- API clients (API tests)
- Model classes
- Utility classes
- Test runners
- Configuration files

---

## Best Practices

### 1. Story Analysis

✅ **DO**:
- Identify all test scenarios (positive, negative, edge cases)
- Document test data requirements clearly
- List all integration dependencies
- Flag ambiguities with `[NEEDS CLARIFICATION]`
- Consider non-functional requirements (performance, security)

❌ **DON'T**:
- Skip edge cases
- Assume requirements - ask if unclear
- Ignore integration points
- Forget about error scenarios

### 2. Clarifications

✅ **DO**:
- Run `/clarify-story` before creating test plan
- Answer questions accurately (consult BA/PO if needed)
- Document all clarifications for audit trail
- Focus on testability (how will you verify this?)

❌ **DON'T**:
- Skip clarifications because "it seems obvious"
- Guess answers - mark as "needs product owner input"
- Ignore vague requirements

### 3. Test Planning

✅ **DO**:
- Define clear test scope (in-scope / out-of-scope)
- Prioritize test cases (P0 > P1 > P2)
- Include both UI and API tests where appropriate
- Plan for test data setup and teardown
- Identify risks and mitigation strategies

❌ **DON'T**:
- Test everything through UI (use API tests for speed)
- Skip test environment requirements
- Ignore test data dependencies
- Forget to define entry/exit criteria

### 4. Gherkin Scenarios

✅ **DO**:
- Use business language (avoid technical jargon)
- Keep scenarios independent (no order dependencies)
- Use descriptive scenario names
- Apply tags consistently (@smoke, @P0, @ui)
- Use Scenario Outline for data-driven tests
- Use Background for common preconditions

❌ **DON'T**:
- Write technical implementation details in scenarios
- Create dependent scenarios (one relies on another)
- Mix multiple test purposes in one scenario
- Forget to tag scenarios

### 5. Test Implementation

✅ **DO**:
- Review generated code before committing
- Follow Page Object Model for UI tests
- Use API clients for API tests
- Write reusable utility functions
- Keep step definitions thin (delegate to page objects)
- Add meaningful comments
- Follow naming conventions

❌ **DON'T**:
- Put WebDriver calls directly in step definitions
- Hardcode test data in code
- Copy-paste code (create reusable functions)
- Skip code reviews
- Ignore compilation warnings

### 6. Test Execution

✅ **DO**:
- Run smoke tests frequently (every commit)
- Run full regression before releases
- Review Serenity reports thoroughly
- Fix flaky tests immediately
- Monitor test execution time
- Clean up test data after tests

❌ **DON'T**:
- Ignore test failures ("it works on my machine")
- Let flaky tests remain in the suite
- Skip test maintenance
- Run all tests through UI (slow)

### 7. Collaboration with AI Agent

✅ **DO**:
- Provide clear, specific inputs to commands
- Review and validate AI-generated artifacts
- Ask the AI to explain generated code if unclear
- Iterate on generated code (ask for improvements)
- Use the constitution as a reference

❌ **DON'T**:
- Blindly trust AI-generated code without review
- Skip validation of test scenarios
- Ignore constitution principles
- Forget to commit generated artifacts to Git

---

## Troubleshooting

### Issue: `/analyze-story` command not found

**Cause**: AI agent can't find prompt files

**Solution**:
1. Verify prompt files exist:
   ```bash
   ls spec-kit-copilot/qa-sdet-automation-kit/.github/prompts/
   ```
2. Ensure your AI agent is configured to read from `.github/prompts/`
3. For Claude Code, prompts are auto-detected
4. For other agents, consult their documentation

---

### Issue: PowerShell script permission denied

**Cause**: Scripts are not executable

**Solution**:
```bash
# macOS/Linux
chmod +x spec-kit-copilot/qa-sdet-automation-kit/.specify/scripts/powershell/*.ps1

# Windows
# Run PowerShell as Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

### Issue: "ERROR: Story directory not found"

**Cause**: The test feature directory hasn't been created

**Solution**:
Run `/analyze-story` first to create the directory structure

---

### Issue: Generated code doesn't compile

**Cause**: Missing dependencies or incorrect Java version

**Solution**:
1. Verify Java version:
   ```bash
   java --version  # Should be 11+
   ```
2. Verify Maven dependencies:
   ```bash
   mvn dependency:tree
   ```
3. Clean and rebuild:
   ```bash
   mvn clean compile
   ```
4. Check for missing imports in generated code

---

### Issue: Tests fail with "Element not found"

**Cause**: Locators in page objects don't match actual application

**Solution**:
1. Inspect the application HTML
2. Update locators in page object classes
3. Use more robust locators (ID > CSS > XPath)
4. Add explicit waits:
   ```java
   element.waitUntilVisible().click();
   ```

---

### Issue: API tests fail with 401 Unauthorized

**Cause**: Authentication not configured properly

**Solution**:
1. Verify API credentials in `application.properties`
2. Check authentication token generation
3. Review `BaseApiClient.java` authentication logic
4. Verify test environment is accessible

---

### Issue: Serenity report not generated

**Cause**: Maven plugin not configured or tests didn't run

**Solution**:
1. Verify Serenity Maven plugin in `pom.xml`:
   ```xml
   <plugin>
       <groupId>net.serenity-bdd.maven.plugins</groupId>
       <artifactId>serenity-maven-plugin</artifactId>
       <version>3.x.x</version>
       <executions>
           <execution>
               <id>serenity-reports</id>
               <phase>post-integration-test</phase>
               <goals>
                   <goal>aggregate</goal>
               </goals>
           </execution>
       </executions>
   </plugin>
   ```
2. Run aggregate goal manually:
   ```bash
   mvn serenity:aggregate
   ```
3. Check report location: `target/site/serenity/index.html`

---

### Issue: Too many scenarios generated

**Cause**: AI agent created exhaustive test cases

**Solution**:
1. Review test plan and prioritize
2. Remove low-priority (P3) test cases
3. Combine similar scenarios using Scenario Outline
4. Focus on critical paths first (P0/P1)
5. You can ask AI agent to reduce coverage:
   ```
   @qa-agent Please reduce test scenarios to only P0 and P1 priorities
   ```

---

## FAQ

### Q1: Do I need to know Java to use this kit?

**A**: Basic Java knowledge helps, but it's not required. The AI agent generates most of the code for you. You'll learn Java by reviewing and modifying the generated code. Focus on understanding:
- Object-oriented concepts (classes, methods)
- How to read Java syntax
- Basic data types (String, int, boolean)

The kit follows consistent patterns (Page Object Model, API Clients), so once you understand one example, you can apply it everywhere.

---

### Q2: Can I use this with existing test automation projects?

**A**: Yes! The kit generates code that integrates with existing Serenity Cucumber projects. Just ensure your project has:
- Correct dependencies (Serenity, Cucumber, RestAssured)
- Standard project structure (`src/test/java`)
- Compatible Java version (11+)

The AI agent will detect your project structure and adapt accordingly.

---

### Q3: What if my project uses a different framework (not Serenity)?

**A**: Currently, this kit is optimized for Serenity Cucumber. However, you can:
- Use the workflow (analyze, plan, gherkin) and manually adapt implementation
- Modify prompt files to generate code for your framework
- Use Gherkin scenarios as-is (Cucumber is standard)
- Adapt step definitions to your framework

---

### Q4: How long does the entire workflow take?

**A**: Typical timeline for a medium-sized story:
- `/analyze-story`: 2-5 minutes
- `/clarify-story`: 5-10 minutes (depends on questions)
- `/test-plan`: 3-5 minutes
- `/gherkin-scenarios`: 5-10 minutes
- `/test-strategy`: 2-5 minutes
- `/implement-tests`: 10-20 minutes

**Total: 30-60 minutes** from story to executable tests

Compare this to manual approach: 4-8 hours

---

### Q5: Can I run commands in a different order?

**A**: No, the commands have dependencies:

```
analyze-story (required first)
    ↓
clarify-story (optional but recommended)
    ↓
test-plan (requires story-analysis.md)
    ↓
gherkin-scenarios (requires test-plan.md)
    ↓
test-strategy (requires gherkin files)
    ↓
implement-tests (requires test-strategy.md)
```

Each command validates prerequisites and will error if dependencies are missing.

---

### Q6: What if I disagree with AI-generated test scenarios?

**A**: You should review and modify! The AI agent is a **collaborator**, not a dictator. After any command:

1. Review the generated artifact
2. Edit the file directly to add/remove/modify scenarios
3. Continue to the next command with your changes
4. Or ask the AI agent to regenerate:
   ```
   @qa-agent The password reset scenarios are missing the "link already used" edge case. Please add it.
   ```

---

### Q7: How do I handle stories with unclear requirements?

**A**:
1. Run `/analyze-story` - it will flag ambiguities
2. Run `/clarify-story` - answer what you can
3. For questions you can't answer, document them:
   - In clarifications: "Requires product owner input"
   - In test plan: "Blocked - awaiting clarification"
4. Schedule meeting with BA/PO to resolve
5. Re-run `/clarify-story` after getting answers

---

### Q8: Can multiple QA engineers work on the same story?

**A**: Yes, with Git branching:

1. QA Engineer 1 runs `/analyze-story` and creates branch `test/proj-123`
2. Commits `story-analysis.md` and `test-plan.md`
3. QA Engineer 2 pulls branch, reviews artifacts
4. QA Engineer 1 implements UI tests
5. QA Engineer 2 implements API tests (parallel work)
6. Both commit to same branch
7. Merge to main after review

Use clear file organization:
- `stepdefinitions/ui/` (QA Engineer 1)
- `stepdefinitions/api/` (QA Engineer 2)

---

### Q9: How do I maintain tests when requirements change?

**A**:
1. Update `story-analysis.md` with new requirements
2. Update `test-plan.md` with new test cases
3. Update Gherkin scenarios in `gherkin/*.feature` files
4. Ask AI agent to regenerate affected code:
   ```
   @qa-agent Requirements changed: password reset link now expires after 1 hour (not 24 hours).
   Please update the test scenarios and implementation.
   ```
5. Review and commit changes

**Important**: Keep specification artifacts (story-analysis, test-plan, gherkin) updated. They are your source of truth.

---

### Q10: What if tests are flaky?

**A**: Flaky tests are a sign of implementation issues:

**Common Causes**:
1. **No waits**: Using `Thread.sleep()` instead of explicit waits
   - **Fix**: Use `element.waitUntilVisible()` or `waitUntilClickable()`

2. **Race conditions**: Elements not ready when accessed
   - **Fix**: Add proper waits, check element state before interaction

3. **Test data conflicts**: Tests interfere with each other
   - **Fix**: Use unique test data per test, clean up after tests

4. **Environment issues**: Test environment unstable
   - **Fix**: Verify environment health, use retries for external services

**Constitution Principle**: No flaky tests tolerated. Fix root cause or remove test.

---

## Tips for Effective AI Agent Collaboration

### 1. Be Specific with Inputs

❌ **Vague**:
```
/analyze-story Login feature
```

✅ **Specific**:
```
/analyze-story PROJ-789: Users can log in with email and password, with optional "Remember Me" functionality and password visibility toggle
```

The more context you provide, the better the AI agent can help.

---

### 2. Review Everything

Don't blindly trust AI-generated artifacts:
- Read `story-analysis.md` - are scenarios complete?
- Review `test-plan.md` - is strategy appropriate?
- Check Gherkin scenarios - are they business-readable?
- Inspect generated code - does it follow best practices?

The AI agent is smart, but you're the QA expert.

---

### 3. Ask for Explanations

If generated code is unclear:
```
@qa-agent Can you explain what the TestDataGenerator.generateRandomUser() method does and why we need it?
```

Learning from the AI agent improves your skills.

---

### 4. Iterate and Refine

After code generation:
```
@qa-agent The LoginPage class is too large. Can you refactor it by extracting the form validation logic into a separate FormValidator utility class?
```

Treat the AI agent as a pair programmer.

---

### 5. Use the Constitution as Reference

When in doubt, refer to the constitution:
```bash
cat spec-kit-copilot/qa-sdet-automation-kit/.specify/memory/constitution.md
```

Example:
- Principle III: Test Independence → Ensure your tests don't depend on each other
- Principle IV: Page Object Model → Don't put WebDriver calls in step definitions

---

### 6. Leverage Examples

The kit includes templates with examples:
- `gherkin-feature-template.md` shows Gherkin best practices
- `story-analysis-template.md` shows how to document scenarios

Study these templates to understand expected output format.

---

### 7. Provide Feedback to the AI Agent

If generated code has issues:
```
@qa-agent The step definition "I enter {string} in the {string} field" is too generic.
Can you create specific step definitions for each field (username, password, email)
for better readability and maintenance?
```

The AI agent learns from your feedback.

---

### 8. Use Version Control

Commit after each major step:
```bash
git add specs/proj-123/
git commit -m "Add story analysis for PROJ-123"

git add specs/proj-123/gherkin/
git commit -m "Add Gherkin scenarios for password reset"

git add src/test/java/
git commit -m "Implement test automation for password reset"
```

This allows you to roll back if needed.

---

### 9. Run Tests Early and Often

Don't wait until everything is implemented:
```bash
# After implementing first scenario
mvn verify -Dcucumber.filter.tags="@PROJ-123 and @smoke"

# Fix any issues before proceeding
```

Continuous validation prevents compounding errors.

---

### 10. Share Knowledge with Your Team

Document your learnings:
- Create team wiki with common patterns
- Share generated code examples
- Conduct knowledge transfer sessions
- Contribute improvements to prompts

The kit improves as your team learns.

---

## Getting Help

### Internal Resources

1. **Constitution**: `spec-kit-copilot/qa-sdet-automation-kit/.specify/memory/constitution.md`
2. **README**: `spec-kit-copilot/qa-sdet-automation-kit/README.md`
3. **Templates**: `spec-kit-copilot/qa-sdet-automation-kit/.specify/templates/`
4. **Examples**: Review previous test implementations in your project

### External Resources

1. **Serenity BDD Documentation**: https://serenity-bdd.info
2. **Cucumber Documentation**: https://cucumber.io/docs/
3. **Selenium WebDriver**: https://www.selenium.dev/documentation/
4. **RestAssured**: https://rest-assured.io/
5. **Java Faker** (test data): https://github.com/DiUS/java-faker

### Team Support

- **QA Lead**: For test strategy and planning questions
- **SDET Mentor**: For technical implementation questions
- **Product Owner**: For requirements clarifications
- **Dev Team**: For environment and integration questions

---

## Next Steps After Onboarding

### Immediate (First Week)

1. ✅ Complete this onboarding guide
2. ✅ Run through the example walkthrough
3. ✅ Pick a small JIRA story (1-2 days effort)
4. ✅ Complete the full workflow for that story
5. ✅ Execute tests and review Serenity report
6. ✅ Get code review from SDET mentor

### Short-term (First Month)

1. Automate 5-10 JIRA stories using the kit
2. Experiment with different types of testing (UI, API, Integration)
3. Learn Java and Serenity patterns by studying generated code
4. Contribute improvements to prompts or templates
5. Share your experience with the team

### Long-term (Ongoing)

1. Become proficient with the workflow (< 1 hour per story)
2. Mentor new QA engineers on the kit
3. Propose enhancements to the framework
4. Contribute to test automation standards
5. Measure and improve test coverage over time

---

## Success Criteria

You've successfully onboarded when you can:

✅ Run the full workflow independently (analyze → implement → execute)
✅ Generate test automation code from a JIRA story in < 1 hour
✅ Write or modify Gherkin scenarios following BDD best practices
✅ Understand and modify generated Java code (page objects, step definitions)
✅ Execute tests and interpret Serenity reports
✅ Follow the constitution principles without referring to documentation
✅ Troubleshoot common issues independently
✅ Collaborate effectively with AI agent (specific inputs, iterate, refine)
✅ Review and improve AI-generated artifacts
✅ Integrate tests with CI/CD pipeline

---

## Feedback and Continuous Improvement

This kit is a living framework that improves through team usage.

**Share Feedback**:
- What worked well?
- What was confusing?
- What features are missing?
- What prompts need improvement?

**Contribute**:
- Propose prompt enhancements
- Add new templates
- Share best practices
- Update documentation

**Measure Impact**:
- Time saved per story
- Test coverage improvement
- Defect detection rate
- Test maintenance effort

---

## Conclusion

Congratulations! You now have the knowledge to leverage AI-assisted test automation to transform JIRA stories into comprehensive, maintainable test suites.

**Remember**:
- 🤖 The AI agent is your **collaborator**, not a replacement
- 📋 Follow the **workflow** (analyze → clarify → plan → gherkin → strategy → implement)
- 📖 Refer to the **constitution** for principles
- 🔍 **Review and validate** all AI-generated artifacts
- 🔄 **Iterate and refine** to improve quality
- 🎯 Focus on **test coverage** and **maintainability**

**Happy Testing!** 🚀

---

**Document Version**: 1.0.0
**Last Updated**: 2025-01-XX
**Maintained By**: QA Engineering Team
**Questions?** Contact: qa-team@yourcompany.com
