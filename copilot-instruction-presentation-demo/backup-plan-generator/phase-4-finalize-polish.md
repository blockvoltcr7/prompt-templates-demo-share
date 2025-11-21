# Phase 4: Security, Framework Patterns & Finalization

You are completing the GitHub Copilot instructions analysis.

---

## Prerequisites

**REQUIRED:** `.github/copilot-instructions.md` must have sections from Phases 1, 2, and 3.

If not, run all previous phases first.

---

## Hard Rules

1. **No Invention** - Only include security/framework patterns **verified to exist**
2. **Cite Evidence** - Format: `(path/to/file.ext:45-67)`
3. **Security First** - Document actual security patterns found

---

## Analysis Tasks

### 1. Framework-Specific Patterns

**For Backend (Spring Boot, Django, Express, FastAPI, etc.):**

Use **#search** and **#codebase** to find:
- Controller/route handler patterns
- Service layer patterns
- Repository/data access patterns
- DTO/model definitions
- Dependency injection usage
- Middleware/interceptors
- Request/response handling

**For Frontend (React, Vue, Angular, etc.):**

Use **#search** and **#codebase** to find:
- Component organization (functional, class-based)
- Props patterns (interfaces, prop-types)
- Hook usage patterns
- State management implementation
- API client patterns
- Form handling approach

### 2. Security Patterns

**Authentication & Authorization:**
- How is authentication implemented? (JWT, session, OAuth)
- Where is auth logic? (middleware, guards, decorators)
- Authorization patterns (RBAC, permissions, policies)

**Secret Management:**
- How are secrets handled? (env vars, vault, config service)
- Are there examples in .env.example?

**Input Validation:**
- Validation library (Zod, Joi, class-validator, etc.)
- Where validation happens (middleware, decorators, manual)

**API Security:**
- CORS configuration
- Rate limiting
- Security headers (helmet, CSP)

**Evidence:**
- Auth middleware files
- Validation schemas
- Security configuration files

---

## Output Instructions

**APPEND** the following sections to `.github/copilot-instructions.md`:

```markdown

## Framework-Specific Patterns

### [Framework Name - e.g., React, Spring Boot, Django]

**[For Backend - Choose relevant sections]**

**Controllers/Routes:**
- [Pattern for defining endpoints]
- [Example from codebase]

**Services:**
- [Business logic organization]
- [Example from codebase]

**Repositories/Data Access:**
- [Data access pattern]
- [Example from codebase]

**Dependency Injection:**
- [How DI is used: constructor injection, decorators, etc.]

**Request/Response Handling:**
- [DTO patterns, serialization, validation]

**[For Frontend - Choose relevant sections]**

**Components:**
- [Structure: functional with hooks, class-based, etc.]
- [Props patterns: TypeScript interfaces, prop-types]
- [File organization]

**State Management:**
- [Tool: Redux, Zustand, Context, etc.]
- [How state is organized]
- [Pattern for accessing/updating state]

**API Calls:**
- [Client library: fetch, axios, etc.]
- [Data fetching pattern: React Query, SWR, custom hooks]
- [Error handling for API calls]

**Styling:**
- [Approach: CSS modules, Tailwind, styled-components, etc.]
- [File organization for styles]

**Forms:**
- [Library: React Hook Form, Formik, custom]
- [Validation integration]

**Example Component:**
```[language]
[Show 15-20 line example from actual codebase]
```

**Evidence:** [3-5 representative files]

---

## Security & Best Practices

### Authentication & Authorization

**Authentication Method:**
- [e.g., JWT tokens, session-based, OAuth 2.0]

**Implementation:**
- [Where auth logic lives: middleware, guards, decorators]
- [Token storage: httpOnly cookies, localStorage, etc.]

**Authorization:**
- [Pattern: RBAC, permissions, policies]
- [How permissions are checked]

**Evidence:** [auth middleware, guards, config files]

### Secret Management

**Approach:**
- [Environment variables, vault, cloud secret manager]
- [How secrets are accessed in code]

**Required Environment Variables:**
- [List from .env.example if it exists]

**Evidence:** `.env.example`, config files

### Input Validation

**Validation Library:**
- [e.g., Zod, Joi, class-validator, Pydantic]

**Pattern:**
- [Where validation happens: middleware, route handlers, decorators]
- [Schema definition approach]

**Example:**
```[language]
[Show validation schema example from codebase]
```

**Evidence:** [validation files, schemas]

### API Security

**CORS:**
- [Configuration approach and allowed origins]

**Rate Limiting:**
- [If implemented, describe approach]

**Security Headers:**
- [Helmet, CSP, or other security middleware]

**Other Security Measures:**
- [CSRF protection, input sanitization, etc.]

**Evidence:** [security middleware, config files]

---

## Evidence References

**Configuration Files Analyzed:**
- `[file 1]` - [purpose]
- `[file 2]` - [purpose]
- `[file 3]` - [purpose]
- [List 5-10 key config files]

**Source Code Samples:**
- `[file 1]` - [what pattern it demonstrates]
- `[file 2]` - [what pattern it demonstrates]
- [List 5-10 representative source files]

**Test Examples:**
- `[file 1]` - [test type/purpose]
- `[file 2]` - [test type/purpose]
- [List 3-5 test files]

**Infrastructure/Deployment:**
- `[file 1]` - [purpose]
- `[file 2]` - [purpose]
- [List Docker, CI/CD, K8s files]

---

<!-- ALL PHASES COMPLETE -->

**Generated:** [Current UTC timestamp]
**Analysis Method:** Multi-phase codebase analysis (Phases 1-4)
**Coverage:** Technology Stack, Architecture, Testing, Security, Framework Patterns
```

---

## Final Polish Tasks

1. **Review the entire `.github/copilot-instructions.md` file**
2. **Verify:**
   - [ ] All sections flow logically
   - [ ] No duplicated content
   - [ ] All evidence citations are valid
   - [ ] No placeholder text remains
   - [ ] Headers use consistent formatting
   - [ ] Code examples use correct language tags
3. **Add missing sections** if any gaps exist
4. **Remove any generic advice** that doesn't match the actual codebase

---

## Validation Checklist

Before finalizing:
- [ ] Framework-specific section matches the actual framework used
- [ ] Security patterns are based on real implementations (not generic advice)
- [ ] All code examples are from actual files (cited)


**SAVE OUTPUT TO:** `.github/copilot-instructions.md` (appending to existing file)

**FINAL OUTPUT:** `.github/copilot-instructions.md` is complete and ready to use!

---

## Post-Completion

🎉 **ALL 4 PHASES COMPLETE!**

Tell the user:

> **Your `.github/copilot-instructions.md` file is now complete!**
>
> This file contains:
> - ✅ Technology stack with exact versions
> - ✅ Architecture guidelines and patterns
> - ✅ Coding standards with examples
> - ✅ Testing conventions
> - ✅ Development workflow
> - ✅ Security best practices
> - ✅ Framework-specific patterns
>
> **Next Steps:**
> 1. Review `.github/copilot-instructions.md` for accuracy
> 2. Test it with GitHub Copilot by asking it to generate code
> 3. Refine sections based on Copilot's output quality
> 4. Keep it updated as your codebase evolves
>
> **You can now close this chat session.** Your Copilot instructions are ready!
