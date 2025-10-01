QA SDET Automation Kit: Spec-Driven Test Automation

Transform JIRA stories into comprehensive automated test suites
Built specifically for QA Engineers, SDETs, and Test Automation Engineers
Follows BDD best practices with Serenity Cucumber framework
---

The Challenge: Traditional Test Automation Workflow

Manual test planning from JIRA stories
Inconsistent Gherkin scenario quality
No standardized automation strategy
Code quality varies across team members
Technical debt accumulates over time
---

The Solution: QA SDET Automation Kit

Automated workflow from JIRA story to production-ready tests
7 specialized commands guide the entire process
Built-in quality gates prevent technical debt
Generates clean, maintainable test automation code
Constitutional principles enforced automatically
---

Complete Workflow Overview

JIRA Story → /analyze-story → story-analysis.md
/clarify-story → Enhanced analysis with clarifications
/test-plan → Comprehensive test plan document
/gherkin-scenarios → BDD feature files
/test-strategy → Automation framework strategy
/implement-tests → Java test automation code
/review-code → Quality gate before commit
---

Command 1: /analyze-story

Parses JIRA story and extracts testable requirements
Identifies user personas and acceptance criteria
Maps functional requirements to test scenarios
Categorizes tests: positive, negative, edge cases
Documents test data needs and dependencies
Output: specs/[STORY-KEY]/story-analysis.md
---

Command 2: /clarify-story

Identifies ambiguities in requirements before test planning
Asks up to 5 targeted questions (multiple choice or short answer)
Updates story analysis after each answer
Creates audit trail of clarifications
Prevents assumptions that lead to wrong tests
Output: Enhanced story-analysis.md
---

Command 3: /test-plan

Defines test scope (in-scope / out-of-scope)
Maps test strategy (levels, types, automation approach)
Creates test case mapping (TC-001, TC-002, etc.)
Documents environment and test data requirements
Defines entry/exit criteria and risk mitigation
Output: specs/[STORY-KEY]/test-plan.md
---

Command 4: /gherkin-scenarios

Converts test cases to Given/When/Then format
Applies proper BDD structure and business language
Uses tags for filtering (@smoke, @P0, @api, @ui)
Creates Scenario Outlines for data-driven tests
Generates step definitions guide
Output: specs/[STORY-KEY]/gherkin/*.feature files
---

Command 5: /test-strategy

Defines technology stack (Java, Serenity, Cucumber, Maven/Gradle)
Specifies framework architecture (Page Object Model / Screenplay)
Documents project structure (packages, layers, design patterns)
Defines coding standards and CI/CD integration
Configures Serenity reporting approach
Output: specs/[STORY-KEY]/test-automation-strategy.md
---

Command 6: /implement-tests

Generates complete Java test automation code
Creates step definitions for Gherkin scenarios
Implements Page Objects for UI tests
Implements API clients for API tests
Generates test runners (Smoke, Regression, API, UI)
Configures Serenity and Cucumber framework
---

Command 7: /review-code - Quality Gate

Comprehensive code quality review before Git commit
Validates constitutional compliance (POM, API Client Pattern)
Checks clean code principles (function size, SRP, DRY)
Detects flaky test patterns (Thread.sleep, hardcoded waits)
Severity-ranked violations: CRITICAL, HIGH, MEDIUM, LOW
Auto-fix capability for common violations
Gates commit until quality standards met
---

Code Review: What Gets Checked

Clean Code: Function size ≤20 lines, SRP, parameter count ≤3
Constitutional Standards: Page Object Model, API Client Pattern
Test Independence: No order dependencies
Test Data Management: No hardcoded data
No flaky patterns: Thread.sleep, hardcoded waits
Proper exception handling and assertions
DRY violations and code duplication
---

Code Review: Severity Levels

🔴 CRITICAL: Constitutional violations, security issues (must fix)
🟠 HIGH: Maintainability issues, major violations (should fix)
🟡 MEDIUM: Code smells, minor issues (improve when possible)
⚪ LOW: Optional improvements, style issues
Gate decision: PASS ✅ or FAIL 🔴
---

Code Review: Interactive Remediation

Presents violations with detailed explanations
Offers auto-fix for common patterns
Shows before/after code examples
Provides learning context for each violation
Re-runs review after fixes applied
Ensures all critical issues resolved before commit
---

Technology Stack

Core: Java 11/17, Maven/Gradle, JUnit 5/TestNG
BDD: Cucumber, Serenity BDD
Automation: Selenium WebDriver (UI), RestAssured (API)
Libraries: AssertJ, Hamcrest, Faker, Jackson
CI/CD: Jenkins, GitHub Actions, GitLab CI, Azure DevOps
---

Key Features: BDD-First Approach

Gherkin scenarios are business-readable
Scenarios serve as living documentation
Given/When/Then structure enforced
Tags enable flexible test execution
Priority-based execution (@P0, @P1, @P2)
---

Key Features: Serenity Integration

Comprehensive HTML reports with screenshots
API request/response documentation
Coverage by feature, tag, and priority
Trend analysis across test runs
Integrates with CI/CD pipelines
Report location: target/site/serenity/index.html
---

Key Features: Design Patterns

Page Object Model for UI tests (no WebDriver in steps)
API Client Pattern for API tests (no RestAssured in steps)
Screenplay Pattern available for advanced scenarios
Clean separation of concerns
Reusable, maintainable test code
---

Generated Artifacts Structure

specs/[STORY-KEY]/story-analysis.md
specs/[STORY-KEY]/test-plan.md
specs/[STORY-KEY]/test-automation-strategy.md
specs/[STORY-KEY]/gherkin/*.feature files
specs/[STORY-KEY]/implementation-summary.md
specs/[STORY-KEY]/code-quality-report.md
src/test/java/ - Complete test automation code
---

Real Example: Password Reset Feature

Input: JIRA-456 "User can reset password via email"
Story analysis: 10 test scenarios identified
Test plan: 15 test cases mapped (TC-001 to TC-015)
Gherkin: 15 scenarios across 2 feature files
Implementation: 5 step definitions, 3 page objects, 1 API client
Code review: ✅ All quality gates passed
---

Comparison: Developer Spec-Kit vs QA SDET Kit

Developer: Builds production features from scratch
QA SDET: Tests existing JIRA stories
Developer: /specify command defines new requirements
QA SDET: /analyze-story parses existing requirements
Developer: Outputs production code (any language)
QA SDET: Outputs test automation code (Java/Serenity)
Both: Enforce quality standards before commit
---

Best Practices: Story Analysis

Be thorough identifying test scenarios
Don't skip edge cases and negative flows
Document all assumptions clearly
Identify risks and dependencies early
Consider non-functional requirements
---

Best Practices: Test Implementation

Follow Page Object Model for UI tests
Use API Client Pattern for API tests
Keep step definitions thin (delegate to page objects)
Write reusable utility functions
Maintain clean code standards
Test data generated, not hardcoded
---

Best Practices: Code Quality Review

Always run /review-code before committing
Fix CRITICAL violations immediately (non-negotiable)
Address HIGH violations before commit
Use auto-fix for quick remediation
Learn from violations - understand why they matter
Don't skip review to save time
Run after each iteration if fixing issues
---

Why Quality Gates Matter

Prevents technical debt accumulation
Enforces constitutional principles consistently
Educates QA engineers on clean code
Maintains consistent code quality across team
Catches issues before human code review
Reduces long-term maintenance burden
Builds quality culture in the team
---

CI/CD Integration

Maven/Gradle execution: mvn clean verify
Tag-based execution: -Dcucumber.filter.tags="@smoke"
Runner-based execution: -Dtest=ApiTestRunner
Jenkins pipeline templates included
GitHub Actions workflows provided
Serenity reports published to CI artifacts
---

Quick Start: 7-Step Process

Step 1: /analyze-story [JIRA-KEY]
Step 2: /clarify-story (answer questions)
Step 3: /test-plan
Step 4: /gherkin-scenarios
Step 5: /test-strategy
Step 6: /implement-tests
Step 7: /review-code (fix violations, then commit)
---

Benefits: Speed and Consistency

Reduces test automation time by 60-70%
Consistent code quality across team
No more "it depends on who wrote it"
New team members productive immediately
Constitutional principles enforced automatically
Quality gates catch issues early
---

Benefits: Learning and Growth

Built-in education through code review feedback
Explanations for why violations matter
Before/after examples for each fix
Learns clean code principles through practice
Reduces dependency on senior engineers for reviews
Builds institutional knowledge in the codebase
---

When to Use This Kit

✅ You are a QA Engineer/SDET
✅ You receive JIRA stories to test
✅ You need to create test automation
✅ You use or want to use Serenity Cucumber BDD
✅ You follow or want to follow BDD practices
✅ You want consistent, maintainable test code
---

Extensibility and Customization

Add custom templates for your organization
Extend prompts for specific test types
Customize framework architecture
Integrate with your test management tools
Add organization-specific quality rules
Adapt to your CI/CD pipeline requirements
---

Success Metrics

Code quality score: Track CRITICAL/HIGH violations over time
Test automation velocity: Stories automated per sprint
Code review time: Reduced by catching issues early
Technical debt: Prevented before entering codebase
Team consistency: Standard code patterns across team
Maintenance burden: Reduced flaky tests and refactoring needs
---

Demo: Live Walkthrough

Show /analyze-story on sample JIRA story
Demonstrate /clarify-story interactive questions
Generate /test-plan and review structure
Create /gherkin-scenarios and show BDD format
Run /implement-tests and show generated code
Execute /review-code and fix violations
Commit clean code to Git
---

Next Steps + Getting Started

Install QA SDET Automation Kit in your project
Run through Quick Start with a simple JIRA story
Review generated artifacts and customize templates
Integrate /review-code into your Git workflow
Train team on the 7-step process
Monitor quality metrics and iterate
---

Questions and Discussion

How does this fit your current workflow?
What quality issues do you face today?
How can we customize this for your team?
What integrations do you need?
Ready to pilot with your team?