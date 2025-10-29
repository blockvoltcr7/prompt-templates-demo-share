# PR Review Template (Java • Selenium • REST Assured • DB • Gradle)

Use this after development, before merge. Keep it short: review the diff, tag changed files, flag blocking issues, summarize fixes.

---

## 1) Diff Scope

- Current branch: `git branch --show-current`
- Range:
  - On main: `git diff --name-only HEAD`
  - On feature branch: `git fetch origin main && git diff --name-only origin/main...HEAD`
- List changed files and proceed.

---

## 2) Categorize Changed Files (path-agnostic)

For each changed file, assign one or more tags based on content:
- Feature: ends with .feature
- Steps: Java file with @Given/@When/@Then
- Selenium/UI: imports org.openqa.selenium.*, WebDriver, By
- API (REST Assured): imports io.restassured.*, RequestSpecification, given(
- DB: imports java.sql.*, javax.sql.*, DataSource, jdbc:
- HTTP client: java.net.http.HttpClient, okhttp3, apache.http
- Config/Build: gradle files, serenity.properties/conf, junit-platform.properties, logback(-test).xml
- Other

Note: Use only the changed files for tagging; no repo-wide searches.

---

## 3) Blocking Checks (must fix)

Architecture
- Steps call Tasks/Interactions/Clients (no direct WebDriver/Rest Assured in step methods).
- Consistent abstraction boundaries (Page Objects/Screenplay or Client layers).

Selenium
- No Thread.sleep; use WebDriverWait/ExpectedConditions.
- Do not mix implicit and explicit waits.
- No static/shared WebDriver across tests; proper lifecycle per test/thread.
- Stable locators; avoid brittle XPaths.

REST Assured
- No hardcoded tokens/credentials/URLs.
- Reusable RequestSpecification (base URI, timeouts, default headers).
- Tests deterministic; no hidden dependency on external mutable state.

Database
- Connections closed (try-with-resources).
- Parameterized queries only; no string-concatenated SQL.
- Test data isolated and cleaned up (transactional rollback or Testcontainers).
- No secrets in code or committed configs.

Build/Runtime
- Gradle wrapper present; use ./gradlew.
- Java toolchain set to 17; build/tests pass locally.

Security
- Secrets masked in logs and reports; PII not exposed.

Mark any violation as: 🔴 BLOCKING with file:line and exact fix.

---

## 4) Quality Warnings (should fix)

BDD/Gherkin
- Clear Given/When/Then; business wording (no UI/control details).
- No duplicate/conflicting step regex; use parameter types.
- Consistent tag strategy (@smoke, @regression, @ui, @api, @db).

Maintainability
- Remove commented-out code and unused imports.
- Small, single-responsibility classes (Page Objects/Tasks/Clients).
- Configurable headless/cross-browser via properties.

API/DB
- Assertions cover status + key fields; mask sensitive logs.
- Idempotent setup/teardown; shared fixtures/utilities reused.

Build/CI
- Dependencies pinned; parallel execution safe.
- Publish Serenity/HTML reports if applicable.

Mark as: 🟡 WARNING with file:line and recommendation.

---

## 5) Summary & Remediation

- 🔴 Blocking:
  - [Issue] at file:line → [Specific fix]
- 🟡 Warnings:
  - [Issue] at file:line → [Recommendation]

Offer task creation:
> “Create ai_docs/tasks/PR_review_fixes.md to address blocking items?”

---

## 6) Quick Commands

- Run tests: `./gradlew clean test`
- Serenity report (if used): `./gradlew clean test aggregate` → `target/site/serenity/index.html`
- Filter by tags (Cucumber): `./gradlew test -Dcucumber.filter.tags="@smoke"`

Template v2 • Last Updated: October 29, 2025