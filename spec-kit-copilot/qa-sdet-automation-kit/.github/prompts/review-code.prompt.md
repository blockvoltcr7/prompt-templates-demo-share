---
description: Perform comprehensive code quality review of implemented test automation code before Git commit.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

You are performing a comprehensive code quality review of test automation code to ensure it meets clean code principles and constitutional standards before Git commit.

## Execution Flow (main)

```
1. Run `.specify/scripts/powershell/check-test-prerequisites.ps1 -Json -RequireStrategy`
   → Parse STORY_DIR, TEST_FRAMEWORK_DIR
   → If implementation not complete: ERROR "Run /implement-tests first"
2. Load constitution for quality standards
   → From `.specify/memory/constitution.md`
3. Scan implemented test code files:
   → Step definitions (stepdefinitions/)
   → Page objects (pages/)
   → API clients (api/)
   → Model classes (models/)
   → Utility classes (utils/)
   → Test runners (runners/)
4. Analyze each file against review criteria:
   → Clean code principles (function size, SRP, abstraction)
   → Constitutional standards (POM, API client pattern, test independence)
   → Java best practices
   → Test-specific patterns
5. Categorize violations by severity:
   → CRITICAL: Must fix (constitutional violations, security)
   → HIGH: Should fix (code quality, maintainability)
   → MEDIUM: Improve when possible (minor refactoring)
   → LOW: Optional (formatting, comments)
6. Generate code quality report:
   → Store in specs/[STORY-KEY]/code-quality-report.md
7. Provide remediation options:
   → Auto-fix (AI applies fixes)
   → Manual fix (show guidance)
   → Accept with justification
8. Gate decision: PASS (commit ready) or FAIL (fixes required)
9. Return: SUCCESS with report or ERROR with blocking issues
```

## Review Criteria

### A. Clean Code Principles

#### 1. Function Size & Complexity
**Target**: 1-5 lines (average 4 lines)
**Maximum**: 20 lines absolute maximum
**Check**:
- Count lines per method (excluding blank lines and braces)
- Flag functions > 5 lines with severity based on size
- Flag functions > 20 lines as CRITICAL

**Severity**:
- 1-5 lines: ✅ PASS
- 6-10 lines: 🟡 MEDIUM (suggest extraction)
- 11-20 lines: 🟠 HIGH (refactoring needed)
- 21+ lines: 🔴 CRITICAL (must refactor)

#### 2. Single Responsibility Principle
**Rule**: Functions must do exactly one thing at one level of abstraction

**Check**:
- Look for blank lines within functions (indicates multiple responsibilities)
- Check for mixed concerns (e.g., validation + business logic)
- Verify consistent abstraction level

**Violations**:
- Functions with multiple logical sections
- Mixed high-level and low-level operations
- Functions doing AND operations (e.g., "processAndValidate")

#### 3. Abstraction Levels
**Rule**: All statements should be at the same abstraction level

**Check**:
- High-level: `validateOrder()`, `processPayment()`
- Low-level: `if (x > 0)`, `list.add(item)`
- Don't mix: High-level method calling low-level operations directly

**Example Violation**:
```java
public void login(String username, String password) {
    validateCredentials(username, password);  // High-level
    usernameField.type(username);            // Low-level ❌
    passwordField.type(password);            // Low-level ❌
    clickLoginButton();                      // High-level
}
```

#### 4. Parameter Guidelines
**Rule**: 0-2 parameters ideal, 3 maximum

**Check**:
- Count parameters per method
- Flag boolean parameters (should be separate methods)
- Flag null parameters

**Severity**:
- 0-1 parameters: ✅ PASS
- 2 parameters: ✅ PASS
- 3 parameters: 🟡 MEDIUM (consider refactoring)
- 4+ parameters: 🔴 CRITICAL (must refactor)
- Boolean flag parameter: 🟠 HIGH (split into separate methods)

#### 5. Command-Query Separation
**Rule**: Functions either change state (void) OR return information, never both

**Check**:
- Methods returning values should not have side effects
- Methods with void return should only change state
- No getter methods that modify state

**Violation Example**:
```java
public User getUser(String id) {
    User user = repository.findById(id);
    user.setLastAccessed(new Date());  // ❌ Side effect in getter
    return user;
}
```

#### 6. Error Handling
**Rule**: Error handling is one thing; separate from business logic

**Check**:
- Try/catch blocks with business logic inside
- Try should be first word in function
- Extract try/catch body into separate function

**Violation Example**:
```java
public void processOrder(Order order) {
    try {
        validateOrder(order);      // Business logic
        calculateTotals(order);    // Business logic
        saveOrder(order);          // Business logic
    } catch (Exception e) {
        log.error(e);
    }
}
```

**Fix**:
```java
public void processOrder(Order order) {
    try {
        processOrderInternal(order);
    } catch (OrderException e) {
        handleOrderError(e);
    }
}

private void processOrderInternal(Order order) {
    validateOrder(order);
    calculateTotals(order);
    saveOrder(order);
}
```

#### 7. Naming Conventions
**Rule**: Descriptive names that reveal intent

**Check**:
- Use verb phrases for methods: `getUser()`, `validateInput()`, `processPayment()`
- Avoid abbreviations: `usr` → `user`, `proc` → `process`
- Consistent vocabulary: Don't use `fetch`, `get`, `retrieve` interchangeably
- Boolean methods start with `is`, `has`, `can`: `isValid()`, `hasItems()`, `canProcess()`

#### 8. Code Duplication (DRY)
**Rule**: Don't Repeat Yourself

**Check**:
- Identify duplicate code blocks (>3 lines)
- Check for similar methods with minor variations
- Look for copy-paste patterns

**Severity**:
- 2 instances: 🟡 MEDIUM
- 3+ instances: 🟠 HIGH
- Critical path duplication: 🔴 CRITICAL

### B. Constitutional Standards (QA-Specific)

#### 1. Page Object Model (UI Tests)
**Constitution Principle IV**: UI interactions encapsulated in page objects

**CRITICAL Violations**:
- ❌ Direct WebDriver calls in step definitions:
  ```java
  driver.findElement(By.id("button")).click();  // ❌
  ```
- ❌ Locators defined in step definitions
- ❌ Wait logic in step definitions

**Correct Pattern**:
```java
// Step Definition (stepdefinitions/)
@Steps
private LoginPage loginPage;

@When("I click the login button")
public void iClickLoginButton() {
    loginPage.clickLoginButton();  // ✅ Delegates to page object
}

// Page Object (pages/)
@FindBy(id = "login-button")
private WebElementFacade loginButton;

public void clickLoginButton() {
    loginButton.waitUntilClickable().click();
}
```

**Check**:
- No `driver.findElement()` in step definitions
- No `By.id()`, `By.css()`, etc. in step definitions
- No Selenium imports in step definitions (except @Steps)
- All page objects extend `PageObject` or `BasePage`
- Page objects use `@FindBy` annotations
- Page objects use explicit waits

#### 2. API Client Pattern (API Tests)
**Constitution Principle V**: API interactions encapsulated in client classes

**CRITICAL Violations**:
- ❌ Direct RestAssured calls in step definitions:
  ```java
  Response response = given().get("/api/users");  // ❌
  ```
- ❌ Request building in step definitions
- ❌ Response parsing in step definitions

**Correct Pattern**:
```java
// Step Definition (stepdefinitions/)
@Steps
private UserApiClient userApiClient;

@When("I send a GET request to get user {string}")
public void iGetUser(String userId) {
    Response response = userApiClient.getUser(userId);  // ✅
    Serenity.setSessionVariable("response").to(response);
}

// API Client (api/)
public Response getUser(String userId) {
    return SerenityRest
        .given()
            .pathParam("id", userId)
        .when()
            .get(BASE_PATH + "/{id}");
}
```

**Check**:
- No `SerenityRest.given()` in step definitions
- No `RestAssured` imports in step definitions
- All API clients extend `BaseApiClient`
- Request building in API client methods
- Response parsing in API client methods

#### 3. Test Independence
**Constitution Principle III**: Every test runs in isolation

**CRITICAL Violations**:
- ❌ Tests depending on execution order
- ❌ Shared mutable state between tests
- ❌ Tests modifying global state without cleanup

**Check**:
- No `@BeforeAll` setup that creates test data used by multiple tests
- Each scenario sets up its own preconditions in `@Before` or `Background`
- `@After` hooks clean up test data
- No static mutable variables shared across tests
- No assumptions about database state

#### 4. Test Data Management
**Constitution Principle VI**: Test data managed systematically

**Violations**:
- ❌ Hardcoded test data in step definitions or page objects:
  ```java
  loginPage.login("user@test.com", "password123");  // ❌
  ```
- ❌ Magic numbers or strings without constants
- ❌ Same test data reused causing conflicts

**Correct Pattern**:
```java
// Test Data Generator (utils/)
public class TestDataGenerator {
    public static User generateRandomUser() {
        return new User(
            faker.internet().emailAddress(),
            faker.name().fullName(),
            faker.internet().password()
        );
    }
}

// Step Definition
User testUser = TestDataGenerator.generateRandomUser();
loginPage.login(testUser.getEmail(), testUser.getPassword());  // ✅
```

**Check**:
- No hardcoded emails, passwords, usernames in code
- Use `TestDataGenerator` or similar utilities
- Use constants for magic strings/numbers
- Use builders for complex test objects

### C. Java Best Practices

#### 1. Exception Handling
**Check**:
- No empty catch blocks
- No catching generic `Exception` (catch specific exceptions)
- No swallowing exceptions without logging
- Proper exception propagation

**Violations**:
```java
try {
    riskyOperation();
} catch (Exception e) {
    // ❌ Empty catch - exception swallowed
}
```

#### 2. Null Safety
**Check**:
- No null returns (use Optional, empty collections, or throw exception)
- No null parameters
- Null checks before dereferencing

**Violations**:
```java
public User findUser(String id) {
    return repository.findById(id);  // ❌ Returns null if not found
}
```

**Fix**:
```java
public Optional<User> findUser(String id) {
    return Optional.ofNullable(repository.findById(id));  // ✅
}
```

#### 3. Resource Management
**Check**:
- Use try-with-resources for closeable resources
- Proper connection/stream cleanup

#### 4. Collection Usage
**Check**:
- Use appropriate collection type (List vs Set vs Map)
- Don't return null collections (return empty collection)
- Use streams appropriately (don't over-complicate)

### D. Test-Specific Anti-Patterns

#### 1. Flaky Test Patterns
**Check**:
- No `Thread.sleep()` (use explicit waits)
- No hardcoded timeouts that could be environment-dependent
- No assumptions about execution speed

**CRITICAL Violation**:
```java
public void waitForPageLoad() {
    Thread.sleep(3000);  // ❌ CRITICAL - Creates flaky tests
}
```

**Fix**:
```java
public void waitForPageLoad() {
    pageLoadIndicator.waitUntilNotVisible();  // ✅
}
```

#### 2. Over-Complicated Assertions
**Check**:
- Keep assertions simple and focused
- One logical assertion per test (can have multiple assert statements)
- Use appropriate assertion library methods (AssertJ, Hamcrest)

#### 3. Test Setup Bloat
**Check**:
- Setup code (Given steps) should be concise
- Extract complex setup into helper methods
- Use Background for common preconditions

## Output Format

Generate `code-quality-report.md`:

```markdown
# Code Quality Review Report: [STORY-KEY]

**Date**: [DATE]
**Reviewer**: AI Code Quality Agent
**Files Reviewed**: [N] files
**Review Duration**: [X] seconds

---

## 🎯 Executive Summary

**Overall Status**: 🔴 FAIL / 🟡 NEEDS WORK / ✅ PASS

**Violation Summary**:
- 🔴 CRITICAL: [N] violations (Must fix before commit)
- 🟠 HIGH: [N] violations (Should fix before commit)
- 🟡 MEDIUM: [N] violations (Improve when possible)
- ⚪ LOW: [N] violations (Optional improvements)

**Quality Metrics**:
| Metric | Score | Target | Status |
|--------|-------|--------|--------|
| Constitution Compliance | [X]% | 100% | [Status] |
| Function Size (avg lines) | [X] | ≤ 5 | [Status] |
| Clean Code Score | [X]% | 90%+ | [Status] |
| Test Independence | [X]% | 100% | [Status] |
| DRY Violations | [N] | 0 | [Status] |

**Gate Decision**: 🔴 **DO NOT COMMIT** / 🟡 **FIX RECOMMENDED** / ✅ **READY TO COMMIT**

---

## 🔴 CRITICAL Violations (Must Fix)

### ❌ VIOLATION #1: [FileName.java]:[LineNumber]
**Rule Broken**: [Specific Principle]
**Severity**: CRITICAL
**Category**: [Constitutional / Clean Code / Security]

**Issue**:
```java
[Code showing the violation]
```

**Why This Matters**:
[Explanation of impact on maintainability, testability, or correctness]

**Suggested Fix**:
```java
[Refactored code showing the correct pattern]
```

**Extraction Strategy** (if applicable):
1. [Step 1 of extraction]
2. [Step 2 of extraction]
3. [Step 3 of extraction]

**Auto-Fix Available**: Yes / No
**Estimated Fix Time**: [X] minutes

---

[Repeat for each CRITICAL violation]

---

## 🟠 HIGH Priority Violations (Should Fix)

[Same format as CRITICAL]

---

## 🟡 MEDIUM Priority Violations (Improve When Possible)

[Same format, but condensed - can group similar violations]

---

## ⚪ LOW Priority Violations (Optional)

[Brief list without detailed fixes]
- File.java:12 - Consider renaming `proc` to `process`
- File.java:45 - Add JavaDoc comment
- File.java:67 - Line exceeds 120 characters

---

## ✅ PASSES

### Excellent Code Examples
- ✅ `UserApiClient.java` - Perfect API client pattern implementation
- ✅ `ConfigManager.java` - Clean utility class with single responsibility
- ✅ `LoginPage.java` - Proper page object with encapsulated locators
- ✅ All test runners - Correctly configured with appropriate tags

---

## 📊 Detailed Analysis

### Constitution Compliance

#### Principle IV: Page Object Model
- **Files Checked**: [N] step definition files
- **Violations**: [N]
- **Compliance**: [X]%
- **Status**: [Pass/Fail]

[Details of any violations]

#### Principle V: API Client Pattern
- **Files Checked**: [N] API step definition files
- **Violations**: [N]
- **Compliance**: [X]%
- **Status**: [Pass/Fail]

[Details of any violations]

#### Principle III: Test Independence
- **Tests Checked**: [N]
- **Dependencies Found**: [N]
- **Status**: [Pass/Fail]

[Details of any violations]

### Clean Code Metrics

#### Function Size Distribution
```
1-5 lines:   [============================] 70% ([N] functions) ✅
6-10 lines:  [==========]                  25% ([N] functions) 🟡
11-20 lines: [===]                          4% ([N] functions) 🟠
21+ lines:   [=]                            1% ([N] functions) 🔴
```

#### Parameter Count Distribution
```
0-1 params: [================================] 80% ✅
2 params:   [========]                        15% ✅
3 params:   [==]                               4% 🟡
4+ params:  [=]                                1% 🔴
```

#### Code Duplication Analysis
- **Duplicate Code Blocks Found**: [N]
- **Affected Files**: [List files]
- **Estimated Consolidation Savings**: [X] lines

### Test-Specific Analysis

#### Flaky Test Risks
- **Thread.sleep() usage**: [N] instances 🔴
- **Hardcoded waits**: [N] instances 🟠
- **Race conditions**: [N] potential issues 🟡

#### Test Data Management
- **Hardcoded test data**: [N] instances 🔴
- **Magic strings/numbers**: [N] instances 🟡
- **Test data conflicts**: [N] potential issues 🟠

---

## 🎯 Recommended Actions

### Option 1: Auto-Fix (Recommended for most issues)
```
@qa-agent Please fix all CRITICAL and HIGH violations automatically
```
**Fixes**:
- [N] CRITICAL violations
- [N] HIGH violations

**Time**: 5-10 minutes
**Risk**: Low (AI applies known patterns)
**Re-review**: Required after fixes

### Option 2: Manual Fix with Guidance
Review each violation and apply suggested fixes manually.

**Time**: 30-45 minutes
**Risk**: Low (learn by doing)
**Benefit**: Educational - understand each fix

### Option 3: Selective Fix
Fix only CRITICAL violations, defer others.

**Time**: 10-15 minutes
**Risk**: Medium (technical debt for HIGH violations)

### Option 4: Accept and Document (Not Recommended)
Accept violations with written justification.

**Time**: 5 minutes
**Risk**: High (accumulating technical debt)
**Requirement**: Written justification for each CRITICAL violation

---

## 🚦 Next Steps

### If Status is 🔴 FAIL:

1. **Choose remediation option** (recommend Option 1: Auto-Fix)
2. **Apply fixes**
3. **Re-run review**: `/review-code`
4. **Verify tests pass**: `mvn clean verify`
5. **Repeat until** status is ✅ PASS
6. **Then commit**

### If Status is 🟡 NEEDS WORK:

1. **Review HIGH violations**
2. **Fix critical path issues**
3. **Document accepted MEDIUM violations** (if deferring)
4. **Run tests**: `mvn verify`
5. **Commit with note** about deferred fixes

### If Status is ✅ PASS:

1. **Final verification**: `mvn clean verify`
2. **Commit with confidence**
3. **Celebrate** 🎉

---

## 📈 Progress Tracking

### Previous Reviews (if applicable)
| Date | Critical | High | Medium | Status |
|------|----------|------|--------|--------|
| [Previous date] | [N] | [N] | [N] | [Status] |
| **Today** | **[N]** | **[N]** | **[N]** | **[Status]** |

**Improvement**: [X]% reduction in violations since last review

---

## 📚 Learning Resources

### For Violations Found:
- **Function Size**: [Link to Clean Code chapter or internal wiki]
- **Page Object Model**: [Link to Selenium docs or team guide]
- **Test Independence**: [Link to constitution or test best practices]

### Recommended Reading:
- Clean Code by Robert C. Martin (Chapters 3 & 10)
- [Your team's internal coding standards]
- Constitution: `.specify/memory/constitution.md`

---

**Generated By**: AI Code Quality Agent v1.0
**Review Timestamp**: [ISO-8601 timestamp]
**Confidence Level**: [High/Medium] (based on code complexity)

---

## 🤖 AI Agent Commands

**Auto-fix all violations**:
```
@qa-agent Fix all CRITICAL and HIGH violations
```

**Explain specific violation**:
```
@qa-agent Explain violation #3 in detail
```

**Show fix for specific violation**:
```
@qa-agent Show me how to fix violation #5
```

**Re-run review after fixes**:
```
/review-code
```
```

## Validation Checklist

Before completing review:
- [ ] All test code files scanned
- [ ] Constitutional principles checked
- [ ] Clean code principles checked
- [ ] Java best practices checked
- [ ] Test-specific patterns checked
- [ ] Severity assigned to each violation
- [ ] Auto-fix availability determined
- [ ] Gate decision made (PASS/FAIL)
- [ ] Report generated and saved

## Remediation Workflow

After generating report, offer interactive remediation:

```
Code Quality Review Complete

Found [N] total violations:
- 🔴 CRITICAL: [N] (blocking commit)
- 🟠 HIGH: [N] (recommended fixes)
- 🟡 MEDIUM: [N] (improvements)

Would you like me to:
[A] Auto-fix all CRITICAL and HIGH violations
[B] Show detailed fix for each violation
[C] Explain why these are violations
[D] Fix only CRITICAL violations
[E] Accept violations and document reasoning
[Q] Quit (commit blocked if CRITICAL violations exist)

Your choice:
```

Based on choice, proceed with appropriate action:

### Choice A: Auto-Fix
1. Apply refactoring for each violation
2. Save updated files
3. Compile code to verify
4. Re-run `/review-code` automatically
5. Show before/after comparison
6. Confirm user wants to keep changes

### Choice B: Show Detailed Fixes
1. Display each violation with:
   - Current code
   - Suggested fix
   - Explanation
   - Extraction strategy
2. Ask user to apply manually
3. Offer to re-run review after manual fixes

### Choice C: Explain Violations
1. Provide educational content for each violation
2. Link to constitution principles
3. Show examples from codebase
4. Offer learning resources

### Choice D: Fix Only Critical
1. Apply fixes for CRITICAL violations only
2. Document deferred HIGH/MEDIUM violations
3. Update report
4. Allow commit with warnings

### Choice E: Accept and Document
1. For each CRITICAL violation, ask for justification
2. Document justifications in report
3. Add TODO comments in code
4. Create technical debt ticket
5. Allow commit with documented exceptions

## Error Handling

- If no test code found: ERROR "No test code to review. Run /implement-tests first"
- If compilation fails after auto-fix: Rollback changes, report issue
- If constitution file missing: Use default clean code rules only, warn user
- If test framework not found: Check if tests exist, suggest running /implement-tests

## Output

After review completion:

1. Report file path: `specs/[STORY-KEY]/code-quality-report.md`
2. Summary of violations by severity
3. Gate decision: PASS or FAIL
4. Recommended next action
5. Estimated fix time
6. Auto-fix availability

If PASS:
```
✅ Code Quality Review PASSED

No CRITICAL violations found
[N] MEDIUM violations (acceptable for commit)

Quality Score: [X]%
Constitution Compliance: [X]%

✅ Ready to commit!

Suggested commit message:
"feat(test): Add [feature] test automation ([STORY-KEY])

- Implemented [N] test scenarios
- [Brief description of tests]
- All quality gates passed

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

If FAIL:
```
🔴 Code Quality Review FAILED

Found [N] CRITICAL violations (must fix)
Found [N] HIGH violations (should fix)

Top Issues:
1. [Brief description of violation]
2. [Brief description of violation]
3. [Brief description of violation]

Recommended Action: Run auto-fix
Command: @qa-agent Fix all CRITICAL and HIGH violations

After fixes, re-run: /review-code

🚫 DO NOT COMMIT until review passes
```

Context for review: $ARGUMENTS
