
You are a Senior DevOps Engineer & GitHub Copilot Configuration specialist. Analyze THIS repository and generate a comprehensive `.github/Copilot-instructions.md` that makes Copilot produce code consistent with our patterns, conventions, and architecture.

---

## 📋 Inputs (Fill BEFORE RUNNING)

**Primary Technology:**
[Input the primary technology here]

**Framework/Tech Details:**
[Input tech details]

**Project Context (1-3 lines):**
[Input a short description about this code repo]

**Scope:**

- [x]  Entire repository

---

## Hard Rules (Apply Throughout)

1. **No Invention**
   - Only include technologies, versions, configs, and patterns that you **verified exist** in this repo
   - If uncertain about a pattern, state it explicitly or omit it

2. **Be Prescriptive, Not Documentary**
   - Write clear instructions for how to write code (e.g., "Always use PascalCase for components")
   - Include code examples showing the pattern to follow
   - Focus on actionable guidance, not just describing what exists

3. **Respect Exclusions**
   - Ignore: `node_modules/`, `build/`, `dist/`, `target/`, `.gradle/`, `.git/`, `vendor`, large logs/binaries, generated reports, `.next/`, `__pycache__/`

4. **Security First**
   - Never suggest hardcoded secrets
   - Use config/env vars for all credentials
   - No plaintext passwords
   - No `Thread.sleep` in tests (prefer explicit waits/polling)
   - Follow least privilege principles
   - Always validate input, sanitize output

5. **Include Real Code Examples**
   - Every major pattern should have a 5-15 line code example
   - Examples should be taken from actual files in the repo
   - Show the preferred way to implement the pattern

---

## Workspace Analysis Tools

**Use ONLY these Github Copilot Chat tools for efficient analysis:**

| Tool | Purpose | When to Use |
| --- | --- | --- |
| **#codebase** | Find relevant file chunks, symbols, information | PRIMARY - Query configs, build files, CI/CD, architectural patterns, dependencies |
| **#search** | Search and read files in workspace | SECONDARY - Find specific patterns, imports, conventions across files |
| **#findTestFiles** | Locate test files for source files | TESTING - Discover test structure, naming conventions, frameworks |

**Tool Usage Priority:**

1. **Start with #codebase** - Most efficient for gathering context about tech stack, configs, and patterns
2. **Use #search** - When you need to verify specific patterns across multiple files or find examples
3. **Use #findTestFiles** - Only when analyzing testing conventions and structure

**DO NOT USE during analysis:**

- ❌ `#runCommands`, `#runTasks`, `#runTests` (no execution needed, wastes time)
- ❌ `#editFiles`, `#new` (analysis only, no editing)
- ❌ `#problems`, `#changes` (not needed for pattern discovery)
- ❌ `#openSimpleBrowser`, `#fetch`, `#extensions` (irrelevant to codebase analysis)

**Example Query Pattern:**

- ✅ “#codebase What build tool and dependencies are configured”
- ✅ “#search Find all import statements for React hooks”
- ✅ “#findTestFiles Locate test files for src/components/”

---

## 📋 Execution Plan

### Phase 1 - Codebase Discovery & Context

**Actions:**

1. Map top-level directories and understand module structure
2. Determine project type (monorepo, single app, library, full-stack, etc.)

**Output:**

- High-level repository structure
- Project type identification

**Note:** If patterns are inconsistent, document the preferred approach in "Precedence Rules"

---

### Phase 2 - Technology Stack & Pattern Analysis

**Technology Stack (Exact Versions):**

- Language(s) + version
- Build system + version
- Frameworks + versions
- Database/ORM/drivers
- Key libraries (logging, validation, HTTP client, security, API docs)
- Runtime environment (Node version, Java version, Python version)
- Container/orchestration tech

**Project Structure:**

- Module/package organization
- Layering approach (MVC, hexagonal, microservices, component-based, feature-sliced)
- Naming conventions (files, classes, functions, variables)
- Configuration management (env vars, config files, secrets)
- Directory structure standards

**Code Patterns:**

**For Backend Projects:**

- Routing/endpoint conventions (RESTful patterns, GraphQL schemas)
- Dependency injection patterns
- Repository/DAO patterns
- Service layer organization
- Error handling model & validation strategy
- Security flows (auth, authz, CORS, rate limiting)
- Configuration/property binding
- Database migration strategy

**For Frontend Projects:**

- Component structure (atomic design, feature-based, etc.)
- State management approach (Redux, Zustand, Context, etc.)
- Styling approach (CSS modules, styled-components, Tailwind, SCSS)
- API client patterns (fetch, axios, React Query, etc.)
- Routing conventions
- Form handling & validation
- Error boundaries & error handling

**For Full-Stack Projects:**

- API contract patterns (OpenAPI, GraphQL schema)
- Shared types/interfaces
- DTO patterns
- Auth flows across layers
- CORS configuration

**Precedence Rules (if mixed styles exist):**
State which pattern takes precedence when multiple styles are detected.

---

### Phase 3 - Testing Strategy

**Test Framework Detection:**

- Unit test framework (JUnit, PyTest, Jest, Vitest, etc.)
- Integration test approach (TestContainers, Supertest, etc.)
- E2E test framework (Playwright, Cypress, Selenium, etc.)
- Mocking/stubbing libraries (Mockito, Jest mocks, WireMock, MSW)
- Assertion style (expect, assert, should)

**Test Organization:**

- Test directory structure
- Naming conventions (`.test.ts`, `Test.java`, `test_*.py`)
- Fixture/setup patterns
- Test data management
- Parallel execution settings
- Coverage requirements/thresholds
- Reporting (Serenity, Allure, coverage reports)

---

### Phase 4 - Development Workflow & Tooling

**Code Quality & Formatting:**

- Linting configs (ESLint, Checkstyle, Pylint, golangci-lint)
- Formatting tools (Prettier, Black, gofmt, Spotless)
- Import ordering rules
- Pre-commit hooks (Husky, lint-staged, pre-commit)
- Editor configs (.editorconfig)

**CI/CD Pipeline:**

- Workflow files analyzed
- Build steps (compile, test, lint, security scan)
- Quality gates (test coverage, code quality scores)
- Deployment targets (environments)
- Branch strategy (if evident from CI config)
- Release process (tagging, versioning, changelogs)

**Build & Deployment:**

- Docker image build process
- Container orchestration (K8s, Helm, docker-compose)
- Environment configuration (dev, staging, prod)
- Secrets management approach
- Cloud SDK usage (AWS, Azure, GCP)
- Infrastructure as Code patterns

---

### Phase 5 - Security & Best Practices

**Security Patterns Detected:**

- Authentication approach (JWT, OAuth, session-based)
- Authorization patterns (RBAC, ABAC, policy-based)
- Secret management (env vars, vault, cloud secret managers)
- Input validation strategy
- Output encoding/sanitization
- API security (rate limiting, CORS, CSP)
- Dependency vulnerability scanning
- Secure defaults

**Anti-Patterns to Avoid:**

- Hardcoded credentials
- `Thread.sleep` in tests (use explicit waits)
- Raw `System.out.println` / `console.log` in production code
- Brittle XPath/CSS selectors (unless justified)
- Missing error handling
- Unvalidated user input
- SQL injection vulnerabilities
- Missing timeout/retry logic for external calls

---

### Phase 6 - Generate Final Output

Create `.github/copilot-instructions.md` with these sections **in this order:**

---

### 1. Header (Reproducibility & Metadata)

```markdown
> **Roles:** [Senior Software Engineer | Full-Stack Developer | Backend Developer | etc.]

**Generated:** [UTC timestamp]
**Primary Technology:** [tech stack]

```

---

### 2. Project Overview (2-5 Lines)

Brief description of what the system does, key modules/services, and primary use case.

---

### 3. Technology Stack (Exact Versions)

Table format:

```markdown
| Category | Technology | Version | Purpose |
|----------|------------|---------|---------|
| Language | [e.g., TypeScript] | [5.3.x] | Primary language |
| Runtime | [e.g., Node.js] | [20.x] | Execution environment |
| Framework | [e.g., React] | [18.x] | UI framework |
| ... | ... | ... | ... |

```

---

### 4. Architecture Guidelines

Describe how code should be organized and how modules should interact.

```markdown
**Layering:**
- [Describe layers and their responsibilities]
- [Example: Presentation → Business Logic → Data Access]

**Module Structure:**
- [Directory organization pattern]
- [Example: Feature-based, domain-driven, etc.]

**Dependency Flow:**
- [Which layers depend on which]
- [Example: Controllers depend on Services, Services depend on Repositories]

**Cross-Module Communication:**
- [How modules interact: APIs, events, shared types]

**Precedence Rules (if needed):**
- [If mixed patterns exist, state which pattern to follow]

```

**Optional - Include ASCII diagram if helpful for clarity:**
```
[Example of module relationships]
```

---

### 5. General Coding Standards

Prescribe how to write code in this project with clear rules and examples.

```markdown
**Naming Conventions:**
- Files: [pattern with example: `user-service.ts`, `UserService.java`]
- Classes/Components: [pattern with example: `UserService`, `LoginButton`]
- Functions: [pattern with example: `getUserById`, `handleSubmit`]
- Variables: [pattern with example: `userData`, `isLoading`]
- Constants: [pattern with example: `MAX_RETRIES`, `API_BASE_URL`]

**Directory Structure:**
- [Show the standard organization]
- [Example: src/features/, src/lib/, src/components/]

**Error Handling:**
Always wrap risky operations in proper error handling:

```[language]
// Example from codebase:
[5-15 line code example showing error handling pattern]
```

**Configuration Management:**
- [How to access config values]
- [Example: process.env.API_KEY, config.get('api.key')]
- Always use environment variables for secrets

**NEVER Do:**
- ❌ Hardcode secrets or credentials
- ❌ Use `Thread.sleep` in tests (use explicit waits)
- ❌ Use raw `console.log` / `System.out.println` in production code
- ❌ [Add other project-specific anti-patterns found]

```

---

### 6. Framework-Specific Patterns

Provide clear patterns with code examples for the specific framework used.

**[For Backend Projects: Spring Boot / Django / Express / FastAPI / etc.]**

```markdown
**Routing:**
[How to define endpoints - show example]

**Controllers/Handlers:**
[Pattern for request handling - show example]

**Services:**
[Business logic organization - show example]

**Data Access:**
[Repository/DAO pattern - show example]

**Dependency Injection:**
[How to inject dependencies - show example]

**Example Controller/Route:**
```[language]
[10-20 line example from actual codebase]
```

```

**[For Frontend Projects: React / Vue / Angular / Svelte / etc.]**

```markdown
**Component Structure:**
Always structure components as follows:

```[language]
[10-20 line component example from actual codebase]
```

**State Management:**
- [Tool used: Redux, Zustand, Context, Pinia, etc.]
- [Pattern for accessing state]
- [Pattern for updating state]

**Styling:**
- [Approach: CSS Modules, Tailwind, styled-components, etc.]
- [Example of how to style components]

**API Calls:**
- [Library: fetch, axios, etc.]
- [Data fetching pattern: React Query, SWR, custom hooks]
- Always handle loading and error states

**Forms:**
- [Library: React Hook Form, Formik, etc.]
- [Validation approach: Zod, Yup, etc.]

```

---

### 7. Security & Best Practices

Prescribe security patterns that must be followed.

```markdown
**Authentication & Authorization:**
- [Method: JWT, OAuth, session-based, etc.]
- [How to implement auth in new endpoints/components]
- [Example of protected route/endpoint]

**Secret Management:**
- ALWAYS use environment variables for secrets
- NEVER commit .env files
- [How secrets are accessed: process.env, config service, etc.]

**Input Validation:**
- [Validation library: Zod, Joi, class-validator, etc.]
- Always validate user input at entry points

```[language]
[Example validation schema from codebase]
```

**API Security:**
- [CORS configuration]
- [Rate limiting approach]
- [Security headers: helmet, CSP, etc.]

**Required Security Practices:**
- ✅ Validate all user input
- ✅ Use parameterized queries (prevent SQL injection)
- ✅ Sanitize output (prevent XSS)
- ✅ Use HTTPS in production
- ✅ Keep dependencies updated

```

---

### 8. Testing Conventions

Prescribe how to write tests with clear patterns and examples.

```markdown
**Test Structure:**
- Unit tests: [location and naming pattern]
- Integration tests: [location and framework]
- E2E tests: [framework and location]

**Framework:** [Jest, Vitest, JUnit, PyTest, etc.]

**Example Test Pattern:**
```[language]
[10-20 line test example from actual codebase showing:
 - Test structure (describe/it, test(), etc.)
 - Assertion style
 - Setup/teardown
 - Mocking approach]
```

**Mocking:**
- [Library: Jest mocks, Mockito, unittest.mock, etc.]
- [When to mock vs use real implementations]

**Test Data:**
- [Approach: fixtures, factories, builders]
- [Where test data lives]

**Coverage Requirements:**
- [Minimum threshold if configured]
- [What to exclude from coverage]

**Testing Rules:**
- ✅ Test business logic, not implementation details
- ✅ Use descriptive test names
- ✅ Keep tests isolated and independent
- ❌ Never use `Thread.sleep` or arbitrary timeouts
- ❌ Don't test framework/library code

```

---

### 9. Development Workflow

Describe the development process and tooling.

```markdown
**Code Formatting:**
- [Tool: Prettier, Black, gofmt, etc.]
- [Key settings: indent size, quotes, line length]

**Linting:**
- [Tool: ESLint, Checkstyle, Pylint, etc.]
- [Major rules or preset used]

**Pre-commit Hooks:**
- [Tool: Husky, pre-commit, etc.]
- [What runs: format, lint, type-check, tests]

**CI/CD Pipeline:**
Steps that run on every commit:
1. [Step 1: e.g., Install dependencies]
2. [Step 2: e.g., Run linter]
3. [Step 3: e.g., Run tests]
4. [Step 4: e.g., Build]
5. [Step 5: e.g., Deploy (if applicable)]

**Quality Gates:**
- [What must pass: tests, coverage, linting, etc.]

**Deployment:**
- [Where: Vercel, AWS, Docker registry, etc.]
- [When: on push to main, manual, on tag]

**Logging:**
- [Library: winston, pino, log4j, etc.]
- [Pattern for logging]

```

## **BEGIN ANALYSIS NOW**

---

## Final Reminders

**Key Principles:**
- Write **prescriptive instructions**, not documentary descriptions
- Include **real code examples** (5-20 lines) for every major pattern
- Focus on **how to write new code**, not just what currently exists
- Never invent versions, configs, or patterns - only use what you verify
- If uncertain about a pattern, state it explicitly or omit it
- Make it actionable: "Always do X" not "The codebase does X"

**Goal:**
Create instructions that make GitHub Copilot generate code that perfectly matches the project's patterns and conventions.

---