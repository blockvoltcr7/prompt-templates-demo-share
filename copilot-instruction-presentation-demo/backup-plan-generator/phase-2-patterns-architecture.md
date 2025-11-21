# Phase 2: Code Patterns & Architecture Analysis

You are continuing analysis to generate GitHub Copilot instructions.

---

## Prerequisites

**REQUIRED:** `.github/copilot-instructions.md` must exist from Phase 1.

If it doesn't exist, run `phase-1-tech-stack-discovery.md` first.

---

## Hard Rules

1. **No Invention** - Only include patterns you **verified exist** in source code
2. **Cite Evidence** - Format: `(path/to/file.ext:45-67)`
3. **Respect Exclusions** - Ignore: `node_modules/`, `build/`, `dist/`, `.git/`

---

## Analysis Tasks

Use **#search** and **#codebase** to find:

### 1. Architecture & Layering

**Questions to Answer:**
- What layering approach is used? (MVC, hexagonal, microservices, feature-sliced, component-based)
- How do modules/layers communicate?
- What's the dependency flow? (e.g., Controllers → Services → Repositories)
- Are there shared types/interfaces?

**Where to Look:**
- Import statements across files
- Directory structure patterns
- Module boundaries

### 2. Naming Conventions

**Find actual examples of:**
- File naming: (kebab-case.ts, PascalCase.tsx, snake_case.py)
- Class/Component naming: (PascalCase, camelCase)
- Function naming: (camelCase, snake_case)
- Variable naming: (camelCase, snake_case)
- Constants: (UPPER_SNAKE_CASE, SCREAMING_SNAKE_CASE)

**Use #search queries like:**
- "class " to find class definitions
- "function " or "const " to find function patterns
- "export const" to find exported constants

### 3. Code Patterns

**For Backend Projects:**
- **Routing**: How are endpoints defined? (decorators, router files, controllers)
- **Dependency Injection**: Constructor injection, property injection, framework DI?
- **Repository/DAO**: Data access patterns
- **Service Layer**: Business logic organization
- **Error Handling**: Try-catch patterns, error classes, global handlers
- **Validation**: Input validation approach (decorators, middleware, libraries)
- **Authentication/Authorization**: Middleware, guards, decorators

**For Frontend Projects:**
- **Component Structure**: Functional vs class, hooks usage
- **State Management**: Redux, Zustand, Context, Recoil, etc.
- **Styling**: CSS modules, styled-components, Tailwind, SCSS
- **API Calls**: fetch, axios, React Query, SWR
- **Form Handling**: React Hook Form, Formik, custom
- **Routing**: React Router, Next.js, Vue Router patterns

### 4. Anti-Patterns to Document

Find examples of what NOT to do:
- Hardcoded values that should be config
- Missing error handling
- Security issues (if any are evident)

---

## Output Instructions

Generate ONLY the following sections and output them directly:

```markdown

## Architecture Guidelines

**Layering Approach:**
- [Describe the layers: e.g., Presentation → Business Logic → Data Access]
- [How layers communicate]
- [Dependency flow direction]

**Module Structure:**
- [How code is organized into modules/features]
- [Module boundaries and responsibilities]
- [Cross-module communication patterns]

**Dependency Flow:**
- [Which layers/modules depend on which]
- [Example: Controllers → Services → Repositories]

**Evidence:**
- [3-5 key files demonstrating architecture]

**NOTE:** Do NOT generate directory structure tree here - Phase 1 already created the Repository Structure section.

---

## Coding Standards

### Naming Conventions

**Files:** [pattern with example: `user-service.ts`, `UserService.java`]

**Classes/Components:** [pattern with example: `UserService`, `LoginForm`]

**Functions:** [pattern with example: `getUserById`, `handle_user_login`]

**Variables:** [pattern with example: `userData`, `user_count`]

**Constants:** [pattern with example: `API_BASE_URL`, `MAX_RETRY_COUNT`]

**Evidence:** [2-3 example files showing these patterns]

### Error Handling

- [Describe error handling strategy: try-catch, error boundaries, global handlers]
- [Custom error classes or standard errors]
- [Logging approach]

**Example Pattern:**
```[language]
[Show 5-10 line code example from actual codebase]
```

**Evidence:** [1-2 files showing error handling]

### Configuration Patterns

- [How config values are accessed: process.env, config service, dependency injection]
- [Type safety for config: interfaces, schemas, validation]
- [Environment-specific config: .env files, config files per env]

**Evidence:** [config files, env examples]

### NEVER Do

**❌ Hardcode Secrets**
- Always use environment variables or secret management

**❌ Missing Error Handling**
- [If you find this pattern, document it]

**❌ [Other anti-patterns found]**
- [Document any other anti-patterns discovered]

**Evidence:** [Files demonstrating these rules]

---

<!-- End of Phase 2 output -->

---

## ⚠️ IMPORTANT OUTPUT INSTRUCTIONS

**What to output:**
- ONLY the markdown sections above (Architecture Guidelines, Coding Standards)
- Include the evidence sections

**What NOT to output:**
- ❌ This validation checklist
- ❌ These output instructions
- ❌ Any meta-commentary about the analysis
- ❌ "SAVE OUTPUT", "NEXT STEP", or completion messages
- ❌ Directory structure trees (Phase 1 already created that)

**Validation checklist (for your reference, DO NOT include in output):**
- [ ] Architecture section describes ACTUAL layers found in code
- [ ] Naming conventions include real examples from the repo
- [ ] Error handling pattern includes code example from actual file
- [ ] All patterns cite evidence files
- [ ] NEVER section lists real issues to avoid (not generic advice)
