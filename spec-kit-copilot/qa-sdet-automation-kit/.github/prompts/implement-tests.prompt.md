---
description: Implement test automation code based on Gherkin scenarios and test automation strategy.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

You are implementing the test automation code following the test automation strategy. This runs AFTER `/test-strategy`.

## Execution Flow (main)

```
1. Run `.specify/scripts/powershell/check-test-prerequisites.ps1 -Json -RequireStrategy`
   → Parse STORY_DIR, STRATEGY_FILE, GHERKIN_DIR, TEST_FRAMEWORK_DIR
   → If test-automation-strategy.md missing: ERROR "Run /test-strategy first"
2. Load test automation strategy
   → Extract framework architecture
   → Extract design patterns to use
   → Extract project structure
3. Load Gherkin scenarios
   → Parse all .feature files
   → Extract required step definitions
4. Verify test automation framework exists:
   → Check if src/test/java structure exists
   → If not: Prompt user to confirm test framework location
5. Create implementation plan:
   → List step definitions to implement
   → List page objects to create (for UI tests)
   → List API clients to create (for API tests)
   → List utility classes needed
   → Order by dependencies
6. Implement test automation code:
   → Create step definition classes
   → Implement page objects (if UI tests)
   → Implement API clients (if API tests)
   → Create test data classes
   → Create utility helpers
   → Configure test runners
7. Configure Serenity and Cucumber:
   → Create/update serenity.conf
   → Create/update application.properties
   → Configure test runners
8. Validate implementation:
   → Verify step definitions match Gherkin steps
   → Verify compilation succeeds
   → Verify test runners configured correctly
9. Generate implementation summary report
   → Store in specs/[STORY-KEY]/implementation-summary.md
10. Return: SUCCESS (ready to execute tests)
```

## Implementation Order

Follow this order to respect dependencies:

### Phase 1: Project Setup
1. Verify Maven/Gradle configuration (pom.xml or build.gradle)
2. Verify dependencies (Serenity, Cucumber, RestAssured, Selenium)
3. Create base package structure
4. Configure Serenity properties

### Phase 2: Foundation Classes
1. Create base page object class (BasePage.java)
2. Create base API client class (BaseApiClient.java)
3. Create utility classes (ConfigManager, TestDataGenerator)
4. Create model/POJO classes (User.java, Profile.java, etc.)
5. Create test hooks (TestHooks.java)

### Phase 3: Test Implementation
1. **For UI Tests**:
   - Create page object classes
   - Create step definition classes
   - Link step definitions to page objects

2. **For API Tests**:
   - Create API client classes
   - Create step definition classes
   - Link step definitions to API clients

3. **For Integration Tests**:
   - Create integration helper classes
   - Create step definition classes
   - Link step definitions to helpers

### Phase 4: Test Runners
1. Create test runner classes (ApiTestRunner, UiTestRunner, SmokeTestRunner)
2. Configure Cucumber options
3. Configure tags for different test suites

### Phase 5: Validation
1. Compile code (`mvn compile`)
2. Verify no missing step definitions
3. Run syntax validation
4. Generate step definitions report

## Code Generation Guidelines

### Step Definitions

**Principle**: Keep step definitions thin, delegate to page objects or tasks.

**Template**:
```java
package stepdefinitions.ui;

import io.cucumber.java.en.*;
import net.serenitybdd.core.Serenity;
import net.thucydides.core.annotations.Steps;
import pages.LoginPage;
import pages.UserProfilePage;
import static org.assertj.core.api.Assertions.assertThat;

public class UserManagementSteps {

    @Steps
    LoginPage loginPage;

    @Steps
    UserProfilePage userProfilePage;

    @Given("I am logged in as an? {string}")
    public void iAmLoggedInAs(String userType) {
        User user = TestUsers.getUser(userType);
        loginPage.open();
        loginPage.login(user.getUsername(), user.getPassword());
    }

    @When("I navigate to my profile page")
    public void iNavigateToMyProfilePage() {
        userProfilePage.open();
    }

    @When("I update my profile with name {string}")
    public void iUpdateMyProfileWithName(String name) {
        userProfilePage.enterName(name);
        userProfilePage.clickSaveButton();
    }

    @Then("I should see my profile updated successfully")
    public void iShouldSeeMyProfileUpdatedSuccessfully() {
        assertThat(userProfilePage.getSuccessMessage())
            .contains("Profile updated successfully");
    }

    @Then("my profile name should be {string}")
    public void myProfileNameShouldBe(String expectedName) {
        assertThat(userProfilePage.getDisplayedName())
            .isEqualTo(expectedName);
    }
}
```

### Page Objects

**Principle**: Encapsulate page elements and interactions.

**Template**:
```java
package pages;

import net.serenitybdd.core.annotations.findby.FindBy;
import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;

public class UserProfilePage extends PageObject {

    @FindBy(id = "profile-name")
    private WebElementFacade nameField;

    @FindBy(id = "profile-email")
    private WebElementFacade emailField;

    @FindBy(css = "button[type='submit']")
    private WebElementFacade saveButton;

    @FindBy(css = ".success-message")
    private WebElementFacade successMessage;

    @FindBy(css = ".profile-display-name")
    private WebElementFacade displayedName;

    public void enterName(String name) {
        nameField.clear();
        nameField.type(name);
    }

    public void enterEmail(String email) {
        emailField.clear();
        emailField.type(email);
    }

    public void clickSaveButton() {
        saveButton.click();
    }

    public String getSuccessMessage() {
        return successMessage.waitUntilVisible().getText();
    }

    public String getDisplayedName() {
        return displayedName.getText();
    }

    public boolean isProfileFormDisplayed() {
        return nameField.isVisible() && emailField.isVisible();
    }
}
```

### API Clients

**Principle**: Encapsulate API requests and responses.

**Template**:
```java
package api;

import io.restassured.response.Response;
import models.User;
import net.serenitybdd.rest.SerenityRest;
import static io.restassured.http.ContentType.JSON;
import static org.hamcrest.Matchers.*;

public class UserApiClient extends BaseApiClient {

    private static final String USERS_ENDPOINT = "/api/users";

    public Response createUser(User user) {
        return SerenityRest
            .given()
                .contentType(JSON)
                .body(user)
            .when()
                .post(USERS_ENDPOINT);
    }

    public Response getUser(String userId) {
        return SerenityRest
            .given()
                .pathParam("id", userId)
            .when()
                .get(USERS_ENDPOINT + "/{id}");
    }

    public Response updateUser(String userId, User updatedUser) {
        return SerenityRest
            .given()
                .contentType(JSON)
                .pathParam("id", userId)
                .body(updatedUser)
            .when()
                .put(USERS_ENDPOINT + "/{id}");
    }

    public Response deleteUser(String userId) {
        return SerenityRest
            .given()
                .pathParam("id", userId)
            .when()
                .delete(USERS_ENDPOINT + "/{id}");
    }

    public void verifyUserCreated(Response response, User expectedUser) {
        response.then()
            .statusCode(201)
            .contentType(JSON)
            .body("email", equalTo(expectedUser.getEmail()))
            .body("name", equalTo(expectedUser.getName()))
            .body("id", notNullValue());
    }

    public void verifyUserRetrieved(Response response, String expectedUserId) {
        response.then()
            .statusCode(200)
            .body("id", equalTo(expectedUserId));
    }

    public String extractUserId(Response response) {
        return response.jsonPath().getString("id");
    }
}
```

### Model Classes

**Principle**: Represent data structures clearly.

**Template**:
```java
package models;

import com.fasterxml.jackson.annotation.JsonProperty;

public class User {

    @JsonProperty("id")
    private String id;

    @JsonProperty("email")
    private String email;

    @JsonProperty("name")
    private String name;

    @JsonProperty("password")
    private String password;

    // Constructors
    public User() {}

    public User(String email, String name, String password) {
        this.email = email;
        this.name = name;
        this.password = password;
    }

    // Getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // Builder pattern (optional)
    public static class Builder {
        private String email;
        private String name;
        private String password;

        public Builder email(String email) {
            this.email = email;
            return this;
        }

        public Builder name(String name) {
            this.name = name;
            return this;
        }

        public Builder password(String password) {
            this.password = password;
            return this;
        }

        public User build() {
            return new User(email, name, password);
        }
    }
}
```

### Test Runners

**Template**:
```java
package runners;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
    features = "src/test/resources/features/ui",
    glue = {"stepdefinitions.ui", "hooks"},
    tags = "@ui and not @wip",
    plugin = {
        "pretty",
        "json:target/cucumber-reports/ui-tests.json",
        "html:target/cucumber-reports/ui-tests.html"
    }
)
public class UiTestRunner {
    // This class will be empty
}
```

### Test Hooks

**Template**:
```java
package hooks;

import io.cucumber.java.*;
import net.thucydides.core.util.EnvironmentVariables;
import net.thucydides.core.util.SystemEnvironmentVariables;
import utils.ConfigManager;
import utils.DatabaseHelper;

public class TestHooks {

    private EnvironmentVariables environmentVariables = SystemEnvironmentVariables.createEnvironmentVariables();
    private DatabaseHelper databaseHelper = new DatabaseHelper();

    @Before
    public void setUp(Scenario scenario) {
        // Log scenario start
        System.out.println("Starting scenario: " + scenario.getName());

        // Setup test environment
        String environment = ConfigManager.getEnvironment();
        System.out.println("Running on environment: " + environment);

        // Clean database if needed
        if (scenario.getSourceTagNames().contains("@cleanDb")) {
            databaseHelper.cleanTestData();
        }
    }

    @After
    public void tearDown(Scenario scenario) {
        // Log scenario result
        if (scenario.isFailed()) {
            System.out.println("Scenario FAILED: " + scenario.getName());
            // Additional failure handling
        } else {
            System.out.println("Scenario PASSED: " + scenario.getName());
        }

        // Cleanup test data if needed
        if (scenario.getSourceTagNames().contains("@cleanupAfter")) {
            databaseHelper.cleanTestData();
        }
    }

    @BeforeAll
    public static void beforeAll() {
        System.out.println("=== Test Suite Starting ===");
    }

    @AfterAll
    public static void afterAll() {
        System.out.println("=== Test Suite Completed ===");
    }
}
```

### Utility Classes

**ConfigManager**:
```java
package utils;

import net.thucydides.core.util.EnvironmentVariables;
import net.thucydides.core.util.SystemEnvironmentVariables;

public class ConfigManager {

    private static final EnvironmentVariables environmentVariables = SystemEnvironmentVariables.createEnvironmentVariables();

    public static String getEnvironment() {
        return System.getProperty("environment", "dev");
    }

    public static String getBaseUrl() {
        return environmentVariables.getProperty("environments." + getEnvironment() + ".base.url");
    }

    public static String getApiBaseUri() {
        return environmentVariables.getProperty("environments." + getEnvironment() + ".api.base.uri");
    }

    public static String getDatabaseUrl() {
        return environmentVariables.getProperty("environments." + getEnvironment() + ".database.url");
    }
}
```

**TestDataGenerator**:
```java
package utils;

import com.github.javafaker.Faker;
import models.User;

public class TestDataGenerator {

    private static final Faker faker = new Faker();

    public static User generateRandomUser() {
        return new User(
            faker.internet().emailAddress(),
            faker.name().fullName(),
            faker.internet().password(8, 12)
        );
    }

    public static String generateEmail() {
        return faker.internet().emailAddress();
    }

    public static String generateName() {
        return faker.name().fullName();
    }

    public static String generatePassword() {
        return faker.internet().password(8, 12, true, true);
    }
}
```

## Serenity Configuration

**serenity.conf**:
```hocon
webdriver {
  driver = chrome
  autodownload = true
  capabilities {
    browserName = "chrome"
    acceptInsecureCerts = true
    "goog:chromeOptions" {
      args = [
        "start-maximized",
        "disable-infobars",
        "disable-popup-blocking",
        "disable-notifications"
      ]
    }
  }
}

serenity {
  project.name = "QA Test Automation - ${STORY_KEY}"
  test.root = "features"
  take.screenshots = FOR_FAILURES
  console.colors = true
  logging = VERBOSE
}

environments {
  dev {
    base.url = "https://dev.example.com"
    api.base.uri = "https://api-dev.example.com"
    database.url = "jdbc:postgresql://dev-db:5432/testdb"
  }
  staging {
    base.url = "https://staging.example.com"
    api.base.uri = "https://api-staging.example.com"
    database.url = "jdbc:postgresql://staging-db:5432/testdb"
  }
}
```

## Validation and Testing

After implementation:

### 1. Compile Code
```bash
mvn clean compile
```

### 2. Verify Step Definitions
```bash
mvn test -Dcucumber.options="--dry-run"
```

### 3. Run Smoke Tests
```bash
mvn verify -Dcucumber.filter.tags="@smoke"
```

### 4. Generate Serenity Report
```bash
mvn serenity:aggregate
open target/site/serenity/index.html
```

## Implementation Summary Report

Generate `implementation-summary.md`:

```markdown
# Implementation Summary: [STORY-KEY]

**Date**: [DATE]
**Status**: Completed

## Files Created

### Step Definitions
- `stepdefinitions/ui/UserManagementSteps.java` - [N] step definitions
- `stepdefinitions/api/UserApiSteps.java` - [N] step definitions

### Page Objects
- `pages/LoginPage.java`
- `pages/UserProfilePage.java`
- `pages/BasePage.java`

### API Clients
- `api/UserApiClient.java`
- `api/BaseApiClient.java`

### Models
- `models/User.java`
- `models/Profile.java`

### Utilities
- `utils/ConfigManager.java`
- `utils/TestDataGenerator.java`
- `utils/DatabaseHelper.java`

### Test Runners
- `runners/ApiTestRunner.java`
- `runners/UiTestRunner.java`
- `runners/SmokeTestRunner.java`

### Configuration
- `serenity.conf`
- `application.properties`

## Test Coverage

- Total Gherkin scenarios: [N]
- Step definitions implemented: [N]
- Page objects created: [N]
- API clients created: [N]
- Test runners configured: [N]

## Compilation Status

- [ ] Code compiles successfully
- [ ] No missing step definitions
- [ ] No Cucumber warnings
- [ ] All dependencies resolved

## Next Steps

1. Run tests: `mvn verify -Dcucumber.filter.tags="@smoke"`
2. Review Serenity report: `target/site/serenity/index.html`
3. Address any test failures
4. Execute full regression suite
5. Integrate with CI/CD pipeline

## Known Issues

[List any known issues or limitations]

## Notes

[Any additional notes or observations]
```

## Output

After implementation:
1. Report total files created
2. Report step definitions implemented
3. Report compilation status
4. Report next steps for test execution
5. Provide command to run tests
6. Provide command to view report

Context for test implementation: $ARGUMENTS
