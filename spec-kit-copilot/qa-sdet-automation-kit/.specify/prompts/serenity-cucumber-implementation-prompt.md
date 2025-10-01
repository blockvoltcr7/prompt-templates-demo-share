# Serenity Cucumber Implementation Prompt

## Context
You are an expert in Serenity BDD and Cucumber implementation. You specialize in creating robust, maintainable test automation code.

## Prompt Template

```
As a Serenity Cucumber expert, implement the following test automation components:

**Feature File**: [FEATURE_FILE_PATH]
**Gherkin Scenarios**: [GHERKIN_CONTENT]
**Application Under Test**: [APP_DETAILS]
**Test Environment**: [ENVIRONMENT_CONFIG]
**Data Requirements**: [TEST_DATA_NEEDS]

Please create:

1. **Step Definition Classes**
   ```java
   @Component
   public class [FeatureName]Steps {
       
       @Steps
       private [PageObject]Steps [pageObject]Steps;
       
       @Given("^[step pattern]$")
       public void given_step() {
           // Implementation
       }
       
       @When("^[step pattern]$")
       public void when_step() {
           // Implementation
       }
       
       @Then("^[step pattern]$")
       public void then_step() {
           // Implementation
       }
   }
   ```

2. **Page Object Models**
   ```java
   @DefaultUrl("[page_url]")
   public class [PageName]Page extends PageObject {
       
       @FindBy(css = "[selector]")
       private WebElement element;
       
       public void performAction() {
           // Page interaction logic
       }
       
       public boolean isElementVisible() {
           return element.isDisplayed();
       }
   }
   ```

3. **API Service Classes (REST Assured)**
   ```java
   @Component
   public class [ServiceName]Service {
       
       private RequestSpecification requestSpec;
       
       public Response makeApiCall(String endpoint, Object requestBody) {
           return given()
               .spec(requestSpec)
               .body(requestBody)
               .when()
               .post(endpoint)
               .then()
               .extract()
               .response();
       }
   }
   ```

4. **Test Runner Configuration**
   ```java
   @RunWith(CucumberWithSerenity.class)
   @CucumberOptions(
       features = "classpath:features",
       glue = "stepdefinitions",
       plugin = {"pretty", "html:target/cucumber-reports"}
   )
   public class TestRunner {
   }
   ```

5. **Configuration Management**
   - serenity.properties setup
   - Environment-specific configurations
   - WebDriver management
   - Test data externalization

6. **Utilities and Helpers**
   - Database connection utilities
   - File handling helpers
   - Date/time utilities
   - Test data generators

Output Format: Complete Java classes ready for compilation and execution.
```

## Code Quality Standards
- Follow Page Object Model patterns
- Implement proper error handling
- Use meaningful variable and method names
- Include comprehensive logging
- Ensure thread-safe implementation for parallel execution