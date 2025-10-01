---
description: Create a comprehensive test automation strategy document defining framework architecture, design patterns, and implementation approach.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

You are creating a test automation strategy document that defines the technical implementation approach for the test automation framework. This runs AFTER `/gherkin-scenarios`.

## Execution Flow (main)

```
1. Run `.specify/scripts/powershell/check-test-prerequisites.ps1 -Json -RequireGherkin`
   → Parse STORY_DIR, GHERKIN_DIR, STRATEGY_FILE
   → If gherkin/ directory missing: ERROR "Run /gherkin-scenarios first"
2. Load test plan and Gherkin scenarios
   → Extract test types (UI, API, Integration)
   → Extract complexity requirements
3. Load test automation strategy template
   → From `.specify/templates/test-automation-strategy-template.md`
4. Define framework architecture:
   → Layer structure (Steps, Tasks, Pages, API Clients, Utils)
   → Design patterns (Page Object, Screenplay, etc.)
   → Project structure
5. Define technical stack:
   → Programming language (Java)
   → Test framework (JUnit/TestNG)
   → BDD framework (Cucumber)
   → Automation framework (Serenity)
   → Additional libraries (RestAssured, Selenium, etc.)
6. Define implementation approach:
   → Step definitions organization
   → Page Object Model structure
   → API client design
   → Test data management
   → Configuration management
7. Define reporting and CI/CD integration:
   → Serenity reporting configuration
   → Jenkins/GitHub Actions integration
   → Test result publishing
8. Define coding standards and best practices
9. Generate test automation strategy document
   → Store in specs/[STORY-KEY]/test-automation-strategy.md
10. Return: SUCCESS (ready for /implement-tests)
```

## Test Automation Strategy Structure

Generate `test-automation-strategy.md` with:

```markdown
# Test Automation Strategy: [STORY-KEY]

**Story Key**: [STORY-KEY]
**Version**: 1.0
**Created**: [DATE]
**Framework**: Serenity Cucumber BDD (Java)
**Status**: Draft

## 1. Executive Summary

This document defines the test automation strategy for [STORY-KEY]. The strategy outlines the technical approach, framework architecture, design patterns, and implementation guidelines for automating the test scenarios defined in the test plan.

**Key Highlights:**
- Framework: Serenity Cucumber BDD with Java
- Test Types: [UI/API/Integration]
- Design Pattern: [Page Object Model / Screenplay Pattern]
- CI/CD Integration: [Jenkins / GitHub Actions]
- Reporting: Serenity Living Documentation

## 2. Technology Stack

### 2.1 Core Technologies
| Technology | Version | Purpose |
|------------|---------|---------|
| Java | 11/17 | Programming language |
| Maven/Gradle | Latest | Build and dependency management |
| JUnit 5 / TestNG | Latest | Test execution framework |
| Cucumber | 7.x | BDD framework |
| Serenity BDD | 3.x | Test automation framework & reporting |
| Selenium WebDriver | 4.x | Browser automation (for UI tests) |
| RestAssured | 5.x | API testing (for API tests) |

### 2.2 Additional Libraries
- **Assertions**: AssertJ / Hamcrest
- **Test Data**: Faker, DataFactory
- **JSON Processing**: Jackson, Gson
- **Database**: JDBC, Flyway (if needed)
- **Logging**: SLF4J, Logback
- **Configuration**: TypeSafe Config, Properties files

### 2.3 Development Tools
- **IDE**: IntelliJ IDEA / Eclipse
- **Version Control**: Git
- **CI/CD**: Jenkins / GitHub Actions
- **Code Quality**: SonarQube, Checkstyle
- **Test Management**: [JIRA Xray / TestRail / Zephyr]

## 3. Framework Architecture

### 3.1 Project Structure

```
src/test/java/
├── [package]/
│   ├── features/              # Cucumber feature files
│   │   ├── ui/
│   │   │   └── user_management.feature
│   │   └── api/
│   │       └── user_api.feature
│   ├── stepdefinitions/       # Cucumber step definitions
│   │   ├── ui/
│   │   │   └── UserManagementSteps.java
│   │   └── api/
│   │       └── UserApiSteps.java
│   ├── pages/                 # Page Object Model (UI tests)
│   │   ├── LoginPage.java
│   │   ├── UserProfilePage.java
│   │   └── BasePage.java
│   ├── api/                   # API clients (API tests)
│   │   ├── UserApiClient.java
│   │   └── BaseApiClient.java
│   ├── models/                # Data models / POJOs
│   │   ├── User.java
│   │   └── Profile.java
│   ├── tasks/                 # Business logic tasks (Screenplay)
│   │   ├── Login.java
│   │   └── CreateUser.java
│   ├── questions/             # Assertions/Verifications (Screenplay)
│   │   ├── ProfileDetails.java
│   │   └── UserStatus.java
│   ├── utils/                 # Utility classes
│   │   ├── TestDataGenerator.java
│   │   ├── ConfigManager.java
│   │   ├── DatabaseHelper.java
│   │   └── DateUtils.java
│   ├── hooks/                 # Cucumber hooks
│   │   └── TestHooks.java
│   └── runners/               # Test runners
│       ├── UiTestRunner.java
│       ├── ApiTestRunner.java
│       └── RegressionTestRunner.java

src/test/resources/
├── features/                  # Alternative: Feature files in resources
├── serenity.conf              # Serenity configuration
├── application.properties     # Application config
└── testdata/                  # Test data files
    ├── users.json
    └── test_data.csv
```

### 3.2 Layer Architecture

```
┌─────────────────────────────────────────┐
│     Cucumber Feature Files (BDD)        │  ← Business-readable scenarios
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│     Step Definitions Layer              │  ← Glue between Gherkin and code
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│     Tasks / Business Logic Layer        │  ← High-level business operations
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│  Page Objects / API Clients Layer       │  ← Technical interactions
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│  Selenium WebDriver / RestAssured       │  ← Low-level automation
└─────────────────────────────────────────┘
```

## 4. Design Patterns

### 4.1 Page Object Model (for UI Tests)

**Purpose**: Encapsulate UI elements and interactions in reusable page classes.

**Structure**:
```java
@DefaultUrl("page://login")
public class LoginPage extends PageObject {

    @FindBy(id = "username")
    private WebElementFacade usernameField;

    @FindBy(id = "password")
    private WebElementFacade passwordField;

    @FindBy(css = "button[type='submit']")
    private WebElementFacade loginButton;

    public void enterUsername(String username) {
        usernameField.type(username);
    }

    public void enterPassword(String password) {
        passwordField.type(password);
    }

    public void clickLogin() {
        loginButton.click();
    }

    public boolean isLoginSuccessful() {
        return !isElementVisible(By.cssSelector(".error-message"));
    }
}
```

### 4.2 Screenplay Pattern (Optional Advanced Pattern)

**Purpose**: Model tests as actors performing tasks and asking questions.

**Structure**:
```java
// Actor
Actor user = Actor.named("Regular User");

// Task
public class Login implements Task {
    private final String username;
    private final String password;

    public static Login as(String username, String password) {
        return new Login(username, password);
    }

    @Override
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(
            Enter.theValue(username).into(LoginPage.USERNAME_FIELD),
            Enter.theValue(password).into(LoginPage.PASSWORD_FIELD),
            Click.on(LoginPage.LOGIN_BUTTON)
        );
    }
}

// Question
public class ProfileDetails implements Question<Boolean> {
    @Override
    public Boolean answeredBy(Actor actor) {
        return UserProfilePage.PROFILE_NAME.resolveFor(actor).isDisplayed();
    }
}

// Usage in step definition
user.attemptsTo(Login.as("user@test.com", "password"));
user.should(seeThat(ProfileDetails.displayed(), is(true)));
```

### 4.3 API Client Pattern

**Purpose**: Encapsulate API interactions in dedicated client classes.

**Structure**:
```java
public class UserApiClient extends BaseApiClient {

    private static final String BASE_PATH = "/api/users";

    public Response createUser(User user) {
        return SerenityRest
            .given()
                .contentType(ContentType.JSON)
                .body(user)
            .when()
                .post(BASE_PATH)
            .then()
                .extract().response();
    }

    public Response getUser(String userId) {
        return SerenityRest
            .given()
                .pathParam("id", userId)
            .when()
                .get(BASE_PATH + "/{id}")
            .then()
                .extract().response();
    }

    public void assertUserCreated(Response response, User expectedUser) {
        response.then()
            .statusCode(201)
            .body("email", equalTo(expectedUser.getEmail()))
            .body("name", equalTo(expectedUser.getName()));
    }
}
```

## 5. Implementation Guidelines

### 5.1 Step Definitions Best Practices

**Principles**:
- Keep step definitions thin - delegate to page objects or tasks
- Avoid business logic in step definitions
- Use dependency injection for page objects (Serenity handles this)
- Make step definitions reusable across scenarios

**Example**:
```java
public class UserManagementSteps {

    @Managed(driver = "chrome")
    private WebDriver driver;

    @Steps
    private LoginPage loginPage;

    @Steps
    private UserProfilePage userProfilePage;

    @Given("I am logged in as {string}")
    public void iAmLoggedInAs(String userType) {
        User user = TestUsers.get(userType);
        loginPage.open();
        loginPage.login(user.getUsername(), user.getPassword());
    }

    @When("I update my profile with name {string}")
    public void iUpdateMyProfileWithName(String name) {
        userProfilePage.updateName(name);
        userProfilePage.saveProfile();
    }

    @Then("I should see my profile updated successfully")
    public void iShouldSeeMyProfileUpdatedSuccessfully() {
        assertThat(userProfilePage.getSuccessMessage())
            .isEqualTo("Profile updated successfully");
    }
}
```

### 5.2 Test Data Management

**Approach**: Use multiple strategies based on test needs

**1. Hardcoded Test Data** (for simple scenarios):
```java
public class TestUsers {
    public static final User ADMIN = new User("admin@test.com", "Admin123!");
    public static final User REGULAR = new User("user@test.com", "User123!");
}
```

**2. Test Data Generators** (for dynamic data):
```java
public class TestDataGenerator {
    private static final Faker faker = new Faker();

    public static User generateRandomUser() {
        return new User(
            faker.internet().emailAddress(),
            faker.name().fullName(),
            faker.internet().password()
        );
    }
}
```

**3. Data Files** (for data-driven tests):
```json
// testdata/users.json
[
  {"username": "admin@test.com", "password": "Admin123!", "role": "admin"},
  {"username": "user@test.com", "password": "User123!", "role": "user"}
]
```

**4. Database Test Data** (for integration tests):
```java
public class DatabaseHelper {
    public User createUserInDatabase(User user) {
        // JDBC logic to insert test user
        return user;
    }

    public void cleanupTestData() {
        // Remove test data after tests
    }
}
```

### 5.3 Configuration Management

**serenity.conf**:
```hocon
webdriver {
  driver = chrome
  autodownload = true
}

serenity {
  project.name = "QA Test Automation"
  test.root = "features"
  take.screenshots = FOR_FAILURES
}

environments {
  dev {
    base.url = "https://dev.example.com"
    api.base.uri = "https://api.dev.example.com"
  }
  staging {
    base.url = "https://staging.example.com"
    api.base.uri = "https://api.staging.example.com"
  }
}
```

**ConfigManager.java**:
```java
public class ConfigManager {
    private static final Config config = ConfigFactory.load();

    public static String getBaseUrl() {
        return config.getString("environments." + getEnvironment() + ".base.url");
    }

    public static String getApiBaseUri() {
        return config.getString("environments." + getEnvironment() + ".api.base.uri");
    }

    private static String getEnvironment() {
        return System.getProperty("environment", "dev");
    }
}
```

### 5.4 Test Hooks

**TestHooks.java**:
```java
public class TestHooks {

    @Before
    public void setUp(Scenario scenario) {
        // Setup before each scenario
        // Initialize test data, configure browser, etc.
    }

    @After
    public void tearDown(Scenario scenario) {
        // Cleanup after each scenario
        // Close browser, cleanup test data, etc.
        if (scenario.isFailed()) {
            // Take screenshot, log error details
        }
    }

    @BeforeAll
    public static void globalSetup() {
        // One-time setup before all tests
    }

    @AfterAll
    public static void globalTeardown() {
        // One-time cleanup after all tests
    }
}
```

## 6. Test Execution

### 6.1 Test Runners

**ApiTestRunner.java**:
```java
@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
    features = "src/test/resources/features/api",
    glue = "stepdefinitions.api",
    tags = "@api and not @wip",
    plugin = {"pretty", "json:target/cucumber-reports/api.json"}
)
public class ApiTestRunner {
}
```

**UiTestRunner.java**:
```java
@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
    features = "src/test/resources/features/ui",
    glue = "stepdefinitions.ui",
    tags = "@ui and not @wip",
    plugin = {"pretty", "json:target/cucumber-reports/ui.json"}
)
public class UiTestRunner {
}
```

**SmokeTestRunner.java**:
```java
@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
    features = "src/test/resources/features",
    glue = "stepdefinitions",
    tags = "@smoke",
    plugin = {"pretty"}
)
public class SmokeTestRunner {
}
```

### 6.2 Maven/Gradle Execution

**Maven**:
```bash
# Run all tests
mvn clean verify

# Run specific tag
mvn clean verify -Dcucumber.filter.tags="@smoke"

# Run with specific environment
mvn clean verify -Denvironment=staging

# Run specific runner
mvn clean verify -Dtest=ApiTestRunner
```

**Gradle**:
```bash
# Run all tests
./gradlew clean test

# Run specific tag
./gradlew clean test -Dcucumber.filter.tags="@smoke"

# Run with specific environment
./gradlew clean test -Denvironment=staging
```

## 7. Reporting

### 7.1 Serenity Reports

Serenity generates comprehensive living documentation:
- Test execution results
- Screenshots for UI tests
- API request/response details
- Test coverage by feature
- Trend analysis

**Report Location**: `target/site/serenity/index.html`

**Report Features**:
- Filterable by tag, status, feature
- Drill-down into individual test results
- REST API documentation (for API tests)
- Evidence collection (screenshots, logs)

### 7.2 Cucumber JSON Reports

Generated for CI/CD integration:
- `target/cucumber-reports/*.json`
- Can be published to test management tools
- Used for trend analysis

## 8. CI/CD Integration

### 8.1 Jenkins Pipeline

```groovy
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Run Tests') {
            parallel {
                stage('API Tests') {
                    steps {
                        sh 'mvn verify -Dtest=ApiTestRunner -Denvironment=staging'
                    }
                }
                stage('UI Tests') {
                    steps {
                        sh 'mvn verify -Dtest=UiTestRunner -Denvironment=staging'
                    }
                }
            }
        }

        stage('Publish Reports') {
            steps {
                publishHTML([
                    reportDir: 'target/site/serenity',
                    reportFiles: 'index.html',
                    reportName: 'Serenity Report'
                ])
            }
        }
    }

    post {
        always {
            junit 'target/surefire-reports/*.xml'
            archiveArtifacts 'target/site/serenity/**'
        }
    }
}
```

### 8.2 GitHub Actions

```yaml
name: Test Automation

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - name: Set up JDK 11
        uses: actions/setup-java@v2
        with:
          java-version: '11'

      - name: Run API Tests
        run: mvn verify -Dtest=ApiTestRunner -Denvironment=staging

      - name: Run UI Tests
        run: mvn verify -Dtest=UiTestRunner -Denvironment=staging

      - name: Publish Serenity Report
        uses: actions/upload-artifact@v2
        with:
          name: serenity-report
          path: target/site/serenity
```

## 9. Coding Standards

### 9.1 Java Code Conventions
- Follow Java naming conventions
- Use meaningful variable and method names
- Keep methods small and focused (Single Responsibility)
- Add JavaDoc for public methods
- Use constants for magic strings/numbers

### 9.2 Test Code Standards
- One assertion per test (when possible)
- Tests should be independent
- Test names should be descriptive (Given_When_Then format)
- Avoid test interdependencies
- Clean up test data in @After hooks

### 9.3 Gherkin Standards
- Feature files should be business-readable
- Avoid technical implementation details in scenarios
- Use proper Given/When/Then structure
- Keep scenarios focused and atomic
- Use tags consistently

## 10. Best Practices

1. **Keep tests independent**: Each test should run in isolation
2. **Use explicit waits**: Avoid Thread.sleep(), use Serenity's wait mechanisms
3. **Implement proper error handling**: Catch and report meaningful errors
4. **Version control everything**: Code, test data, configuration
5. **Review test code**: Apply same code review standards as production code
6. **Maintain test documentation**: Keep README and strategy docs updated
7. **Monitor test execution time**: Optimize slow tests
8. **Regular test maintenance**: Remove obsolete tests, update for changes
9. **Use appropriate test data**: Don't use production data in tests
10. **Implement retry logic**: For flaky tests (with caution)

## 11. Maintenance and Evolution

### 11.1 Test Maintenance Schedule
- Weekly: Review failed tests, update for application changes
- Monthly: Refactor duplicated code, optimize slow tests
- Quarterly: Review and update framework dependencies
- Annually: Evaluate new tools and patterns

### 11.2 Framework Evolution
- Monitor Serenity/Cucumber updates
- Evaluate new design patterns (e.g., Screenplay)
- Assess emerging tools and libraries
- Gather team feedback for improvements

## 12. Next Steps

- [ ] Review and approve test automation strategy
- [ ] Set up project structure
- [ ] Configure Maven/Gradle build
- [ ] Set up CI/CD pipeline
- [ ] Implement step definitions for Gherkin scenarios
- [ ] Implement page objects/API clients
- [ ] Write and execute tests
- [ ] Generate and review Serenity reports

**Next Command**: `/implement-tests`

---

**Approved By**:
- QA Lead: _________________ Date: _______
- Engineering Manager: _____ Date: _______
```

## Validation Checklist

Before completing strategy:
- [ ] Technology stack clearly defined
- [ ] Project structure documented
- [ ] Design patterns specified
- [ ] Implementation guidelines comprehensive
- [ ] Test execution approach defined
- [ ] Reporting configured
- [ ] CI/CD integration planned
- [ ] Coding standards documented
- [ ] Best practices outlined

## Output

After strategy creation:
1. Report strategy document path
2. List key design patterns to use
3. List required libraries and versions
4. Summarize project structure
5. Suggest next command: `/implement-tests`

Context for test automation strategy: $ARGUMENTS
