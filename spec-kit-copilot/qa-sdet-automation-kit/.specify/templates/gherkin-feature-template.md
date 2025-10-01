# Gherkin Feature Template

This template shows the structure for writing Gherkin BDD scenarios.

```gherkin
@[story-key] @[feature-tag]
Feature: [Feature Name]
  As a [persona/role]
  I want to [goal/action]
  So that [benefit/value]

  Background:
    Given [common precondition for all scenarios in this feature]
    And [another common precondition]

  @smoke @P0 @positive @ui
  Scenario: [Descriptive scenario name for happy path]
    Given [initial state or precondition]
    And [another precondition if needed]
    When [user action or event]
    And [another action if needed]
    Then [expected observable outcome]
    And [another expected outcome]

  @regression @P1 @negative @ui
  Scenario: [Descriptive scenario name for error case]
    Given [initial state]
    When [action that triggers error]
    Then [error handling verification]
    And [error message verification]
    And [system state remains consistent]

  @regression @P1 @positive @api
  Scenario: [API scenario name]
    Given the API endpoint is "/api/[resource]"
    And I have valid authentication token
    When I send a [POST/GET/PUT/DELETE] request with payload:
      """json
      {
        "field1": "value1",
        "field2": "value2"
      }
      """
    Then the response status code should be [200/201/204/etc]
    And the response should contain field "[field_name]"
    And the response field "[field_name]" should be "[expected_value]"

  @regression @P1 @positive @data-driven
  Scenario Outline: [Data-driven scenario name]
    Given [precondition with <parameter>]
    When [action with <parameter>]
    Then [expected outcome with <parameter>]

    Examples:
      | parameter1 | parameter2 | expected_result |
      | value1     | value2     | result1         |
      | value3     | value4     | result2         |
      | value5     | value6     | result3         |

  @regression @P2 @validation
  Scenario Outline: Validate [field_name] field accepts valid inputs
    Given I am on the [page/form] page
    When I enter "<input>" in the [field_name] field
    And I submit the form
    Then the form should be submitted successfully
    And I should see a success message

    Examples:
      | input     |
      | valid1    |
      | valid2    |
      | valid3    |

  @regression @P2 @validation @negative
  Scenario Outline: Validate [field_name] field rejects invalid inputs
    Given I am on the [page/form] page
    When I enter "<invalid_input>" in the [field_name] field
    And I submit the form
    Then I should see error message "<error_message>"
    And the form should not be submitted

    Examples:
      | invalid_input | error_message |
      | empty         | Field is required |
      | too_long      | Maximum 255 characters allowed |
      | invalid_format| Invalid format |

  @integration @P1
  Scenario: [Integration scenario name]
    Given [external system] is available
    And [precondition in current system]
    When [action that triggers integration]
    Then [data is sent to external system]
    And [response is received]
    And [current system reflects integration result]

  @smoke @P0 @e2e
  Scenario: [End-to-end scenario name covering complete user journey]
    Given [initial state]
    When [first user action]
    And [second user action]
    And [third user action]
    Then [final expected outcome]
    And [side effects are visible]
    And [system state is correct]
```

## Tag Conventions

### Priority Tags
- `@P0` - Critical functionality (blocker if fails)
- `@P1` - High priority
- `@P2` - Medium priority
- `@P3` - Low priority

### Test Type Tags
- `@ui` - UI/frontend tests
- `@api` - API/backend tests
- `@integration` - Integration tests
- `@e2e` - End-to-end tests

### Test Suite Tags
- `@smoke` - Smoke test suite (critical happy paths)
- `@regression` - Full regression suite
- `@sanity` - Sanity check after deployment

### Test Category Tags
- `@positive` - Happy path scenarios
- `@negative` - Error/failure scenarios
- `@validation` - Input validation tests
- `@boundary` - Boundary value tests
- `@security` - Security-related tests
- `@performance` - Performance tests

### Story/Feature Tags
- `@[STORY-KEY]` - Link to JIRA story (e.g., @PROJ-123)
- `@[feature-name]` - Feature grouping (e.g., @user-management)

### Control Tags
- `@wip` - Work in progress (skip in CI)
- `@manual` - Manual testing required
- `@automated` - Fully automated
- `@flaky` - Known flaky test (needs investigation)

## Best Practices

1. **Feature Structure**
   - One feature file per business capability
   - Use Background for common setup
   - Group related scenarios together

2. **Scenario Writing**
   - Keep scenarios independent
   - Use descriptive scenario names
   - Focus on business behavior, not implementation
   - Each scenario should test one thing

3. **Step Writing**
   - Given: Set up context (state, data)
   - When: Perform action (user interaction)
   - Then: Assert outcome (observable result)
   - And/But: Continue previous step type

4. **Data-Driven Tests**
   - Use Scenario Outline for similar scenarios with different data
   - Keep Examples tables readable
   - Use meaningful parameter names

5. **Tags**
   - Apply multiple tags for filtering
   - Always include priority tag
   - Include test type tag
   - Link to story with @[STORY-KEY]

6. **Readability**
   - Write for non-technical stakeholders
   - Avoid technical jargon
   - Use domain language
   - Keep steps concise

## Example Feature Files

### UI Feature Example
```gherkin
@PROJ-123 @user-authentication
Feature: User Authentication
  As a user
  I want to log in to the system
  So that I can access my account

  Background:
    Given the login page is displayed

  @smoke @P0 @positive @ui
  Scenario: Successful login with valid credentials
    Given I have a registered account with email "user@test.com"
    When I enter "user@test.com" in the email field
    And I enter "ValidPass123" in the password field
    And I click the Login button
    Then I should be redirected to the dashboard
    And I should see "Welcome, User" message

  @regression @P1 @negative @ui
  Scenario: Login fails with invalid password
    Given I have a registered account with email "user@test.com"
    When I enter "user@test.com" in the email field
    And I enter "WrongPassword" in the password field
    And I click the Login button
    Then I should remain on the login page
    And I should see error message "Invalid email or password"
```

### API Feature Example
```gherkin
@PROJ-124 @user-api
Feature: User API Management
  As an API consumer
  I want to manage users via API
  So that I can integrate with other systems

  Background:
    Given the API endpoint is "https://api.example.com"
    And I have a valid API authentication token

  @smoke @P0 @positive @api
  Scenario: Create user successfully
    When I send a POST request to "/api/users" with payload:
      """json
      {
        "email": "newuser@test.com",
        "name": "New User",
        "role": "user"
      }
      """
    Then the response status code should be 201
    And the response should contain field "id"
    And the response field "email" should be "newuser@test.com"

  @regression @P1 @negative @api
  Scenario: Create user fails with duplicate email
    Given a user exists with email "existing@test.com"
    When I send a POST request to "/api/users" with payload:
      """json
      {
        "email": "existing@test.com",
        "name": "Duplicate User"
      }
      """
    Then the response status code should be 409
    And the response field "error" should be "Email already exists"
```
