# AI Task Template - Java BDD API Testing

> **Instructions:** This template helps you create comprehensive task documents for AI-driven API test automation development. Fill out each section thoroughly to ensure the AI agent has all necessary context and can execute the task systematically.

---

## 1. Task Overview

### Task Title
<!-- Provide a clear, specific title for this task -->
**Title:** [Brief, descriptive title of what you're building/fixing]

### Goal Statement
<!-- One paragraph describing the high-level objective -->
**Goal:** [Clear statement of what you want to achieve and why it matters]

---

## 2. Strategic Analysis & Solution Options

### When to Use Strategic Analysis
<!--
AI Agent: Use your judgement to determine when strategic analysis is needed vs direct implementation.

**✅ CONDUCT STRATEGIC ANALYSIS WHEN:**
- Multiple viable technical approaches exist
- Trade-offs between different solutions are significant
- Test implementation could be approached through different patterns
- Test architecture decisions will impact future development
- Implementation approach affects maintainability or scalability significantly
- Change touches multiple test layers or has broad impact
- User has expressed uncertainty about the best approach

**❌ SKIP STRATEGIC ANALYSIS WHEN:**
- Only one obvious technical solution exists
- It's a straightforward test scenario addition or bug fix
- The test implementation pattern is clearly established in the codebase
- Change is small and isolated with minimal impact
- User has already specified the exact approach they want

**DEFAULT BEHAVIOR:** When in doubt, provide strategic analysis. It's better to over-communicate than to assume.
-->

### Problem Context
<!-- Restate the problem and why it needs strategic consideration -->
[Explain the problem and why multiple solutions should be considered - what makes this decision important?]

### Solution Options Analysis

#### Option 1: [Solution Name]
**Approach:** [Brief description of this solution approach]

**Pros:**
- ✅ [Advantage 1 - specific benefit]
- ✅ [Advantage 2 - quantified when possible]
- ✅ [Advantage 3 - why this is better]

**Cons:**
- ❌ [Disadvantage 1 - specific limitation]
- ❌ [Disadvantage 2 - trade-off or cost]
- ❌ [Disadvantage 3 - risk or complexity]

**Implementation Complexity:** [Low/Medium/High] - [Brief justification]
**Risk Level:** [Low/Medium/High] - [Primary risk factors]

#### Option 2: [Solution Name]
**Approach:** [Brief description of this solution approach]

**Pros:**
- ✅ [Advantage 1]
- ✅ [Advantage 2]
- ✅ [Advantage 3]

**Cons:**
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]
- ❌ [Disadvantage 3]

**Implementation Complexity:** [Low/Medium/High] - [Brief justification]
**Risk Level:** [Low/Medium/High] - [Primary risk factors]

#### Option 3: [Solution Name] (if applicable)
**Approach:** [Brief description of this solution approach]

**Pros:**
- ✅ [Advantage 1]
- ✅ [Advantage 2]

**Cons:**
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]

**Implementation Complexity:** [Low/Medium/High] - [Brief justification]
**Risk Level:** [Low/Medium/High] - [Primary risk factors]

### Recommendation & Rationale

**🎯 RECOMMENDED SOLUTION:** Option [X] - [Solution Name]

**Why this is the best choice:**
1. **[Primary reason]** - [Specific justification]
2. **[Secondary reason]** - [Supporting evidence]
3. **[Additional reason]** - [Long-term considerations]

**Key Decision Factors:**
- **Test Maintainability:** [How this affects test suite maintenance]
- **Execution Performance:** [How this affects test execution time]
- **Test Readability:** [How this affects test clarity and understanding]
- **Reusability:** [How this enables code reuse]
- **Scalability:** [How this handles growth of test scenarios]

**Alternative Consideration:**
[If there's a close second choice, explain why it wasn't selected and under what circumstances it might be preferred]

### Decision Request

**👤 USER DECISION REQUIRED:**
Based on this analysis, do you want to proceed with the recommended solution (Option [X]), or would you prefer a different approach?

**Questions for you to consider:**
- Does the recommended solution align with your priorities?
- Are there any constraints or preferences I should factor in?
- Do you have a different timeline or complexity preference?

**Next Steps:**
Once you approve the strategic direction, I'll update the implementation plan and present you with next step options.

---

## 3. Project Analysis & Current State

### Technology & Test Framework
<!--
AI Agent: Analyze the project to fill this out.
- Check `pom.xml` or `build.gradle` for dependencies and versions.
- Check `serenity.properties` or `serenity.conf` for Serenity configuration.
- Check existing test packages for organizational patterns.
- Check test runners for execution configuration.
- Check utilities package for existing helper classes.
-->

- **Java Version:** [e.g., Java 11, Java 17, Java 21]
- **Build Tool & Version:** [e.g., Maven 3.9.x, Gradle 8.x]
- **BDD Framework:** [e.g., Cucumber 7.x + Serenity BDD 4.x]
- **HTTP Client:** [e.g., RestAssured, OkHttp, Apache HttpClient]
- **Assertion Library:** [e.g., AssertJ, Hamcrest, JUnit assertions]
- **Test Runner:** [e.g., JUnit 5, TestNG]
- **JSON Processing:** [e.g., Jackson, Gson, JSON-B]
- **Test Data Management:** [e.g., JSON files, CSV files, database fixtures, Java builders]
- **CI/CD Integration:** [e.g., Jenkins, GitLab CI, GitHub Actions, Azure DevOps]
- **Reporting:** [e.g., Serenity reports, Cucumber reports, Allure]

### Project Structure
**Package Organization:**
```
src/test/java/
├── [base.package]/
│   ├── stepdefinitions/     # Cucumber step definitions (glue code)
│   ├── steps/               # Reusable action methods
│   ├── models/              # POJOs/DTOs for API requests/responses
│   ├── utils/               # HTTP clients, helpers, utilities
│   ├── builders/            # Test data builders (optional)
│   └── runners/             # Test runners
src/test/resources/
├── features/                # Cucumber .feature files
├── testdata/               # Test data files (JSON, CSV, etc.)
└── serenity.properties     # Serenity configuration
```

### Current State
<!-- Describe what exists today based on actual analysis -->
[Describe the current test suite state, existing scenarios, coverage, and what's working/not working - based on actual file analysis, not assumptions]

### Existing Test Patterns Analysis
<!--
AI Agent: MANDATORY - Analyze existing test patterns before planning new tests
- Check stepdefinitions/ directory for step definition patterns
- Check steps/ directory for action method patterns
- Check models/ directory for existing POJOs
- Check utils/ directory for HTTP client configuration and helpers
- Identify data-driven testing patterns
- Identify test scenario organization patterns
-->

**Step Definition Patterns:**
- [How are step definitions organized? By feature? By endpoint? By domain?]
- [Are step definitions stateless or stateful?]
- [How is state shared between steps?]

**Steps/Actions Layer:**
- [How are API calls structured?]
- [Are there base classes or interfaces?]
- [How is request/response handling abstracted?]

**Model Patterns:**
- [How are request/response POJOs organized?]
- [Are there base model classes?]
- [How is JSON serialization/deserialization handled?]

**Utilities Organization:**
- [What HTTP client utilities exist?]
- [How is authentication handled?]
- [What common test helpers are available?]

**Test Data Management:**
- [How is test data currently managed?]
- [Are there builders or fixtures?]
- [How is data cleanup handled?]

## 4. Context & Problem Definition

### Problem Statement
<!-- What specific problem are you solving? -->
[Detailed explanation of the problem, including pain points, test gaps, API coverage issues, and why this needs to be solved now]

### Success Criteria
<!-- How will you know this is complete and successful? -->
- [ ] [Specific, measurable outcome 1]
- [ ] [Specific, measurable outcome 2]
- [ ] [Specific, measurable outcome 3]

---

## 5. Development Mode Context

### Development Mode Context
- **🚨 IMPORTANT: This is a test automation project in active development**
- **No backwards compatibility concerns** - feel free to refactor test structure
- **Test data loss acceptable** - existing test data can be regenerated
- **Test suite users are QA/SDET team** - not production users requiring careful migration
- **Priority: Test clarity and maintainability** over preserving old patterns
- **Aggressive refactoring allowed** - delete/recreate test scenarios as needed

---

## 6. Test Requirements

### API Endpoints Under Test
<!-- What API endpoints will be tested? -->
- **Endpoint:** `[HTTP METHOD] /api/path/to/resource`
  - **Purpose:** [What this endpoint does]
  - **Authentication:** [None, Basic Auth, Bearer Token, OAuth, API Key]
  - **Key Scenarios:** [List main scenarios to test]

### Test Scenarios
<!-- What scenarios need to be covered? -->

**Positive Scenarios:**
- [ ] [Scenario 1: Successful operation with valid data]
- [ ] [Scenario 2: Edge case with boundary values]
- [ ] [Scenario 3: Special conditions handling]

**Negative Scenarios:**
- [ ] [Scenario 1: Invalid request data]
- [ ] [Scenario 2: Missing required fields]
- [ ] [Scenario 3: Unauthorized access attempt]
- [ ] [Scenario 4: Resource not found]

**Edge Cases:**
- [ ] [Edge case 1: Unusual but valid input]
- [ ] [Edge case 2: System limits testing]

### Data Validation Requirements
<!-- What needs to be validated in responses? -->
- **Status Code Validation:** [Expected HTTP status codes]
- **Response Body Validation:** [Fields to validate, data types, formats]
- **Response Schema Validation:** [JSON schema validation needed?]
- **Response Time Requirements:** [Performance expectations]
- **Header Validation:** [Required headers in response]

### Non-Functional Requirements
<!-- Performance, security, etc. -->
- **Performance:** [Response time expectations, e.g., < 500ms for GET requests]
- **Security:** [Authentication/authorization testing needs]
- **Test Execution Time:** [Individual test timeout, suite execution time goals]
- **Test Environment:** [Which environment(s) will tests run against?]
- **Test Data Isolation:** [How to ensure tests don't interfere with each other?]

### Technical Constraints
<!-- What limitations exist? -->
- [Constraint 1: Must use existing authentication mechanism]
- [Constraint 2: Cannot modify production data]
- [Constraint 3: Must be compatible with existing CI/CD pipeline]

---

## 7. Test Data Management

### Test Data Strategy
<!-- How will test data be managed? -->

**Approach:** [Choose one or more]
- [ ] **Static Test Data:** JSON/CSV files in `src/test/resources/testdata/`
- [ ] **Data Builders:** Java builder classes for creating test objects
- [ ] **API-Based Setup:** Create test data via API calls before tests
- [ ] **Database Fixtures:** Direct database setup (if applicable)
- [ ] **Random Data Generation:** Using libraries like Faker, RandomUtils

### Test Data Files
<!-- If using static data files -->
```
src/test/resources/
├── testdata/
│   ├── users/
│   │   ├── valid_user.json
│   │   └── invalid_user.json
│   ├── products/
│   │   └── product_catalog.json
│   └── auth/
│       └── credentials.json
```

### Data Builder Classes (Optional)
<!-- If using builder pattern -->
```java
// Example: UserDataBuilder.java
public class UserDataBuilder {
    private String username;
    private String email;
    private String role;

    public UserDataBuilder withUsername(String username) {
        this.username = username;
        return this;
    }

    public User build() {
        return new User(username, email, role);
    }
}
```

### Test Data Cleanup
<!-- How to handle test data after execution -->
- [ ] **Cleanup Strategy:** [Delete after test, Reset to known state, Leave as-is]
- [ ] **Cleanup Location:** [AfterScenario hook, AfterSuite hook, Manual cleanup]
- [ ] **Isolation Approach:** [Unique data per test, Shared data with reset, Parallel-safe data]

---

## 8. API Test Organization & Architecture

### Test Layer Architecture

**Layer 1: Feature Files (Gherkin)**
- Location: `src/test/resources/features/`
- Purpose: Business-readable test scenarios
- Example: `user_management.feature`

**Layer 2: Step Definitions (Glue Code)**
- Location: `src/test/java/[package]/stepdefinitions/`
- Purpose: Map Gherkin steps to Java methods
- Pattern: One step definition class per feature OR organized by domain
- Example: `UserManagementStepDefinitions.java`

**Layer 3: Steps/Actions (Business Logic)**
- Location: `src/test/java/[package]/steps/`
- Purpose: Reusable action methods that interact with API
- Pattern: Page Object Model equivalent for APIs
- Example: `UserManagementSteps.java`

**Layer 4: Models (Data Transfer Objects)**
- Location: `src/test/java/[package]/models/`
- Purpose: POJOs for API request/response serialization
- Example: `User.java`, `CreateUserRequest.java`, `UserResponse.java`

**Layer 5: Utilities (Infrastructure)**
- Location: `src/test/java/[package]/utils/`
- Purpose: HTTP client configuration, common helpers
- Example: `ApiClient.java`, `AuthUtils.java`, `JsonUtils.java`

### Decision Flowchart - "Where should this code go?"

```
📝 What are you writing?

├─ 📄 Test Scenario in plain English?
│  └─ ✅ Feature File: src/test/resources/features/[feature].feature

├─ 🔗 Mapping Gherkin step to Java?
│  └─ ✅ Step Definition: src/test/java/.../stepdefinitions/[Feature]StepDefinitions.java

├─ 🎬 Reusable action (API call + validation)?
│  └─ ✅ Steps/Actions Class: src/test/java/.../steps/[Feature]Steps.java

├─ 📦 Data structure for request/response?
│  └─ ✅ Model/POJO: src/test/java/.../models/[Model].java

└─ 🛠️ Utility/Helper function?
   ├─ HTTP client configuration?
   │  └─ ✅ src/test/java/.../utils/ApiClient.java
   ├─ Authentication helper?
   │  └─ ✅ src/test/java/.../utils/AuthUtils.java
   └─ JSON processing utility?
      └─ ✅ src/test/java/.../utils/JsonUtils.java
```

### Code Organization Principles

**1. Feature Files (Gherkin)**
```gherkin
# src/test/resources/features/user_management.feature
Feature: User Management
  As an admin
  I want to manage user accounts
  So that I can control system access

  Scenario: Create a new user successfully
    Given I am authenticated as an admin
    When I create a new user with valid data
    Then the user should be created successfully
    And the response should contain the user ID
```

**2. Step Definitions (Glue Code)**
```java
// src/test/java/stepdefinitions/UserManagementStepDefinitions.java
public class UserManagementStepDefinitions {
    private UserManagementSteps userSteps = new UserManagementSteps();
    private Response response;

    @Given("I am authenticated as an admin")
    public void authenticateAsAdmin() {
        userSteps.authenticateAsAdmin();
    }

    @When("I create a new user with valid data")
    public void createUserWithValidData() {
        response = userSteps.createUser(TestDataBuilder.validUser());
    }

    @Then("the user should be created successfully")
    public void verifyUserCreated() {
        userSteps.verifyStatusCode(response, 201);
    }
}
```

**3. Steps/Actions (Business Logic)**
```java
// src/test/java/steps/UserManagementSteps.java
public class UserManagementSteps {
    private ApiClient apiClient = new ApiClient();

    public void authenticateAsAdmin() {
        apiClient.setAuthToken(AuthUtils.getAdminToken());
    }

    public Response createUser(User user) {
        return apiClient.post("/api/users", user);
    }

    public void verifyStatusCode(Response response, int expectedCode) {
        assertThat(response.statusCode()).isEqualTo(expectedCode);
    }
}
```

**4. Models (POJOs)**
```java
// src/test/java/models/User.java
public class User {
    private String username;
    private String email;
    private String role;

    // Constructors, getters, setters
}
```

**5. Utilities (Infrastructure)**
```java
// src/test/java/utils/ApiClient.java
public class ApiClient {
    private String baseUrl = ConfigReader.getProperty("api.base.url");
    private String authToken;

    public Response post(String endpoint, Object body) {
        return given()
            .baseUri(baseUrl)
            .header("Authorization", "Bearer " + authToken)
            .contentType(ContentType.JSON)
            .body(body)
        .when()
            .post(endpoint)
        .then()
            .extract().response();
    }
}
```

### When to Create New vs Extend Existing

**Create NEW Step Definitions class when:**
- Testing a completely different feature/domain
- No logical connection to existing step definition classes
- Existing classes are already too large (>200 lines)

**Extend EXISTING Step Definitions when:**
- Adding scenarios to same feature
- Steps are closely related to existing steps
- Can reuse significant amount of setup code

**Create NEW Steps/Actions class when:**
- Interacting with a different API resource/endpoint group
- Different business domain (Users vs Products vs Orders)
- No shared functionality with existing Steps classes

**Extend EXISTING Steps/Actions when:**
- Adding operations to same API resource
- Can reuse HTTP client configuration and base methods
- Logically part of same domain

---

## 9. Code Changes Overview

### 🚨 MANDATORY: Always Show High-Level Code Changes Before Implementation

**AI Agent Instructions:** Before presenting the task document for approval, you MUST provide a clear overview of the code changes you're about to make. This helps the user understand exactly what will be modified without having to approve first.

**Requirements:**
- [ ] **Always include this section** for any task that modifies existing code
- [ ] **Show actual code snippets** with before/after comparisons
- [ ] **Focus on key changes** - don't show every line, but show enough to understand the transformation
- [ ] **Use file paths and line counts** to give context about scope of changes
- [ ] **Explain the impact** of each major change

### Format to Follow:

#### 📂 **Current Implementation (Before)**
```java
// Show current test code that will be changed
// Include file paths and key logic
// Focus on the parts that will be modified
```

#### 📂 **After Refactor**
```java
// Show what the code will look like after changes
// Same files, but with new structure/logic
// Highlight the improvements
```

#### 🎯 **Key Changes Summary**
- [ ] **Change 1:** Brief description of what's being modified and why
- [ ] **Change 2:** Another major change with rationale
- [ ] **Files Modified:** List of files that will be changed
- [ ] **Impact:** How this affects the test suite behavior

**Note:** If no code changes are required (pure documentation/planning tasks), state "No code changes required" and explain what will be created or modified instead.

---

## 10. Implementation Plan

### Phase 1: Feature File Creation
**Goal:** Write Gherkin scenarios in business-readable language

- [ ] **Task 1.1:** Create or Update Feature File
  - Files: `src/test/resources/features/[feature_name].feature`
  - Details: Write Given/When/Then scenarios covering all test cases
- [ ] **Task 1.2:** Review Feature File for Clarity
  - Details: Ensure scenarios are clear, concise, and follow Gherkin best practices

### Phase 2: Model/POJO Creation
**Goal:** Create data models for API requests and responses

- [ ] **Task 2.1:** Create Request Models
  - Files: `src/test/java/[package]/models/[Model]Request.java`
  - Details: POJOs with proper annotations for JSON serialization
- [ ] **Task 2.2:** Create Response Models
  - Files: `src/test/java/[package]/models/[Model]Response.java`
  - Details: POJOs matching API response structure

### Phase 3: Utility Classes (If Needed)
**Goal:** Create reusable utilities for API interaction

- [ ] **Task 3.1:** Create/Update HTTP Client Utility
  - Files: `src/test/java/[package]/utils/ApiClient.java`
  - Details: HTTP client configuration, base URL, headers, authentication
- [ ] **Task 3.2:** Create Helper Utilities
  - Files: `src/test/java/[package]/utils/[Helper]Utils.java`
  - Details: JSON processing, data generation, common assertions

### Phase 4: Steps/Actions Layer
**Goal:** Implement reusable action methods for API interactions

- [ ] **Task 4.1:** Create Steps Class
  - Files: `src/test/java/[package]/steps/[Feature]Steps.java`
  - Details: Methods for API calls, response handling, common validations
- [ ] **Task 4.2:** Implement API Interaction Methods
  - Details: GET, POST, PUT, DELETE methods with proper error handling

### Phase 5: Step Definitions (Glue Code)
**Goal:** Map Gherkin steps to Java methods

- [ ] **Task 5.1:** Create Step Definitions Class
  - Files: `src/test/java/[package]/stepdefinitions/[Feature]StepDefinitions.java`
  - Details: Implement @Given, @When, @Then, @And annotations
- [ ] **Task 5.2:** Implement State Management
  - Details: Use instance variables or Serenity session storage for sharing data between steps

### Phase 6: Test Data Setup (If Applicable)
**Goal:** Create test data files or builders

- [ ] **Task 6.1:** Create Test Data Files
  - Files: `src/test/resources/testdata/[resource]/[data].json`
  - Details: Valid and invalid test data samples
- [ ] **Task 6.2:** Create Data Builders (Optional)
  - Files: `src/test/java/[package]/builders/[Model]Builder.java`
  - Details: Fluent builder pattern for creating test data

### Phase 7: Basic Code Validation (AI-Only)
**Goal:** Run safe static analysis only - NEVER run tests during validation

- [ ] **Task 7.1:** Code Quality Verification
  - Command: `mvn checkstyle:check` or `mvn spotbugs:check` (static analysis ONLY)
  - Details: Verify code style and potential bugs (NO test execution)
- [ ] **Task 7.2:** Compilation Check
  - Command: `mvn clean compile test-compile` (compile ONLY, do not run tests)
  - Details: Ensure all Java code compiles without errors

🛑 **CRITICAL WORKFLOW CHECKPOINT**
After completing Phase 7, you MUST:
1. Present "Implementation Complete!" message (exact text from section 15)
2. Wait for user approval of code review
3. Execute comprehensive code review process
4. NEVER proceed to test execution without completing code review first

### Phase 8: Comprehensive Code Review (Mandatory)
**Goal:** Present implementation completion and request thorough code review

- [ ] **Task 8.1:** Present "Implementation Complete!" Message (MANDATORY)
  - Template: Use exact message from section 15, step 7
  - Details: STOP here and wait for user code review approval
- [ ] **Task 8.2:** Execute Comprehensive Code Review (If Approved)
  - Process: Follow step 8 comprehensive review checklist from section 15
  - Details: Read all files, verify requirements, provide detailed summary

### Phase 9: User Test Execution (Only After Code Review)
**Goal:** Request human execution of tests to verify functionality

- [ ] **Task 9.1:** Present AI Validation Results
  - Files: Summary of compilation and static analysis results
  - Details: Provide comprehensive results of all AI-verifiable checks
- [ ] **Task 9.2:** Request User Test Execution
  - Command: User runs `mvn clean test` or `mvn verify`
  - Details: Clear instructions for user to execute tests and verify results
- [ ] **Task 9.3:** Wait for User Confirmation
  - Files: N/A
  - Details: Wait for user to complete test execution and report results

---

## 11. Task Completion Tracking - MANDATORY WORKFLOW

### Task Completion Tracking - MANDATORY WORKFLOW
🚨 **CRITICAL: Real-time task completion tracking is mandatory**

- [ ] **🗓️ GET TODAY'S DATE FIRST** - Before adding any completion timestamps, use the `time` tool to get the correct current date (fallback to web search if time tool unavailable)
- [ ] **Update task document immediately** after each completed subtask
- [ ] **Mark checkboxes as [x]** with completion timestamp using ACTUAL current date (not assumed date)
- [ ] **Add brief completion notes** (file paths, key changes, etc.)
- [ ] **This serves multiple purposes:**
  - [ ] **Forces verification** - You must confirm you actually did what you said
  - [ ] **Provides user visibility** - Clear progress tracking throughout implementation
  - [ ] **Prevents skipped steps** - Systematic approach ensures nothing is missed
  - [ ] **Creates audit trail** - Documentation of what was actually completed
  - [ ] **Enables better debugging** - If issues arise, easy to see what was changed

### Example Task Completion Format
```
### Phase 1: Feature File Creation
**Goal:** Write Gherkin scenarios in business-readable language

- [x] **Task 1.1:** Create Feature File ✓ 2025-01-15
  - Files: `src/test/resources/features/user_management.feature` ✓
  - Details: Created 5 scenarios covering happy path and error cases ✓
- [x] **Task 1.2:** Review Feature File for Clarity ✓ 2025-01-15
  - Details: Reviewed with stakeholder, clarity confirmed ✓
```

---

## 12. File Structure & Organization

### Project Structure - Java BDD API Testing

```
project-root/
├── src/
│   ├── main/java/                    # Application code (if applicable)
│   └── test/
│       ├── java/
│       │   └── [base.package]/
│       │       ├── stepdefinitions/   # Cucumber step definitions (glue code)
│       │       │   ├── UserManagementStepDefinitions.java
│       │       │   ├── ProductStepDefinitions.java
│       │       │   └── Hooks.java     # @Before/@After hooks
│       │       ├── steps/             # Reusable action methods
│       │       │   ├── UserSteps.java
│       │       │   └── ProductSteps.java
│       │       ├── models/            # POJOs for API requests/responses
│       │       │   ├── request/
│       │       │   │   ├── CreateUserRequest.java
│       │       │   │   └── UpdateProductRequest.java
│       │       │   └── response/
│       │       │       ├── UserResponse.java
│       │       │       └── ProductResponse.java
│       │       ├── utils/             # Utilities and helpers
│       │       │   ├── ApiClient.java
│       │       │   ├── AuthUtils.java
│       │       │   ├── JsonUtils.java
│       │       │   └── ConfigReader.java
│       │       ├── builders/          # Test data builders (optional)
│       │       │   ├── UserDataBuilder.java
│       │       │   └── ProductDataBuilder.java
│       │       └── runners/           # Test runners
│       │           ├── TestRunner.java
│       │           └── FailedTestRunner.java
│       └── resources/
│           ├── features/              # Cucumber .feature files
│           │   ├── user_management.feature
│           │   └── product_catalog.feature
│           ├── testdata/              # Test data files
│           │   ├── users/
│           │   │   ├── valid_user.json
│           │   │   └── invalid_user.json
│           │   └── products/
│           │       └── product_list.json
│           ├── serenity.properties    # Serenity configuration
│           └── serenity.conf          # Alternative Serenity config (HOCON format)
├── pom.xml                            # Maven dependencies
├── build.gradle                       # Gradle dependencies (alternative)
└── target/                            # Build output (Maven)
    └── site/serenity/                # Serenity test reports
```

### File Organization Principles

**1. Feature Files (.feature)**
- Organize by business domain/feature area
- One feature file per major functional area
- Group related scenarios together
- Use descriptive file names matching business terminology

**2. Step Definitions (stepdefinitions/)**
- One step definition class per feature file (common pattern)
- OR organize by step type (GivenSteps, WhenSteps, ThenSteps) if shared across features
- Keep step definitions thin - delegate to Steps/Actions layer
- Use dependency injection (Cucumber-Picocontainer or Cucumber-Spring)

**3. Steps/Actions (steps/)**
- One Steps class per API resource or domain
- Example: `UserSteps.java`, `ProductSteps.java`, `OrderSteps.java`
- Encapsulate all API interactions for that resource
- Make methods reusable across multiple scenarios

**4. Models (models/)**
- Organize by request/response or by feature
- Use nested packages for complex domains
- Follow naming conventions: `[Entity]Request.java`, `[Entity]Response.java`
- Include proper Jackson/Gson annotations for serialization

**5. Utilities (utils/)**
- `ApiClient.java` - Base HTTP client with common configuration
- `AuthUtils.java` - Authentication token management
- `ConfigReader.java` - Read properties from config files
- `JsonUtils.java` - JSON parsing and manipulation helpers
- Keep utilities stateless and static when possible

### Naming Conventions

**Feature Files:**
- `snake_case.feature` (Cucumber convention)
- Examples: `user_management.feature`, `product_catalog.feature`

**Java Classes:**
- `PascalCase.java` (Java standard)
- Step Definitions: `[Feature]StepDefinitions.java`
- Steps: `[Resource]Steps.java`
- Models: `[Entity].java`, `[Entity]Request.java`, `[Entity]Response.java`
- Utils: `[Purpose]Utils.java` or `[Purpose]Client.java`

**Packages:**
- `lowercase` (Java standard)
- Examples: `stepdefinitions`, `steps`, `models`, `utils`, `builders`

### Dependencies to Add (Example)

**Maven (pom.xml):**
```xml
<dependencies>
    <!-- Serenity BDD with Cucumber -->
    <dependency>
        <groupId>net.serenity-bdd</groupId>
        <artifactId>serenity-cucumber</artifactId>
        <version>4.0.0</version>
        <scope>test</scope>
    </dependency>

    <!-- RestAssured for API testing -->
    <dependency>
        <groupId>io.rest-assured</groupId>
        <artifactId>rest-assured</artifactId>
        <version>5.3.0</version>
        <scope>test</scope>
    </dependency>

    <!-- AssertJ for fluent assertions -->
    <dependency>
        <groupId>org.assertj</groupId>
        <artifactId>assertj-core</artifactId>
        <version>3.24.2</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

**Gradle (build.gradle):**
```groovy
dependencies {
    testImplementation 'net.serenity-bdd:serenity-cucumber:4.0.0'
    testImplementation 'io.rest-assured:rest-assured:5.3.0'
    testImplementation 'org.assertj:assertj-core:3.24.2'
}
```

---

## 13. Potential Issues & Testing Strategy

### Error Scenarios to Analyze
- [ ] **Error Scenario 1:** [What could go wrong when...]
  - **Code Review Focus:** [Which files/methods to examine for this issue]
  - **Potential Fix:** [If issue found, suggest this approach]
- [ ] **Error Scenario 2:** [Another potential failure point]
  - **Code Review Focus:** [Where to look for gaps in error handling]
  - **Potential Fix:** [Recommended solution if needed]

### Edge Cases to Consider
- [ ] **Edge Case 1:** [Unusual scenario that could break functionality]
  - **Analysis Approach:** [How to identify if this is handled in the tests]
  - **Recommendation:** [What should be implemented if missing]
- [ ] **Edge Case 2:** [Another boundary condition]
  - **Analysis Approach:** [Where to check for this scenario]
  - **Recommendation:** [How to address if found]

### API Testing Considerations
- [ ] **Authentication:** Are authentication scenarios properly tested (valid/invalid/expired tokens)?
- [ ] **Error Responses:** Are all expected error responses validated (4xx, 5xx status codes)?
- [ ] **Data Validation:** Are response schemas and data types validated?
- [ ] **Performance:** Are response time assertions included where needed?
- [ ] **Test Isolation:** Can tests run independently without affecting each other?
- [ ] **Test Data Cleanup:** Is test data properly cleaned up after execution?

### AI Agent Analysis Approach
**Focus:** Review existing test code to identify potential failure points and coverage gaps. When issues are found, provide specific recommendations with file paths and code examples. This is test gap identification and improvement suggestions - not writing test procedures.

**Priority Order:**
1. **Critical:** Authentication and authorization testing
2. **Important:** Error scenario coverage and edge cases
3. **Nice-to-have:** Performance assertions and enhanced reporting

---

## 14. Test Execution & Configuration

### Test Execution Commands

**Run all tests:**
```bash
# Maven
mvn clean test

# Gradle
gradle clean test
```

**Run specific feature:**
```bash
# Maven
mvn clean test -Dcucumber.filter.tags="@user_management"

# Gradle
gradle clean test --tests "*UserManagement*"
```

**Run failed tests only:**
```bash
# Maven (using rerun plugin)
mvn clean test -Dcucumber.features=@target/rerun.txt

# Gradle
gradle clean test --rerun-tasks
```

**Generate Serenity reports:**
```bash
# Maven
mvn clean verify

# Gradle
gradle clean test aggregate
```

### Environment Configuration

**serenity.properties:**
```properties
# Environment settings
environment=test
webdriver.driver=none
serenity.take.screenshots=DISABLED

# API base URL
api.base.url=https://api.test.example.com

# Test execution
serenity.test.root=[base.package]
serenity.dry.run=false
```

**Environment Variables:**
```bash
# Add these to CI/CD or local environment
API_BASE_URL=https://api.test.example.com
API_KEY=your_api_key_here
AUTH_TOKEN=your_auth_token_here
```

### CI/CD Integration

**Jenkins Pipeline Example:**
```groovy
stage('Run API Tests') {
    steps {
        sh 'mvn clean verify -Denvironment=test'
    }
    post {
        always {
            publishHTML(target: [
                reportDir: 'target/site/serenity',
                reportFiles: 'index.html',
                reportName: 'Serenity Report'
            ])
        }
    }
}
```

---

## 15. AI Agent Instructions

### Default Workflow - STRATEGIC ANALYSIS FIRST
🎯 **STANDARD OPERATING PROCEDURE:**
When a user requests any new test scenario, improvement, or significant change, your **DEFAULT BEHAVIOR** should be:

1. **EVALUATE STRATEGIC NEED** - Determine if multiple solutions exist or if it's straightforward
2. **STRATEGIC ANALYSIS** (if needed) - Present solution options with pros/cons and get user direction
3. **CREATE A TASK DOCUMENT** in `ai_docs/` using this template
4. **GET USER APPROVAL** of the task document
5. **IMPLEMENT THE TESTS** only after approval

**DO NOT:** Present implementation plans in chat without creating a proper task document first.
**DO:** Always create comprehensive task documentation that can be referenced later.
**DO:** Present strategic options when multiple viable approaches exist.

### Communication Preferences
- [ ] Ask for clarification if test requirements are unclear
- [ ] Provide regular progress updates
- [ ] Flag any blockers or concerns immediately
- [ ] Suggest improvements or alternative test approaches when appropriate

### Implementation Approach - CRITICAL WORKFLOW
🚨 **MANDATORY: Always follow this exact sequence:**

1. **EVALUATE STRATEGIC NEED FIRST (Required)**
   - [ ] **Assess complexity** - Is this a straightforward test addition or are there multiple viable approaches?
   - [ ] **Review the criteria** in "Strategic Analysis & Solution Options" section
   - [ ] **Decision point**: Skip to step 3 if straightforward, proceed to step 2 if strategic analysis needed

2. **STRATEGIC ANALYSIS SECOND (If needed)**
   - [ ] **Present solution options** with pros/cons analysis for each approach
   - [ ] **Include implementation complexity, time estimates, and risk levels** for each option
   - [ ] **Provide clear recommendation** with rationale
   - [ ] **Wait for user decision** on preferred approach before proceeding
   - [ ] **Document approved strategy** for inclusion in task document

3. **CREATE TASK DOCUMENT THIRD (Required)**
   - [ ] **Create a new task document** in the `ai_docs/tasks/` directory using this template
   - [ ] **Fill out all sections** with specific details for the requested test scenarios
   - [ ] **Include strategic analysis** (if conducted) in the appropriate section
   - [ ] **🔢 FIND LATEST TASK NUMBER**: Use `list_dir` to examine ai_docs/tasks/ directory and find the highest numbered task file
   - [ ] **Name the file** using the pattern `XXX_feature_name.md` (where XXX is the next incremental number)
   - [ ] **🚨 MANDATORY: POPULATE CODE CHANGES OVERVIEW**: Always read existing files and show before/after code snippets in section 9
   - [ ] **Present a summary** of the task document to the user for review

4. **PRESENT IMPLEMENTATION OPTIONS (Required)**
   - [ ] **After incorporating user feedback**, present these 3 exact options:

   **👤 IMPLEMENTATION OPTIONS:**

   **A) Preview High-Level Code Changes**
   Would you like me to show you detailed code snippets and specific changes before implementing? I'll walk through exactly what files will be modified and show before/after code examples.

   **B) Proceed with Implementation**
   Ready to begin implementation? Say "Approved" or "Go ahead" and I'll start implementing phase by phase.

   **C) Provide More Feedback**
   Have questions or want to modify the approach? I can adjust the plan based on additional requirements or concerns.

   - [ ] **Wait for explicit user choice** (A, B, or C) - never assume or default
   - [ ] **If A chosen**: Provide detailed code snippets showing exact changes planned
   - [ ] **If B chosen**: Begin phase-by-phase implementation immediately
   - [ ] **If C chosen**: Address feedback and re-present options

5. **IMPLEMENT PHASE-BY-PHASE (Only after Option B approval)**

   **MANDATORY PHASE WORKFLOW:**

   For each phase, follow this exact pattern:

   a. **Execute Phase Completely** - Complete all tasks in current phase
   b. **Update Task Document** - Mark all completed tasks as [x] with timestamps
   c. **Provide Specific Phase Recap** using this format:

   ```
   ✅ **Phase [X] Complete - [Phase Name]**
   - Created [X] files with [Y] total line count
   - Key changes: [specific file paths and what was created/modified]
   - Files created/updated:
     • file1.java (+50 lines): [brief description]
     • file2.feature (+12 lines): [brief description]
   - Commands executed: [list any commands run]
   - Compilation status: ✅ All files compile / ❌ [specific issues found]

   **🔄 Next: Phase [X+1] - [Phase Name]**
   - Will create: [specific files]
   - Changes planned: [brief description]
   - Estimated scope: [number of files/changes expected]

   **Say "proceed" to continue to Phase [X+1]**
   ```

   d. **Wait for "proceed"** before starting next phase
   e. **Repeat for each phase** until all implementation complete
   f. **🚨 CRITICAL:** After final implementation phase, you MUST proceed to Phase 8 (Comprehensive Code Review) before any test execution

   **🚨 PHASE-SPECIFIC REQUIREMENTS:**
   - [ ] **Real-time task completion tracking** - Update task document immediately after each subtask
   - [ ] **Mark checkboxes as [x]** with completion timestamps
   - [ ] **Add specific completion notes** (file paths, line counts, key changes)
   - [ ] **Run compilation check on each modified file** during the phase (static analysis only - no test execution)
   - [ ] **🚨 MANDATORY WORKFLOW SEQUENCE:** After implementation phases, follow this exact order:
     - [ ] **Phase 7 Complete** → Present "Implementation Complete!" message (section 15, step 7)
     - [ ] **Wait for user approval** → Execute comprehensive code review (section 15, step 8)
     - [ ] **Code review complete** → ONLY THEN request user test execution
     - [ ] **NEVER skip comprehensive code review** - Phase 7 basic validation ≠ comprehensive review
   - [ ] **NEVER plan test execution as AI task** - always mark as "👤 USER TESTING" and wait for user confirmation

6. **VERIFY JAVA CODE QUALITY (For any Java changes)**
   - [ ] **Check compilation** - Ensure all Java files compile without errors
   - [ ] **Verify imports** - No unused imports, all dependencies available
   - [ ] **Check naming conventions** - Follow Java naming standards
   - [ ] **Review Gherkin syntax** - Ensure feature files follow proper Gherkin format
   - [ ] **Validate RestAssured usage** - Proper use of given/when/then pattern

7. **FINAL CODE REVIEW RECOMMENDATION (Mandatory after all phases)**
   - [ ] **Present this exact message** to user after all implementation complete:

   ```
   🎉 **Implementation Complete!**

   All phases have been implemented successfully. I've made changes to [X] files across [Y] phases.

   **📋 I recommend doing a thorough code review of all changes to ensure:**
   - No mistakes were introduced
   - All test scenarios are properly covered
   - Code follows project standards
   - Everything will work as expected when tests are executed

   **Would you like me to proceed with the comprehensive code review?**

   This review will include:
   - Verifying all changes match the intended goals
   - Running compilation and static analysis on all modified files
   - Checking for any integration issues
   - Confirming all requirements were met
   ```

   - [ ] **Wait for user approval** of code review
   - [ ] **If approved**: Execute comprehensive code review process below

8. **COMPREHENSIVE CODE REVIEW PROCESS (If user approves)**
   - [ ] **Read all modified files** and verify changes match task requirements exactly
   - [ ] **Run compilation check** on all Java files: `mvn clean compile test-compile`
   - [ ] **Run static analysis** if configured: `mvn checkstyle:check` or `mvn spotbugs:check`
   - [ ] **Verify feature file syntax** - Ensure Gherkin scenarios are properly formatted
   - [ ] **Check model/POJO structure** - Verify proper annotations and field types
   - [ ] **Review step definitions** - Ensure proper Cucumber annotations and parameter handling
   - [ ] **Provide detailed review summary** using this format:

   ```
   ✅ **Code Review Complete**

   **Files Reviewed:** [list all modified files with line counts]
   **Compilation Status:** ✅ All files compile / ❌ [specific issues found]
   **Static Analysis:** ✅ No issues / ❌ [specific issues found]
   **Gherkin Syntax:** ✅ All scenarios valid / ❌ [specific issues]
   **Requirements Met:** ✅ All success criteria achieved / ❌ [missing requirements]

   **Summary:** [brief summary of what was accomplished and verified]
   **Confidence Level:** High/Medium/Low - [specific reasoning]
   **Recommendations:** [any follow-up suggestions or improvements]
   ```

### What Constitutes "Explicit User Approval"

#### For Strategic Analysis
**✅ STRATEGIC APPROVAL RESPONSES (Proceed to task document creation):**
- "Option 1 looks good"
- "Go with your recommendation"
- "I prefer Option 2"
- "Proceed with [specific option]"
- "That approach works"
- "Yes, use that strategy"

#### For Implementation Options (A/B/C Choice)
**✅ OPTION A RESPONSES (Show detailed code previews):**
- "A" or "Option A"
- "Preview the changes"
- "Show me the code changes"
- "Let me see what will be created"
- "Walk me through the changes"

**✅ OPTION B RESPONSES (Start implementation immediately):**
- "B" or "Option B"
- "Proceed" or "Go ahead"
- "Approved" or "Start implementation"
- "Begin" or "Execute the plan"
- "Looks good, implement it"

**✅ OPTION C RESPONSES (Provide more feedback):**
- "C" or "Option C"
- "I have questions about..."
- "Can you modify..."
- "What about..." or "How will you handle..."
- "I'd like to change..."
- "Wait, let me think about..."

#### For Phase Continuation
**✅ PHASE CONTINUATION RESPONSES:**
- "proceed"
- "continue"
- "next phase"
- "go ahead"
- "looks good"

**❓ CLARIFICATION NEEDED (Do NOT continue to next phase):**
- Questions about the completed phase
- Requests for changes to completed work
- Concerns about the implementation
- No response or silence

#### For Final Code Review
**✅ CODE REVIEW APPROVAL:**
- "proceed"
- "yes, review the code"
- "go ahead with review"
- "approved"

🛑 **NEVER start coding without explicit A/B/C choice from user!**
🛑 **NEVER continue to next phase without "proceed" confirmation!**
🛑 **NEVER skip comprehensive code review after implementation phases!**
🛑 **NEVER proceed to test execution without completing code review first!**
🛑 **NEVER run test execution commands (`mvn test`, `mvn verify`) - user already has tests running manually!**

### 🚨 CRITICAL: Command Execution Rules
**NEVER run test execution commands - the user will execute tests manually!**

**❌ FORBIDDEN COMMANDS (Will interfere with user's test execution):**
- `mvn test` / `mvn clean test` - User runs tests manually
- `mvn verify` / `mvn clean verify` - User runs verification manually
- `gradle test` / `gradle clean test` - User runs tests manually
- Any command that executes Cucumber scenarios
- Any command that runs Serenity reports
- Long-running test suites that consume resources

**✅ ALLOWED COMMANDS (Safe static analysis only):**
- `mvn clean compile test-compile` - Compilation check only, no test execution
- `mvn checkstyle:check` - Static code analysis
- `mvn spotbugs:check` / `mvn pmd:check` - Bug detection tools
- File reading/analysis tools
- Viewing generated files (but not executing tests)

**🎯 VALIDATION STRATEGY:**
- Use compilation to verify Java syntax
- Use static analysis for code quality
- Read files to verify test structure and logic
- Let the user handle all test execution manually

### Code Quality Standards
- [ ] Follow Java best practices and conventions
- [ ] Use proper exception handling in test code
- [ ] **🚨 MANDATORY: Write Professional Comments - Never Historical Comments**
  - [ ] **❌ NEVER write change history**: "Fixed this", "Removed step", "Updated to use new model"
  - [ ] **❌ NEVER write migration artifacts**: "Moved from X", "Previously was Y"
  - [ ] **✅ ALWAYS explain test logic**: "Validate user creation with admin role", "Verify error response for invalid token"
  - [ ] **✅ Write for future test maintainers** - explain what/why the test validates, not what you changed
  - [ ] **Remove unused test code completely** - don't leave comments explaining what was removed
- [ ] **🚨 MANDATORY: Use early returns to keep code clean and readable**
  - [ ] **Prioritize early returns** over nested if-else statements
  - [ ] **Validate inputs early** and return/throw immediately for invalid cases
  - [ ] **Handle error conditions first** before proceeding with main logic
  - [ ] **Exit early for edge cases** to reduce nesting and improve readability
  - [ ] **Example pattern**: `if (invalid) throw new Exception("reason"); // main logic here`
- [ ] **🚨 MANDATORY: Use proper Gherkin syntax in feature files**
  - [ ] **Use Given/When/Then structure** - never mix step types
  - [ ] **Write business-readable scenarios** - avoid technical jargon
  - [ ] **Keep steps concise** - one action per step
  - [ ] **Use Background for common setup** - avoid repetition
  - [ ] **Use Scenario Outline for data-driven tests** - parameterize test data
- [ ] **🚨 MANDATORY: NO FALLBACK BEHAVIOR - Always throw errors instead**
  - [ ] **Never handle "legacy formats"** - expect the current format or fail fast
  - [ ] **No "try other common fields"** fallback logic - if expected field missing, throw error
  - [ ] **Fail fast and clearly** - don't mask issues with fallback behavior
  - [ ] **Single expected response format** - based on current API contract
  - [ ] **Throw descriptive errors** - explain exactly what format was expected vs received
  - [ ] **Example**: `if (!expectedFormat) throw new AssertionError("Expected X format, got Y");`
- [ ] **Ensure test independence** - tests should not depend on execution order
- [ ] **Use proper assertions** - AssertJ fluent assertions preferred
- [ ] **Follow consistent naming** - descriptive method and variable names
- [ ] **Keep step definitions thin** - delegate logic to Steps/Actions layer
- [ ] **🚨 MANDATORY: Clean up test artifacts**
  - [ ] **Never leave placeholder comments** like "// No setup needed" or "// Removed for simplicity"
  - [ ] **Delete empty test methods** completely rather than leaving commented stubs
  - [ ] **Remove unused imports** after deletions
  - [ ] **Clean up unused models/POJOs** that no longer serve a purpose
  - [ ] **Remove dead test scenarios** rather than commenting them out
  - [ ] **If removing test code, remove it completely** - don't leave explanatory comments

### Architecture Compliance
- [ ] **✅ VERIFY: Used correct test layer pattern**
  - [ ] Feature files → Business-readable Gherkin scenarios
  - [ ] Step Definitions → Thin glue code mapping Gherkin to Java
  - [ ] Steps/Actions → Reusable API interaction methods
  - [ ] Models → POJOs for request/response serialization
  - [ ] Utilities → HTTP client configuration and helpers
- [ ] **🚨 VERIFY: Proper separation of concerns**
  - [ ] Step definitions don't contain business logic (delegate to Steps/Actions)
  - [ ] Steps/Actions layer doesn't contain Gherkin step mappings
  - [ ] Models are simple POJOs without business logic
  - [ ] Utilities are stateless and reusable
- [ ] **🚨 VERIFY: Proper Cucumber annotations**
  - [ ] @Given for setup steps
  - [ ] @When for actions/operations
  - [ ] @Then for assertions/validations
  - [ ] @And/@But for additional steps (sparingly)
- [ ] **❌ AVOID: Common anti-patterns**
  - [ ] Don't put API calls directly in step definitions
  - [ ] Don't hardcode test data in step definitions
  - [ ] Don't create overly complex Gherkin scenarios
  - [ ] Don't mix technical details in business-readable scenarios

---

## 16. Notes & Additional Context

### Research Links
- [Link to API documentation]
- [Reference test examples]
- [Serenity BDD documentation: https://serenity-bdd.github.io/]
- [Cucumber documentation: https://cucumber.io/docs/cucumber/]
- [RestAssured documentation: https://rest-assured.io/]

### Common Pitfalls to Avoid

**❌ NEVER DO:**
- Put API interaction code directly in step definitions
- Hardcode URLs or credentials in test code
- Create overly technical Gherkin scenarios
- Mix test data setup with test execution logic
- Use Thread.sleep() for synchronization (use proper waits)

**✅ ALWAYS DO:**
- Keep step definitions thin and focused on mapping only
- Use configuration files for environment-specific values
- Write business-readable Gherkin scenarios
- Separate test data from test logic
- Use proper assertions with clear failure messages
- Implement proper error handling in API calls
- Use dependency injection for sharing state between steps

---

## 17. Second-Order Consequences & Impact Analysis

### AI Analysis Instructions
🔍 **MANDATORY: The AI agent must analyze this section thoroughly before implementation**

Before implementing any test changes, the AI must systematically analyze potential second-order consequences and alert the user to any significant impacts. This analysis should identify ripple effects that might not be immediately obvious but could cause problems later.

### Impact Assessment Framework

#### 1. **Test Suite Impact**
- [ ] **Existing Tests:** Will new tests conflict with or duplicate existing test scenarios?
- [ ] **Test Execution Time:** Will new tests significantly increase suite execution time?
- [ ] **Test Dependencies:** Are there dependencies between new and existing tests?
- [ ] **Test Data:** Will new tests conflict with existing test data or cleanup?

#### 2. **Test Infrastructure Impact**
- [ ] **New Dependencies:** Are new libraries/dependencies required? Do they conflict with existing versions?
- [ ] **Configuration Changes:** Do new tests require changes to serenity.properties or other configs?
- [ ] **CI/CD Pipeline:** Will new tests require changes to build scripts or pipeline configuration?
- [ ] **Environment Setup:** Do new tests require additional environment variables or infrastructure?

#### 3. **Maintenance Burden**
- [ ] **Code Duplication:** Are we duplicating code that could be reused?
- [ ] **Test Complexity:** Are new tests introducing unnecessary complexity?
- [ ] **Documentation:** What documentation updates are needed for test maintainers?
- [ ] **Learning Curve:** Will new patterns require team training?

#### 4. **API Contract Changes**
- [ ] **Breaking Changes:** Do tests assume API contracts that might change?
- [ ] **Version Compatibility:** Are tests compatible with multiple API versions?
- [ ] **Deprecation Handling:** How will tests handle deprecated endpoints?
- [ ] **Error Responses:** Are all error response formats properly handled?

#### 5. **Test Data Management**
- [ ] **Data Isolation:** Can tests run in parallel without data conflicts?
- [ ] **Data Cleanup:** Is cleanup strategy comprehensive and reliable?
- [ ] **Data Generation:** Are test data generators reliable and consistent?
- [ ] **Data Privacy:** Are we handling sensitive test data appropriately?

#### 6. **Team Collaboration**
- [ ] **Code Style:** Do new tests follow team conventions?
- [ ] **Review Process:** What review is needed from other team members?
- [ ] **Knowledge Sharing:** How will team learn about new test patterns?
- [ ] **Onboarding:** Will new patterns complicate onboarding for new team members?

### Critical Issues Identification

#### 🚨 **RED FLAGS - Alert User Immediately**
These issues must be brought to the user's attention before implementation:
- [ ] **Flaky Tests:** Tests that might produce inconsistent results
- [ ] **Performance Impact:** Tests that will significantly slow down suite execution
- [ ] **Breaking Changes:** Tests that assume API contracts that are changing
- [ ] **Data Conflicts:** Risk of test data conflicts in shared environments
- [ ] **Infrastructure Requirements:** New tests requiring significant infrastructure changes

#### ⚠️ **YELLOW FLAGS - Discuss with User**
These issues should be discussed but may not block implementation:
- [ ] **Increased Complexity:** Test patterns that are harder to understand/maintain
- [ ] **New Dependencies:** Additional libraries that increase build size or complexity
- [ ] **Duplicate Coverage:** Tests that overlap significantly with existing scenarios
- [ ] **Maintenance Overhead:** Test patterns that will require ongoing maintenance attention

### Mitigation Strategies

#### Test Execution
- [ ] **Isolation Strategy:** Use unique test data per execution to prevent conflicts
- [ ] **Parallel Execution:** Ensure tests can run in parallel without interference
- [ ] **Timeout Configuration:** Set appropriate timeouts to prevent hanging tests
- [ ] **Retry Strategy:** Implement retry logic for transient failures (if appropriate)

#### Test Data
- [ ] **Data Cleanup:** Implement comprehensive cleanup in @After hooks
- [ ] **Data Factories:** Use builders/factories for consistent test data creation
- [ ] **Environment Separation:** Use separate test data for different environments
- [ ] **Data Reset:** Document process for resetting test environment

#### Maintenance
- [ ] **Code Reviews:** Ensure thorough review process for test changes
- [ ] **Documentation:** Update team documentation with new patterns
- [ ] **Refactoring:** Plan for regular test suite refactoring
- [ ] **Monitoring:** Track test execution metrics over time

### AI Agent Checklist

Before presenting the task document to the user, the AI agent must:
- [ ] **Complete Impact Analysis:** Fill out all sections of the impact assessment
- [ ] **Identify Critical Issues:** Flag any red or yellow flag items
- [ ] **Propose Mitigation:** Suggest specific mitigation strategies for identified risks
- [ ] **Alert User:** Clearly communicate any significant second-order impacts
- [ ] **Recommend Alternatives:** If high-risk impacts are identified, suggest alternative approaches

### Example Analysis Template

```
🔍 **SECOND-ORDER IMPACT ANALYSIS:**

**Test Suite Impact:**
- New tests will add 3 scenarios covering error cases not currently tested
- Execution time will increase by ~15 seconds (acceptable)
- No conflicts with existing test scenarios

**Infrastructure Impact:**
- No new dependencies required (using existing RestAssured setup)
- Minor update to serenity.properties to add new tag group
- No CI/CD pipeline changes needed

**Maintenance Considerations:**
- Introducing new Step Definitions class for product management
- Reusing existing ApiClient utility (good for consistency)
- Documentation update needed for new test data JSON files

**Data Management:**
- Tests use unique product IDs per execution (no conflicts)
- Cleanup handled in @After hook (reliable)
- Test data stored in testdata/products/ directory

**🚨 USER ATTENTION REQUIRED:**
The new tests introduce a data builder pattern not currently used in the project. This is a better approach but will require team discussion to ensure consistency across all tests.
```
