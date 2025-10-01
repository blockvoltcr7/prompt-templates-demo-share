---
description: Generate Gherkin BDD scenarios from test plan test cases for Cucumber implementation.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

You are generating Gherkin BDD scenarios in proper Given/When/Then format for Cucumber execution. This runs AFTER `/test-plan`.

## Execution Flow (main)

```
1. Run `.specify/scripts/powershell/check-test-prerequisites.ps1 -Json -RequireTestPlan`
   → Parse STORY_DIR, TEST_PLAN_FILE, GHERKIN_DIR
   → If test-plan.md missing: ERROR "Run /test-plan first"
2. Load test plan document
   → Extract all test cases
   → Extract test data requirements
3. Load Gherkin template
   → From `.specify/templates/gherkin-feature-template.md`
4. Group test cases by feature/functionality
   → Organize into logical feature files
5. For each test case, generate Gherkin scenario:
   → Map to Feature
   → Create Scenario or Scenario Outline
   → Write Given (preconditions)
   → Write When (actions)
   → Write Then (assertions)
   → Add Examples table if data-driven
6. Apply Gherkin best practices:
   → Use proper Given/When/Then structure
   → Keep scenarios atomic and independent
   → Use Background for common preconditions
   → Use Scenario Outline for data-driven tests
   → Add meaningful tags (@smoke, @regression, @api, @ui)
7. Generate feature files:
   → Create specs/[STORY-KEY]/gherkin/*.feature files
   → One feature file per logical grouping
8. Generate step definition placeholders:
   → Create specs/[STORY-KEY]/step-definitions-guide.md
9. Validate Gherkin syntax
10. Return: SUCCESS (ready for /test-strategy)
```

## Gherkin Best Practices

### Structure Rules
1. **One Feature per file** representing a business capability
2. **Scenarios should be independent** and executable in any order
3. **Use Background** for common preconditions across scenarios
4. **Use Scenario Outline** for data-driven tests with Examples
5. **Keep steps at user/business level**, not implementation details

### Given/When/Then Guidelines

**Given** (Context/Preconditions):
- Set up initial state
- Create necessary test data
- Navigate to starting point
- Examples: "Given I am logged in as an admin", "Given a product exists with price $50"

**When** (Action):
- User action or event
- What the user does
- Examples: "When I click the Submit button", "When I send a POST request to /api/users"

**Then** (Expected Outcome):
- Observable outcome
- Assertion/verification
- Examples: "Then I should see a success message", "Then the response status code should be 200"

**And/But**:
- Chain multiple steps
- Use for readability

### Tags
Use tags for test organization and execution:
- `@smoke` - Critical happy path tests
- `@regression` - Full regression suite
- `@api` - API-level tests
- `@ui` - UI-level tests
- `@integration` - Integration tests
- `@P0`, `@P1`, `@P2` - Priority levels
- `@positive` - Happy path scenarios
- `@negative` - Error/validation scenarios
- `@wip` - Work in progress (skip in CI)

## Feature File Structure

```gherkin
@[story-key] @[feature-tag]
Feature: [Feature Name]
  As a [persona]
  I want to [goal]
  So that [benefit]

  Background:
    Given [common precondition for all scenarios]
    And [another common precondition]

  @smoke @P0 @positive
  Scenario: [Scenario name - should be descriptive]
    Given [precondition]
    And [another precondition]
    When [action]
    And [another action]
    Then [expected outcome]
    And [another expected outcome]

  @regression @P1 @negative
  Scenario: [Error scenario name]
    Given [precondition]
    When [action that triggers error]
    Then [error handling verification]
    And [error message verification]

  @regression @P1 @positive
  Scenario Outline: [Data-driven scenario name]
    Given [precondition with <parameter>]
    When [action with <parameter>]
    Then [expected outcome with <parameter>]

    Examples:
      | parameter1 | parameter2 | expected_result |
      | value1     | value2     | result1         |
      | value3     | value4     | result2         |
```

## Generation Rules

### For Positive Flow Tests
```gherkin
@positive @P0
Scenario: User successfully [action]
  Given [user is in initial state]
  And [necessary preconditions exist]
  When [user performs action]
  Then [system responds with success]
  And [expected state changes are visible]
```

### For Negative Flow Tests
```gherkin
@negative @P1
Scenario: System handles [error condition] appropriately
  Given [user is in initial state]
  When [user triggers error condition]
  Then [system displays appropriate error message]
  And [system state remains consistent]
  And [no data corruption occurs]
```

### For Validation Tests
```gherkin
@validation @P1
Scenario Outline: System validates [field] with [rule]
  Given [form/page is displayed]
  When I enter "<invalid_value>" in [field]
  And I submit the form
  Then I should see error message "<error_message>"
  And the form should not be submitted

  Examples:
    | invalid_value | error_message |
    | [value1]      | [message1]    |
    | [value2]      | [message2]    |
```

### For API Tests
```gherkin
@api @P0
Scenario: API successfully [operation]
  Given the API endpoint is "/api/[resource]"
  And I have valid authentication token
  When I send a [METHOD] request with payload:
    """
    {
      "field1": "value1",
      "field2": "value2"
    }
    """
  Then the response status code should be [200/201/etc]
  And the response should contain field "id"
  And the response field "status" should be "success"
```

### For Integration Tests
```gherkin
@integration @P1
Scenario: System correctly integrates with [external system]
  Given [external system] is available
  And [preconditions in current system]
  When [action that triggers integration]
  Then [data is sent to external system]
  And [response is received from external system]
  And [current system reflects the integration result]
```

## Output Structure

Generate feature files in `specs/[STORY-KEY]/gherkin/`:

```
specs/[STORY-KEY]/gherkin/
├── user_authentication.feature
├── user_profile_management.feature
├── api_user_operations.feature
└── integration_external_auth.feature
```

Also generate `step-definitions-guide.md`:

```markdown
# Step Definitions Guide: [STORY-KEY]

This document lists all the step definitions needed for the Gherkin scenarios.

## Required Step Definitions

### Authentication Steps
- `Given I am logged in as {user_type}`
- `Given I am not authenticated`
- `When I log out`

### Navigation Steps
- `Given I am on the {page_name} page`
- `When I navigate to {url}`

### Interaction Steps
- `When I click the {button_name} button`
- `When I enter {value} in the {field_name} field`
- `When I select {option} from the {dropdown_name} dropdown`

### API Steps
- `Given the API endpoint is {endpoint}`
- `When I send a {method} request to {endpoint}`
- `When I send a {method} request with payload:`

### Assertion Steps
- `Then I should see {text}`
- `Then I should be on the {page_name} page`
- `Then the response status code should be {status_code}`
- `Then the response should contain field {field_name}`

### Data Setup Steps
- `Given a {entity_type} exists with {attributes}`
- `Given the database is in a clean state`

## Page Objects Needed

Based on the scenarios, you will need these Page Objects:

### LoginPage
- Methods: login(username, password), isLoginSuccessful()

### UserProfilePage
- Methods: updateProfile(data), deleteAccount(), isProfileUpdated()

## API Clients Needed

### UserApiClient
- Methods: createUser(payload), getUser(id), updateUser(id, payload), deleteUser(id)

## Test Data

### Test Users
```java
public class TestUsers {
    public static User ADMIN_USER = new User("admin@test.com", "password123");
    public static User REGULAR_USER = new User("user@test.com", "password123");
    public static User GUEST_USER = new User("guest@test.com", "password123");
}
```

### Test Data Builders
```java
public class UserDataBuilder {
    public static User buildValidUser() { ... }
    public static User buildInvalidUser() { ... }
}
```

## Serenity Screenplay Pattern (Optional)

If using Serenity Screenplay pattern:

### Actors
- `Admin` - Admin user persona
- `RegularUser` - Regular user persona

### Tasks
- `Login.asUser(username, password)`
- `CreateProfile.withDetails(data)`
- `UpdateProfile.withNewDetails(data)`

### Questions
- `ProfileDetails.displayed()`
- `ErrorMessage.text()`
- `ResponseStatus.code()`

### Interactions
- `Click.on(button)`
- `Enter.theValue(value).into(field)`
- `SendRequest.to(endpoint).withPayload(payload)`
```

## Validation Checklist

Before completing:
- [ ] All test cases from test plan have corresponding Gherkin scenarios
- [ ] Scenarios follow proper Given/When/Then structure
- [ ] Scenarios are independent and atomic
- [ ] Data-driven tests use Scenario Outline with Examples
- [ ] Tags are applied correctly (@smoke, @P0, @api, etc.)
- [ ] Feature files are logically organized
- [ ] Step definitions guide is comprehensive
- [ ] Gherkin syntax is valid

## Output

After generation:
1. Report number of feature files created
2. Report total number of scenarios
3. Report scenarios by tag (@smoke, @regression, @api, @ui)
4. Report scenarios by priority (@P0, @P1, @P2)
5. List all feature file paths
6. Suggest next command: `/test-strategy`

Context for Gherkin generation: $ARGUMENTS
