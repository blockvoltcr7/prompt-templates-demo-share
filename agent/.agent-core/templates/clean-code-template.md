# Clean Code Review Template
# Purpose: Guidelines and checklist for code refactoring and clean code practices

## Code Review Information
- **File Path:** [FILE_PATH]
- **Reviewed By:** [REVIEWER_NAME]
- **Review Date:** [DATE]
- **Complexity Score:** [LOW/MEDIUM/HIGH]
- **Refactor Priority:** [LOW/MEDIUM/HIGH/CRITICAL]

## Clean Code Principles Checklist

### 1. Naming Conventions
**Guidelines:**
- Variables: Use descriptive, intention-revealing names
- Functions: Use verb-noun combinations (e.g., getUserData())
- Classes: Use noun phrases (e.g., UserManager)
- Constants: Use ALL_CAPS with underscores
- Booleans: Use is/has/can prefixes (e.g., isValid, hasPermission)

**Issues Found:**
- [Issue 1]
- [Issue 2]

**Recommended Changes:**
- [Change 1]
- [Change 2]

### 2. Function Design
**Guidelines:**
- Single Responsibility: Each function does one thing well
- Small Size: Functions are typically 20 lines or less
- Few Parameters: Ideally 3 or fewer parameters
- No Side Effects: Functions don't modify global state unexpectedly
- Pure Functions: Same input always produces same output (where applicable)

**Issues Found:**
- [Issue 1]
- [Issue 2]

**Recommended Changes:**
- [Change 1]
- [Change 2]

### 3. Code Structure
**Guidelines:**
- DRY Principle: Don't Repeat Yourself - eliminate duplication
- Proper Abstraction: Hide implementation details behind clear interfaces
- Separation of Concerns: Different concerns in different modules/classes
- Consistent Indentation: Use consistent spacing/tabs throughout
- Logical Organization: Related code is grouped together

**Issues Found:**
- [Issue 1]
- [Issue 2]

**Recommended Changes:**
- [Change 1]
- [Change 2]

### 4. Comments and Documentation
**Guidelines:**
- Minimal Comments: Code should be self-documenting
- Why, Not What: Comments explain why something is done, not what is done
- No Commented Code: Remove old commented-out code
- API Documentation: Public interfaces are properly documented
- Updated Comments: Comments are accurate and current

**Issues Found:**
- [Issue 1]
- [Issue 2]

**Recommended Changes:**
- [Change 1]
- [Change 2]

### 5. Error Handling
**Guidelines:**
- Explicit Error Handling: Don't ignore or hide exceptions
- Specific Exceptions: Use specific exception types, not generic ones
- Clean Resource Management: Proper cleanup of resources (files, connections)
- Fail Fast: Validate inputs early and fail fast
- Meaningful Error Messages: Errors provide actionable information

**Issues Found:**
- [Issue 1]
- [Issue 2]

**Recommended Changes:**
- [Change 1]
- [Change 2]

### 6. Testing & Testability
**Guidelines:**
- Unit Testable: Code can be easily unit tested
- No Hard Dependencies: Use dependency injection where appropriate
- Observable: Code behavior can be easily verified
- Controllable: External dependencies can be mocked/stubbed
- Test Coverage: Critical paths have appropriate test coverage

**Issues Found:**
- [Issue 1]
- [Issue 2]

**Recommended Changes:**
- [Change 1]
- [Change 2]

## Refactoring Plan

### Phase 1: Quick Wins (Low Risk)
**Estimated Time:** [TIME_ESTIMATE]
1. [Refactoring task 1]
2. [Refactoring task 2]
3. [Refactoring task 3]

### Phase 2: Structural Changes (Medium Risk)
**Estimated Time:** [TIME_ESTIMATE]
1. [Refactoring task 1]
2. [Refactoring task 2]
3. [Refactoring task 3]

### Phase 3: Architecture Changes (High Risk)
**Estimated Time:** [TIME_ESTIMATE]
1. [Refactoring task 1]
2. [Refactoring task 2]
3. [Refactoring task 3]

## Quality Metrics

### Before Refactoring
- Cyclomatic Complexity: [NUMBER]
- Lines of Code: [NUMBER]
- Test Coverage: [PERCENTAGE]
- Code Duplication: [PERCENTAGE]
- Technical Debt Ratio: [RATIO]

### After Refactoring (Target)
- Cyclomatic Complexity: [TARGET_NUMBER]
- Lines of Code: [TARGET_NUMBER]
- Test Coverage: [TARGET_PERCENTAGE]
- Code Duplication: [TARGET_PERCENTAGE]
- Technical Debt Ratio: [TARGET_RATIO]

## Risk Assessment

### High Risk Areas
- [Risk area 1]: [Description and mitigation]
- [Risk area 2]: [Description and mitigation]

### Testing Strategy
- [Testing approach for refactored code]
- [Regression testing plan]
- [Performance testing requirements]

## Success Criteria
- [ ] All existing tests pass
- [ ] Code coverage maintained or improved
- [ ] Performance not degraded
- [ ] Code readability improved
- [ ] Technical debt reduced
- [ ] New bugs not introduced

## Sign-off
- **Developer:** [NAME] - Date: [DATE]
- **Code Reviewer:** [NAME] - Date: [DATE]
- **QA Lead:** [NAME] - Date: [DATE]