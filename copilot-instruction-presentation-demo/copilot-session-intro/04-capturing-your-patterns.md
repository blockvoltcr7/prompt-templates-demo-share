# Capturing Your Team's Patterns for Copilot

**Problem:** You tell Copilot "follow our patterns" but Copilot doesn't know your patterns unless you show them.

**Solution:** Extract and document your existing patterns so you can feed them as context.

---

## Why This Matters

```
Prompt without pattern:    "Generate a REST Assured test"
Result:                    Generic code that doesn't match your style

Prompt with pattern:       "Generate a REST Assured test following this example: [your code]"
Result:                    Code that matches your team's conventions
```

Copilot is a pattern-matching machine. Feed it YOUR patterns, get YOUR style back.

---

## What Patterns to Capture

### For QA/Test Automation

| Pattern Type | What to Extract | Why It Matters |
|--------------|-----------------|----------------|
| Step Definitions | A complete step def class | Shows your Given/When/Then style |
| API Client | How you wrap REST Assured | Shows your request/response handling |
| Page Objects | A UI page object | Shows your locator and action patterns |
| Test Data | How you create/manage data | Shows builders, factories, data providers |
| Assertions | Common assertion patterns | Shows your verification style |
| Hooks | Before/After setup | Shows your test lifecycle management |
| Configuration | How you handle environments | Shows your config approach |

### For Developers

| Pattern Type | What to Extract | Why It Matters |
|--------------|-----------------|----------------|
| Service Class | A typical service | Shows your business logic structure |
| Repository | Data access pattern | Shows your DB interaction style |
| Controller/API | Endpoint handling | Shows your request/response structure |
| DTOs/Models | Data objects | Shows your naming and structure |
| Error Handling | Exception patterns | Shows your error management |
| Validation | Input validation | Shows your validation approach |

---

## How to Extract Patterns

### Step 1: Identify Your Best Examples

Find code that represents "how we do things here":
- Recently reviewed and approved code
- Code that senior team members wrote
- Code that's been stable (not constantly refactored)

**Ask yourself:** "If a new team member asked how to write X, which file would I point them to?"

### Step 2: Create a Patterns Folder

```
your-project/
├── AI-docs/
│   ├── jira/                    # Task context (from workflow doc)
│   └── patterns/                # Your team patterns
│       ├── step-definition-pattern.java
│       ├── api-client-pattern.java
│       ├── test-data-pattern.java
│       ├── assertion-pattern.java
│       └── README.md            # Index of patterns
```

### Step 3: Extract Clean Examples

Take your best code and strip it to the essential pattern.

**Before (real code with specifics):**
```java
public class UserApiSteps {

    @Steps
    private UserApiClient userApiClient;

    private Response lastResponse;
    private User createdUser;

    @Given("a user exists with email {string}")
    public void userExistsWithEmail(String email) {
        createdUser = TestDataFactory.createUser().withEmail(email).build();
        lastResponse = userApiClient.createUser(createdUser);
        assertThat(lastResponse.statusCode()).isEqualTo(201);
    }

    @When("I request the user by ID")
    public void requestUserById() {
        lastResponse = userApiClient.getUser(createdUser.getId());
    }

    @Then("the response status should be {int}")
    public void responseStatusShouldBe(int expectedStatus) {
        assertThat(lastResponse.statusCode()).isEqualTo(expectedStatus);
    }

    @Then("the response should contain user details")
    public void responseShouldContainUserDetails() {
        User returnedUser = lastResponse.as(User.class);
        assertThat(returnedUser.getEmail()).isEqualTo(createdUser.getEmail());
        assertThat(returnedUser.getName()).isEqualTo(createdUser.getName());
    }
}
```

**After (pattern with annotations):**
```java
/**
 * PATTERN: Serenity BDD Step Definition
 *
 * Structure:
 * - Use @Steps for Serenity action classes (API clients, page objects)
 * - Store response and created entities as instance variables
 * - Given: Setup/preconditions, often creates data
 * - When: The action being tested
 * - Then: Assertions using AssertJ
 *
 * Conventions:
 * - Class name: [Feature]ApiSteps or [Feature]UiSteps
 * - Use TestDataFactory for test data creation
 * - Use builder pattern for flexible data setup
 * - Assert status codes explicitly
 * - Deserialize responses for detailed assertions
 */
public class [Feature]ApiSteps {

    @Steps
    private [Feature]ApiClient apiClient;      // API interactions

    private Response lastResponse;              // Store for assertions
    private [Entity] created[Entity];           // Track created data

    @Given("[precondition description] {string}")
    public void setupPrecondition(String param) {
        // 1. Create test data using factory + builder
        // 2. Make API call to set up state
        // 3. Assert setup succeeded
    }

    @When("[action description]")
    public void performAction() {
        // Single API call - the action under test
        // Store response for Then steps
    }

    @Then("[expected outcome] {int}")
    public void verifyOutcome(int expected) {
        // AssertJ assertions
        // assertThat(actual).isEqualTo(expected);
    }

    @Then("[detailed verification]")
    public void verifyDetails() {
        // Deserialize response
        // Assert multiple fields
    }
}
```

---

## Pattern Template

Use this structure when documenting patterns:

```java
/**
 * PATTERN: [Pattern Name]
 *
 * Purpose:
 * [What this pattern is for]
 *
 * When to use:
 * [Scenarios where this applies]
 *
 * Structure:
 * [Key structural elements]
 *
 * Conventions:
 * - [Convention 1]
 * - [Convention 2]
 * - [Convention 3]
 *
 * Anti-patterns to avoid:
 * - [What NOT to do]
 */
```

---

## Using Patterns in Prompts

### Bad (no pattern context):
```
Generate step definitions for user authentication tests
```

### Good (with pattern context):
```
Generate step definitions for user authentication tests.

Follow this pattern from our codebase:
[Paste your step-definition-pattern.java]

Requirements:
- Use our UserApiClient for API calls
- Use TestDataFactory for test data
- Follow the same Given/When/Then structure
- Use AssertJ for assertions
```

### Best (reference file directly):
```
@workspace Look at AI-docs/patterns/step-definition-pattern.java

Generate step definitions for password reset feature following that exact pattern.
The API client is PasswordApiClient.
```

---

## Patterns Index Template (README.md)

Create this in your `AI-docs/patterns/` folder:

```markdown
# Team Patterns for AI-Assisted Development

## How to Use
Reference these patterns when prompting Copilot to ensure generated code matches our conventions.

## Available Patterns

### Test Automation
| Pattern | File | Use When |
|---------|------|----------|
| Step Definition | step-definition-pattern.java | Writing new Cucumber steps |
| API Client | api-client-pattern.java | Creating new API interaction classes |
| Test Data Factory | test-data-pattern.java | Building test data |
| Page Object | page-object-pattern.java | Creating UI test pages |

### Backend Development
| Pattern | File | Use When |
|---------|------|----------|
| Service Class | service-pattern.java | Writing business logic |
| Repository | repository-pattern.java | Data access layer |
| Controller | controller-pattern.java | REST endpoints |

## Pattern Update Process
1. Propose change in team meeting
2. Update pattern file
3. Notify team in Slack/Teams
```

---

## Live Demo: Extracting a Pattern

**Step 1:** Find good example
```
"Let me show you our UserApiSteps - this is how we write step definitions"
```

**Step 2:** Copy to patterns folder
```bash
cp src/test/java/.../UserApiSteps.java AI-docs/patterns/step-definition-pattern.java
```

**Step 3:** Add pattern annotations
```
Add the PATTERN comment block explaining structure and conventions
```

**Step 4:** Use in prompt
```
"Now when I tell Copilot to generate steps, I reference this file"
```

---

## Key Takeaways

1. **Copilot mirrors what you show it** - Show good patterns, get good code
2. **Extract once, use forever** - One pattern file serves all future prompts
3. **Patterns evolve** - Update them as your conventions improve
4. **Team alignment** - Everyone uses the same patterns = consistent codebase
5. **New team member onboarding** - Patterns folder teaches conventions instantly

---

## Checklist: Pattern Extraction

- [ ] Identified best examples for each pattern type
- [ ] Created `AI-docs/patterns/` folder
- [ ] Extracted step definition pattern
- [ ] Extracted API client pattern
- [ ] Extracted test data pattern
- [ ] Added pattern annotations/comments
- [ ] Created patterns README index
- [ ] Tested prompts using patterns produce correct output
