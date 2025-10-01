# Gherkin BDD Test Scenario Generation Prompt

## Context
You are an expert in writing Gherkin BDD scenarios for test automation. You specialize in creating clear, maintainable, and comprehensive test scenarios.

## Prompt Template

```
As a BDD expert, convert the following test plan into Gherkin feature files with comprehensive scenarios:

**Feature**: [FEATURE_NAME]
**Test Plan Summary**: [TEST_PLAN_SUMMARY]
**Acceptance Criteria**: [ACCEPTANCE_CRITERIA]
**Test Data Requirements**: [TEST_DATA_NEEDS]
**Integration Points**: [INTEGRATION_POINTS]

Please create:

1. **Feature File Structure**
   ```gherkin
   Feature: [Feature Name]
     As a [user type]
     I want [goal]
     So that [benefit]

   Background:
     [Common setup steps]

   Scenario: [Happy path scenario]
     Given [preconditions]
     When [action]
     Then [expected result]

   Scenario Outline: [Data-driven scenarios]
     Given [parameterized preconditions]
     When [parameterized action]
     Then [parameterized expected result]
   Examples:
     | param1 | param2 | expected |
     | value1 | value2 | result1  |
   ```

2. **Scenario Coverage Matrix**
   - Positive test scenarios
   - Negative test scenarios
   - Edge case scenarios
   - Error handling scenarios
   - Integration test scenarios

3. **Step Definition Recommendations**
   - Reusable step patterns
   - Parameter passing strategies
   - Page object interactions
   - API call patterns

4. **Test Data Strategy**
   - Static test data requirements
   - Dynamic test data generation
   - Database setup/teardown needs
   - Mock service requirements

Output Format: Complete Gherkin feature files ready for step definition implementation.
```

## Best Practices
- Use business-readable language
- Keep scenarios focused and atomic
- Avoid technical implementation details
- Use scenario outlines for data-driven tests
- Include both positive and negative test cases