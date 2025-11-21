
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
Only include technologies, versions, configs, and patterns that you **verified exist** in this repo.
2. **Cite Evidence**
Every major section must list the files (and when possible, line ranges) you referenced.
Format: `(path/to/file.ext:45-67)` on `(path/to/file.ext)` if line ranges aren’t critical.
3. **Respect Exclusions**
Ignore: `node_modules/`, `build/`, `dist/`, `target/`, `.gradle/`, `.git/`, `vendor`, large logs/binaries, generated reports, `.next/`, `__pycache__/`
4. **Prefer Truth Sources**
Priority order for evidence:
    1. Build files (`package.json`, `pom.xml`, `build.gradle`, `requirements.txt`, `go.mod`)
    2. Lockfiles (`package-lock.json`, `pom.xml` resolved deps, `poetry.lock`, `go.sum`)
    3. Source code patterns
    4. Infrastructure as Code (`Dockerfile`, `docker-compose.yml`, `helm/`, `terraform/`)
    5. Application configs (`application*.yml`, `config/`, `.env.example`)
    6. CI/CD configs (`.github/workflows/*`, `Jenkinsfile`, `.gitlab-ci.yml`)
5. **Security Defaults**
- Never suggest hardcoded secrets
- Use config/env vars for all credentials
- No plaintext passwords
- No `Thread.sleep` in tests (prefer explicit waits/polling)
- Follow least privilege principles
- Always validate input, sanitize output
1. **Evidence Quality Over Quantity**
- Inline citations for critical patterns
- Summary evidence bullets at section end

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

1. Record the current UTC timestamp
2. Identify which Copilot workspace tools are enabled/available
3. Map top-level directories and understand module structure
4. Determine project type (monorepo, single app, library, full-stack, etc.)

**Output:**

- High-level repository structure
- Evidence list: key files read with their purpose

**Handle Edge Cases:**

- If patterns are inconsistent, note this and use “Precedence Rules” later
- If no clear structure exists, state this explicitly

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

**Evidence:** List files and line ranges that demonstrate each pattern.

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

**Evidence:** Representative test files and test configs.

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

**Evidence:** CI/CD files, Dockerfiles, deployment configs.

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

**Evidence:** Security configs, auth middleware, validation examples.

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

**Evidence:** `README.md`, root-level docs.

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

**Evidence:**

- `package.json:12-45`
- `tsconfig.json:2-10`

---

### 4. Architecture Guidelines

```markdown
- **Layering:** [Describe layers and their responsibilities]
- **Module Structure:** [Directory organization]
- **Dependency Flow:** [Which layers depend on which]
- **Cross-Module Communication:** [APIs, events, shared types]
- **Precedence Rules:** [If mixed patterns exist, state which wins]

```

**ASCII Diagram (if useful):**

```
[Example of module relationships]

```

**Evidence:** [List files demonstrating architecture]

---

### 5. General Coding Standards

```markdown
**Naming Conventions:**
- Files: [pattern]
- Classes/Components: [pattern]
- Functions: [pattern]
- Variables: [pattern]
- Constants: [pattern]

**Package/Directory Structure:**
- [Standard organization]

**Error Handling:**
- [Strategy for errors, logging patterns]

**Configuration Patterns:**
- [How config is managed]

**Performance Considerations:**
- [Any caching, optimization patterns]

**NEVER Do:**
- ❌ Hardcode secrets or credentials
- ❌ Use `Thread.sleep` in tests (use explicit waits)
- ❌ Use brittle selectors without justification
- ❌ Use raw `System.out.println` / `console.log` in production
- ❌ [Other project-specific anti-patterns]

```

**Evidence:** [Files demonstrating standards]

---

### 6. Framework-Specific Patterns

**[For Backend: Spring Boot / Django / Express / etc.]**

```markdown
- **Routing:** [Convention for defining endpoints]
- **Controllers:** [Pattern and organization]
- **Services:** [Business logic layer patterns]
- **Repositories/DAOs:** [Data access patterns]
- **DTOs/Models:** [Data transfer objects]
- **Dependency Injection:** [How DI is used]
- **Exception Handling:** [Global handlers, custom exceptions]

```

**[For Frontend: React / Vue / Angular / etc.]**

```markdown
- **Component Structure:** [File organization, props patterns]
- **State Management:** [Redux/Zustand/Context patterns]
- **Styling:** [CSS modules/Tailwind/styled-components]
- **API Calls:** [fetch/axios/React Query patterns]
- **Forms:** [Validation, submission patterns]
- **Routing:** [React Router patterns]

```

**Evidence:** [Representative files]

---

### 7. Security & Best Practices

```markdown
**Authentication & Authorization:**
- [How auth is implemented]

**Secret Management:**
- [Environment variables, vault, etc.]

**Input Validation:**
- [Validation library and patterns]

**API Security:**
- [CORS, rate limiting, headers]

**Dependency Management:**
- [Update policy, vulnerability scanning]

**Secure Defaults:**
- [HTTPS, secure cookies, CSP, etc.]

```

**Evidence:** [Security middleware, config files]

---

### 8. Testing Conventions

```markdown
**Test Structure:**
- Unit tests: [location, naming, framework]
- Integration tests: [approach]
- E2E tests: [framework, patterns]

**Assertion Style:**
- [expect/assert/should patterns]

**Mocking/Stubbing:**
- [Library and patterns]

**Test Data:**
- [Fixtures, factories, builders]

**Parallelization:**
- [Settings and approach]

**Coverage:**
- [Thresholds, excluded paths]

**Reporting:**
- [Where reports go, formats]

```

**Evidence:** [Test files and configs]

---

### 9. Development Workflow

```markdown
**Code Formatting:**
- [Prettier/ESLint/etc. configs]

**Linting:**
- [Rules and configs]

**Pre-commit Hooks:**
- [Husky/lint-staged setup]

**CI/CD Pipeline:**
- [Steps: build, test, lint, deploy]
- [Quality gates]
- [Environments]

**Versioning & Releases:**
- [Semantic versioning, changelog, tagging]

**Container Workflow:**
- [Docker build, compose, K8s/Helm]

**Observability:**
- [Logging, metrics, tracing setup]

```

**Evidence:** [CI files, configs, scripts]

---

### 10. Evidence References

```markdown
**Configuration Files Analyzed:**
- [List all config files examined with their purpose]

**Source Code Samples:**
- [Key source files that informed patterns]

**Test Examples:**
- [Test files reviewed]

**Infrastructure/Deployment:**
- [Docker, K8s, CI/CD files]

```

---

## **BEGIN ANALYSIS NOW**

---

## Final Reminders

- Every claim must be backed by actual files in the repo
- Never invent versions, configs, or patterns
- If uncertain, state it explicitly
- Focus on what exists, not what’s ideal
- Use workspace tools efficiently - start with #codebase
- Cite evidence inline and summarize at section ends
- This template ensures Copilot generates code that matches your actual repository patterns, not generic best practices

---

## Example Final Output Structure

```markdown
# GitHub Copilot Instructions

> Auto-generated on [TIMESTAMP] by analyzing this repository
> **Role:** Senior Software Engineer

## Project Overview

[2-5 line description of the system]

**Evidence:** `README.md`, root-level docs

---

## Technology Stack

| Category | Technology | Version | Purpose |
|----------|------------|---------|---------|
| Language | TypeScript | 5.3.x | Primary language |
| Runtime | Node.js | 20.x | Execution environment |
| Framework | React | 18.x | UI framework |
| Build | Vite | 5.x | Build tool |
| ... | ... | ... | ... |

**Evidence:**
- `package.json:12-45`
- `tsconfig.json:2-10`

---

## Architecture Guidelines

**Layering:**
- Presentation layer (React components)
- Business logic layer (hooks, services)
- Data access layer (API clients)

**Module Structure:**
- Feature-based organization under `/src/features`
- Shared utilities in `/src/lib`
- Type definitions in `/src/types`

**Dependency Flow:**
Components → Hooks → Services → API Clients

**Cross-Module Communication:**
- Shared types via TypeScript interfaces
- Event bus for decoupled features
- Context API for global state

**Evidence:** `src/` directory structure, import patterns across codebase

---

## General Coding Standards

**Naming Conventions:**
- Files: `kebab-case.tsx`
- Components: `PascalCase`
- Functions: `camelCase`
- Variables: `camelCase`
- Constants: `UPPER_SNAKE_CASE`

**Package/Directory Structure:**

```

src/
features/
feature-name/
components/
hooks/
services/
lib/
types/

```
**Error Handling:**
- Try-catch for async operations
- Error boundaries for component errors
- Custom error classes for domain errors

**Configuration Patterns:**
- Environment variables via `.env` files
- Type-safe config via TypeScript

**NEVER Do:**
- ❌ Hardcode API keys or secrets
- ❌ Use `console.log` in production code
- ❌ Bypass TypeScript type checking with `any`

**Evidence:**
- `src/features/auth/components/LoginForm.tsx:45-67`
- `src/lib/config.ts:1-20`

---

## Framework-Specific Patterns

### React Patterns

**Component Structure:**
- Functional components with hooks
- Props interfaces defined inline or in separate file
- Export components as named exports

**State Management:**
- Zustand for global state
- React Query for server state
- useState for local component state

**Styling:**
- Tailwind utility classes
- CSS modules for complex components

**API Calls:**
- React Query hooks for data fetching
- Axios for HTTP client

**Forms:**
- React Hook Form for form handling
- Zod for validation

**Evidence:**
- `src/features/dashboard/components/Dashboard.tsx`
- `src/lib/api/client.ts`

---

## Security & Best Practices

**Authentication & Authorization:**
- JWT-based authentication
- Token stored in httpOnly cookies
- Role-based access control

**Secret Management:**
- Environment variables for all secrets
- Never commit `.env` files

**Input Validation:**
- Zod schemas for runtime validation
- TypeScript for compile-time type safety

**API Security:**
- CORS configured for specific origins
- Rate limiting on API routes
- CSRF protection enabled

**Evidence:**
- `src/middleware/auth.ts`
- `.env.example`

---

## Testing Conventions

**Test Structure:**
- Unit tests: `*.test.ts` alongside source files
- Integration tests: `tests/integration/`
- E2E tests: `tests/e2e/` using Playwright

**Assertion Style:**
- Vitest with `expect` assertions

**Mocking/Stubbing:**
- Vitest mocks for modules
- MSW for API mocking

**Test Data:**
- Factory functions in `tests/factories/`

**Coverage:**
- Minimum 80% coverage required
- Exclude `*.config.ts` files

**Evidence:**
- `src/features/auth/services/auth.test.ts`
- `vitest.config.ts`

---

## Development Workflow

**Code Formatting:**
- Prettier with 2-space indents
- Single quotes for strings

**Linting:**
- ESLint with TypeScript rules
- Import ordering via eslint-plugin-import

**Pre-commit Hooks:**
- Husky + lint-staged
- Runs: lint, format, type-check

**CI/CD Pipeline:**
- GitHub Actions workflow
- Steps: install, lint, test, build
- Deploy to Vercel on main branch

**Versioning:**
- Semantic versioning
- Conventional commits for changelog

**Evidence:**
- `.github/workflows/ci.yml`
- `package.json` scripts

---

## Evidence References

**Configuration Files Analyzed:**
- `package.json` - Dependencies and scripts
- `tsconfig.json` - TypeScript configuration
- `vite.config.ts` - Build configuration
- `.eslintrc.json` - Linting rules
- `.github/workflows/ci.yml` - CI/CD pipeline

**Source Code Samples:**
- `src/features/auth/` - Authentication patterns
- `src/lib/api/` - API client patterns
- `src/components/ui/` - Shared component patterns

**Test Examples:**
- `src/features/auth/services/auth.test.ts`
- `tests/e2e/login.spec.ts`

**Infrastructure:**
- `Dockerfile` - Container build process
- `vercel.json` - Deployment configuration

```

---