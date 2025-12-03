# Copilot for QA Engineers - Live Demo Script

**Duration:** 15-20 minutes
**Audience:** Developers and QA Engineers
**Tech Stack:** Java, Serenity BDD, REST Assured, CSV/Database validation

---

## Opening Hook (2 min)

Start with code already on screen - a simple Java method.

**Say:** "Watch this."

```java
// validate that CSV row has valid email, non-empty name, and age between 18-120
public ValidationResult validateRow(String[] row) {
```

→ Tab. Done. Instant credibility.

---

## Demo 1: API Test Generation (4 min)

**Setup:** Have a simple REST endpoint spec or Swagger open

**Live demo:**
1. Open Copilot Chat (`Cmd+I` or `Ctrl+I`)
2. Type:
   ```
   Generate a Serenity BDD REST Assured test for a GET /users/{id} endpoint
   that returns 200 with user object containing id, name, email.
   Include happy path and 404 not found scenario.
   ```
3. Show the generated `@Steps` class and test structure

**Tip to audience:** "Notice I gave it the framework, endpoint, and scenarios - specificity gets better results"

---

## Demo 2: CSV Validation Logic (3 min)

**Say:** "This is what I do daily - validate data files"

**Live demo:**
1. Type comment:
   ```java
   // validate CSV file: check header row matches expected columns,
   // validate each data row has correct date format (yyyy-MM-dd),
   // amount is positive decimal, status is ACTIVE/INACTIVE
   public List<ValidationError> validateTransactionFile(File csvFile) {
   ```
2. Tab through the generation
3. Show how to refine: Select code → "Add logging for each validation failure"

---

## Demo 3: Database Test Helper (3 min)

**Live demo:**
1. Comment-driven:
   ```java
   // JDBC helper to verify user was inserted: query by email,
   // assert name and created_date within last 5 minutes
   ```
2. Or Chat: "Generate a method to compare two SQL result sets and return differences"

**Tip:** "Copilot knows JDBC, JPA, all of it - just tell it your pattern"

---

## Demo 4: Gherkin from Requirements (3 min)

**Setup:** Paste a user story or acceptance criteria in chat

**Live demo:**
```
Given this requirement:
"Users can reset their password via email. Link expires in 24 hours.
Must meet password complexity. Old password invalidated."

Generate Gherkin scenarios for Serenity BDD covering happy path,
expired link, invalid password, and reuse of old password.
```

→ Show generated `.feature` file structure

---

## Demo 5: Quick Wins Rapid Fire (2 min)

Fast demonstrations:
- Select confusing code → `/explain`
- Select test → `/doc` → Instant Javadoc
- After test failure in terminal → `@terminal what went wrong?`
- `@workspace where do we handle authentication in tests?`

---

## Close (1 min)

**Say:** "Three things to remember:"
1. **Comments are prompts** - write what you want, Tab to get it
2. **Be specific** - framework + context + expected behavior
3. **Iterate** - first result is a draft, refine it

---

## Prep Checklist

- [ ] Have a clean Java project open (your actual test framework)
- [ ] Pre-create empty test class files to demo in
- [ ] Have a sample CSV file ready
- [ ] Have a Swagger/API spec visible (or mock one)
- [ ] Test your demos once tonight - Copilot can vary
- [ ] **Backup:** Screenshot expected outputs in case Copilot hiccups live
