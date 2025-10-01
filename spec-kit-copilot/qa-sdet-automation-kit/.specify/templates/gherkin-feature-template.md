# Gherkin Feature Template

## Feature File Structure

```gherkin
@[feature_tag]
Feature: [Feature Name]
  As a [user type]
  I want [goal/desire]
  So that [benefit/value]

  Background:
    Given [common precondition 1]
    And [common precondition 2]
    When [common setup action]

  @[scenario_tag] @[priority_tag]
  Scenario: [Happy path scenario name]
    Given [specific precondition]
    When [user action]
    Then [expected result]
    And [additional verification]

  @[scenario_tag] @[priority_tag]
  Scenario: [Alternative path scenario name]
    Given [specific precondition]
    When [alternative user action]
    Then [expected alternative result]

  @[scenario_tag] @[priority_tag]
  Scenario: [Error handling scenario name]
    Given [error condition setup]
    When [action that triggers error]
    Then [expected error message or behavior]

  @[scenario_tag] @[priority_tag]
  Scenario Outline: [Data-driven scenario name]
    Given [parameterized precondition with <parameter>]
    When [parameterized action with <parameter>]
    Then [expected result with <expected_result>]

    Examples:
      | parameter | expected_result |
      | value1    | result1        |
      | value2    | result2        |
      | value3    | result3        |

  @[scenario_tag] @[priority_tag]
  Scenario: [Integration scenario name]
    Given [system integration setup]
    When [cross-system action]
    Then [integrated system response]
    And [downstream system verification]
```

## Tag Conventions

### Feature Tags
- `@login` - Login functionality
- `@registration` - User registration
- `@payment` - Payment processing
- `@search` - Search functionality
- `@api` - API testing scenarios
- `@ui` - UI testing scenarios
- `@integration` - Integration testing

### Priority Tags
- `@critical` - Critical business functionality
- `@high` - High priority features
- `@medium` - Medium priority features
- `@low` - Low priority features

### Execution Tags
- `@smoke` - Smoke test scenarios
- `@regression` - Regression test scenarios
- `@sanity` - Sanity test scenarios
- `@e2e` - End-to-end test scenarios

### Environment Tags
- `@dev` - Development environment only
- `@staging` - Staging environment only
- `@prod` - Production environment safe

## Scenario Writing Guidelines

### Good Scenario Example
```gherkin
@login @critical @smoke
Scenario: Successful login with valid credentials
  Given I am on the login page
  And I have a valid user account
  When I enter valid username and password
  And I click the login button
  Then I should be redirected to the dashboard
  And I should see a welcome message
  And my session should be active
```

### Data-Driven Example
```gherkin
@login @high @regression
Scenario Outline: Login validation with different credential combinations
  Given I am on the login page
  When I enter "<username>" and "<password>"
  And I click the login button
  Then I should see "<result>"

  Examples:
    | username      | password    | result                    |
    | valid_user    | valid_pass  | successful login          |
    | invalid_user  | valid_pass  | invalid username error    |
    | valid_user    | invalid_pass| invalid password error    |
    | empty         | valid_pass  | username required error   |
    | valid_user    | empty       | password required error   |
```

### API Testing Example
```gherkin
@api @user_management @high
Scenario: Create new user via API
  Given I have valid API authentication
  When I send a POST request to "/api/users" with user data:
    | field     | value              |
    | name      | John Doe           |
    | email     | john@example.com   |
    | role      | standard_user      |
  Then the response status should be 201
  And the response should contain user ID
  And the user should be created in the database
```

### Integration Testing Example
```gherkin
@integration @payment @critical
Scenario: End-to-end payment processing
  Given I have items in my shopping cart
  And I am logged in as a valid customer
  When I proceed to checkout
  And I enter valid payment information
  And I submit the payment
  Then the payment should be processed successfully
  And I should receive a confirmation email
  And the order should be created in the system
  And the inventory should be updated
  And the payment should be recorded in the payment gateway
```

## Step Definition Patterns

### Common Step Patterns
```gherkin
# Navigation Steps
Given I am on the [page_name] page
When I navigate to [page_name]

# Form Interaction Steps
When I enter "[value]" in the [field_name] field
When I select "[option]" from the [dropdown_name] dropdown
When I click the [button_name] button

# Verification Steps
Then I should see "[text]"
Then the [element_name] should be visible
Then the [element_name] should contain "[text]"

# Wait Steps
And I wait for [element_name] to be visible
And I wait for the page to load

# Data Steps
Given I have test data:
  | field1 | field2 |
  | value1 | value2 |
```

## Best Practices

### Writing Effective Scenarios
1. **Use business language** - Avoid technical implementation details
2. **Keep scenarios focused** - One scenario should test one specific behavior
3. **Make scenarios independent** - Each scenario should be able to run independently
4. **Use meaningful names** - Scenario names should clearly describe what is being tested
5. **Include both positive and negative cases** - Test happy path and error conditions

### Data Management
1. **Externalize test data** - Use Examples tables or external data files
2. **Use realistic data** - Test data should mimic real-world scenarios
3. **Avoid hardcoded values** - Use parameters and variables
4. **Clean up test data** - Ensure test data doesn't interfere with other tests

### Maintenance
1. **Regular review** - Review and update scenarios regularly
2. **Remove obsolete scenarios** - Clean up scenarios for removed features
3. **Refactor common steps** - Create reusable step definitions
4. **Version control** - Track changes to feature files

---
**Template Version**: 1.0.0  
**Created By**: QA/SDET Team  
**Last Updated**: [DATE]