# Phase 3: Testing Strategy & Development Workflow

You are continuing analysis to generate GitHub Copilot instructions.

---

## Prerequisites

**REQUIRED:** `.github/copilot-instructions.md` must have sections from Phase 1 and Phase 2.

If not, run phases 1 and 2 first.

---

## Hard Rules

1. **No Invention** - Only include test frameworks/tools that **actually exist** in the repo
2. **Cite Evidence** - Format: `(path/to/file.ext:45-67)`
3. **Respect Exclusions** - Ignore test artifacts, coverage reports, build outputs

---

## Analysis Tasks

### 1. Testing Framework Discovery

Use **#findTestFiles** and **#codebase** to find:

**Test Frameworks:**
- Unit testing: (Jest, Vitest, JUnit, PyTest, Go test, etc.)
- Integration testing: (Supertest, TestContainers, etc.)
- E2E testing: (Playwright, Cypress, Selenium, etc.)
- Mocking libraries: (Jest mocks, Mockito, unittest.mock, etc.)
- Assertion style: (expect, assert, should)

**Where to Look:**
- `package.json` devDependencies
- `pom.xml` test dependencies
- `requirements.txt` or `pyproject.toml` test deps
- Test configuration files (jest.config.js, vitest.config.ts, pytest.ini)

### 2. Test Organization

**Find Patterns for:**
- Test file location (co-located, separate `tests/` or `__tests__/` directory)
- Test file naming (`.test.ts`, `.spec.ts`, `Test.java`, `test_*.py`)
- Test structure (describe/it, test suites, fixtures)
- Setup/teardown patterns (beforeEach, setUp, fixtures)
- Test data management (factories, builders, fixtures, mocks)

### 3. Development Workflow

**Code Quality Tools:**
- Linters: ESLint, Checkstyle, Pylint, golangci-lint (check config files)
- Formatters: Prettier, Black, gofmt, Spotless (check config files)
- Pre-commit hooks: Husky, lint-staged, pre-commit framework
- Editor config: .editorconfig

**CI/CD Pipeline:**
- Analyze `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, etc.
- Build steps: compile, test, lint, security scan
- Quality gates: test coverage, code quality thresholds
- Deployment process

**Container/Build Workflow:**
- Docker build process (Dockerfile, docker-compose.yml)
- Deployment configs (K8s, Helm, etc.)

---

## Output Instructions

**APPEND** the following sections to `.github/copilot-instructions.md`:

```markdown

## Testing Conventions

### Test Framework & Structure

**Unit Tests:**
- Framework: [e.g., Jest, JUnit, PyTest]
- Location: [e.g., `src/**/*.test.ts`, `tests/unit/`, co-located with source]
- Naming: [e.g., `ComponentName.test.ts`, `test_function_name.py`]

**Integration Tests:**
- Framework: [e.g., Supertest, TestContainers]
- Location: [e.g., `tests/integration/`]
- Naming: [pattern]

**E2E Tests:**
- Framework: [e.g., Playwright, Cypress]
- Location: [e.g., `tests/e2e/`, `e2e/`]
- Naming: [e.g., `login.spec.ts`]

**Evidence:** [test config files, example test files]

### Test Patterns

**Assertion Style:**
- [e.g., expect(), assert statements, should syntax]

**Mocking/Stubbing:**
- Library: [e.g., Jest mocks, Mockito, unittest.mock]
- Pattern: [how mocks are created and used]

**Test Data:**
- [Factories, builders, fixtures approach]
- [Location of test data files]

**Coverage Requirements:**
- Threshold: [e.g., 80% minimum, if configured]
- Excluded paths: [e.g., config files, generated code]
- Reports: [where coverage reports are generated]

**Example Test Structure:**
```[language]
[Show 10-15 line example from actual test file]
```

**Evidence:** [2-3 representative test files]

---

## Development Workflow

### Code Quality & Formatting

**Linting:**
- Tool: [e.g., ESLint, Checkstyle]
- Config: [config file location]
- Rules: [major rules or extends config]

**Formatting:**
- Tool: [e.g., Prettier, Black]
- Config: [config file location]
- Settings: [e.g., 2-space indent, single quotes, etc.]

**Pre-commit Hooks:**
- Tool: [e.g., Husky + lint-staged, pre-commit]
- Checks: [what runs on pre-commit: lint, format, type-check]

**Evidence:**
- [.eslintrc, .prettierrc, .husky/, .pre-commit-config.yaml]

### CI/CD Pipeline

**Workflow File:** [e.g., `.github/workflows/ci.yml`]

**Build Steps:**
1. [e.g., Install dependencies]
2. [e.g., Run linter]
3. [e.g., Run tests]
4. [e.g., Build application]
5. [e.g., Deploy (if applicable)]

**Quality Gates:**
- [e.g., All tests must pass]
- [e.g., Coverage threshold must be met]
- [e.g., No linting errors]

**Deployment:**
- Targets: [e.g., Vercel, AWS, Docker registry]
- Trigger: [e.g., push to main, manual, tag]

**Evidence:** [CI/CD files]

### Container Workflow

**Docker Build:**
- Base image: [from Dockerfile]
- Build process: [multi-stage, single-stage]
- Image naming: [pattern]

**Container Orchestration:**
- [docker-compose services, K8s deployments, Helm charts]

**Evidence:** [Dockerfile, docker-compose.yml, K8s configs]

---

<!-- End of Phase 3 output -->

---

## ⚠️ IMPORTANT OUTPUT INSTRUCTIONS

**What to output:**
- ONLY the markdown sections above (Testing Conventions, Development Workflow)
- Include the evidence sections

**What NOT to output:**
- ❌ This validation checklist
- ❌ These output instructions
- ❌ Any meta-commentary about the analysis
- ❌ "SAVE OUTPUT", "NEXT STEP", or completion messages

**Validation checklist (for your reference, DO NOT include in output):**
- [ ] Test framework names match what's in package.json/dependencies
- [ ] Test file locations match actual project structure
- [ ] Example test structure is from actual test file (cited)
- [ ] CI/CD steps match actual workflow file
- [ ] Linter/formatter configs are verified to exist
- [ ] All evidence files are cited
