# Follow-Up Prompt: Generate Path-Specific Copilot Instruction Files

## Role

You are a **GitHub Copilot Configuration Specialist**. Your task is to create **path-specific instruction files (playbooks)** that augment the comprehensive monolithic `.github/copilot-instructions.md` file with focused, contextual guidance for specific technologies and file types.

**Goal:** Eliminate noise. When a developer edits `UserController.java`, they need Java/Spring Boot patterns—not React hooks or Python decorators. Each playbook provides laser-focused guidance for one technology area, removing irrelevant patterns from other technologies.

## Role & Context

You are tasked with creating **path-specific instruction playbooks** that augment and specialize the patterns from a monolithic `.github/copilot-instructions.md` file.

**Your Input:**
- The complete, approved `.github/copilot-instructions.md` file (provided below or as context)
- Access to the repository codebase for validation

**Your Goal:**
Create specialized `.github/instructions/*.instructions.md` files that apply focused, context-specific guidance based on the file being edited, while **keeping the monolithic copilot-instructions.md complete and comprehensive**.

**CRITICAL Understanding:**
- The monolithic `.github/copilot-instructions.md` file is ALWAYS loaded at the start of every Copilot session
- Specialized `.github/instructions/*.instructions.md` files are loaded ADDITIONALLY when editing files that match their `applyTo` patterns
- Specialized files AUGMENT (not replace) the monolithic file with focused guidance
- The monolithic file should remain COMPLETE and comprehensive for full session context

---

## Quick Reference: What This Prompt Does

**Input:** Approved `.github/copilot-instructions.md` file + access to codebase

**Output:**
1. Specialized instruction playbooks in `.github/instructions/`:
   - `springboot.instructions.md` (or `backend.instructions.md`)
   - `react.instructions.md` (or `frontend.instructions.md`)
   - `tests.instructions.md`
   - Additional technology-specific playbooks as identified

2. Reference section appended to `.github/copilot-instructions.md` listing all playbooks

**Key Principle:** Monolithic file stays COMPLETE. Specialized playbooks AUGMENT it with focused guidance. Both work together.

**Quality Goals for Each Playbook:**
- ✅ Focused on 1 technology area (eliminate patterns from other technologies)
- ✅ Evidence paths all match the `applyTo` pattern
- ✅ Actionable patterns (not just theory)
- ✅ Typical length: 50-200 lines (focused, not exhaustive)

**Execution:** 6 phases → Analyze → Plan → Create → Validate → Append References → Done

---

## Execution Plan

### Phase 1: Analyze the Monolithic File

**Step 1.1: Identify Technology Boundaries**

Scan the monolithic `.github/copilot-instructions.md` and identify distinct technology/framework sections by looking for:
- **Framework-Specific Patterns** sections (Spring Boot, React, Django, etc.)
- **Testing Conventions** (if test frameworks differ from production code patterns)
- **Directory-specific patterns** mentioned in Evidence blocks
- **Language-specific sections** (Java, Python, TypeScript, etc.)
- **Functional areas** (API layer, database layer, UI components)

**Step 1.2: Map Evidence to Directory Patterns**

For each section identified above, extract all file paths from the `**Evidence:**` blocks and determine:
1. **Common directory prefix** (e.g., all paths start with `src/main/java/`)
2. **File extension patterns** (e.g., `.java`, `.tsx`, `.py`)
3. **Functional grouping** (e.g., all test files, all frontend components)

**Output:** A mapping table like:
```
Section: "Spring Boot Backend Patterns"
Evidence Paths: src/main/java/com/example/UserController.java, src/main/java/com/example/UserService.java
Common Prefix: src/main/java/
File Extensions: .java
Proposed applyTo: "src/main/java/**/*.java"
Proposed Filename: backend.instructions.md (or springboot.instructions.md)
```

---

### Phase 2: Identify Content for Specialized Files (Don't Touch Monolithic File Yet)

**CRITICAL:** Do NOT modify `.github/copilot-instructions.md` in this phase. We're only analyzing and planning what to extract. The monolithic file will be updated in the FINAL phase after all specialized files are created.

**Step 2.1: Understand What Stays in Monolithic File**

The monolithic `.github/copilot-instructions.md` contains ALL sections and will remain COMPLETE:
- ✅ **Project Overview** (2-5 line description)
- ✅ **Technology Stack** (all languages/frameworks)
- ✅ **Architecture Guidelines** (complete system architecture)
- ✅ **General Coding Standards** (naming conventions, error handling)
- ✅ **Framework-Specific Patterns** (Spring Boot, React, etc.) ← **THESE STAY**
- ✅ **Security & Best Practices** (all technologies) ← **THESE STAY**
- ✅ **Testing Conventions** (all frameworks) ← **THESE STAY**
- ✅ **Development Workflow** (complete workflow)
- ✅ **Evidence References** (all files analyzed)

**Do NOT remove any content from the monolithic file. It serves as the base context for all Copilot sessions.**

**Step 2.2: Identify Sections to use as reference to create the Specialized Playbooks**

From the monolithic file, identify sections that should be used to create the specialized playbooks:

**Sections to Extract:**
- ✅ **Framework-specific patterns** (Spring Boot controllers, React hooks, Django views)
- ✅ **Language-specific conventions** (Java annotations, Python decorators, TypeScript types)
- ✅ **Technology-specific security** (JWT implementation, React XSS prevention, SQL injection patterns)
- ✅ **Testing frameworks** (JUnit patterns, Jest patterns, Pytest patterns)
- ✅ **Functional area patterns** (API/controllers, database/repositories, UI components)
- **... any other sections that are clearly tied to a specific technology or area**

**Step 2.3: Plan Specialized Playbooks to Create**

Based on the analysis, create a list of specialized playbooks to generate:

**Example Planning Output:**
```
Planned Specialized Playbooks:
1. backend.instructions.md
   - Derived from: "Framework-Specific Patterns > Spring Boot"
   - applyTo: "src/main/java/**/*.java"

2. frontend.instructions.md
   - Derived from: "Framework-Specific Patterns > React"
   - applyTo: ["src/**/*.tsx", "src/**/*.jsx"]

3. tests.instructions.md
   - Derived from: "Testing Conventions"
   - applyTo: ["**/*.test.*", "**/*.spec.*"]

4. *... (additional files as identified)
```

**Output:**
- List of specialized playbooks to create in Phase 3
- Content mapping (which sections go into which playbooks)
- Proposed `applyTo` patterns for each playbook

---

### Phase 3: Create Specialized Instruction Playbooks

For each technology/framework/functional area identified in Phase 1, create a specialized instruction playbook by **using the monolithic file as a reference source** to derive focused, contextual guidance for that specific technology area.

**What "Derive and Adapt" Means:**
1. **Extract** patterns relevant to this technology from monolithic sections
2. **Remove** patterns from other technologies (e.g., no React patterns in Java playbook)
3. **Adapt** language to be technology-specific (e.g., "components" → "controllers" for backend)
4. **Focus** on file types matching the `applyTo` pattern
5. **Preserve** evidence citations that match this technology area
6. **Result:** A noise-free, focused playbook (not a verbatim copy of monolithic sections)

**Handling Cross-Cutting Concerns:**
- **If a pattern applies to a specific technology context, include it in that playbook**
  - Example: JWT validation → `backend.instructions.md` (backend handles auth)
  - Example: XSS prevention → `frontend.instructions.md` (frontend renders user input)
  - Example: SQL injection → `backend.instructions.md` (backend queries database)
- **If a pattern is truly universal, keep it only in monolithic** (e.g., "use meaningful variable names")

**Handling Testing Patterns:**
- **If testing patterns significantly differ by technology:** Create technology-specific test playbooks
  - Example: `java-tests.instructions.md` (JUnit, Mockito) + `react-tests.instructions.md` (Jest, RTL)
  - `applyTo: "src/test/java/**/*.java"` vs `applyTo: "src/**/*.test.tsx"`
- **If testing patterns are consistent:** Create single `tests.instructions.md`
  - `applyTo: ["**/*.test.*", "**/*.spec.*"]`

#### **File Naming Convention:**

**Prioritize specificity over generality:**
- Backend framework: `springboot.instructions.md` (not generic `backend.instructions.md`)
- Frontend framework: `react.instructions.md` (not generic `frontend.instructions.md`)
- Testing: `jest.instructions.md` or `tests.instructions.md`
- Language-specific: `java.instructions.md`, `python.instructions.md`, `typescript.instructions.md`
- Functional area: `api.instructions.md`, `database.instructions.md`, `components.instructions.md`

**Examples:**
- Spring Boot repo → `springboot.instructions.md`
- React repo → `react.instructions.md`
- Full-stack (Java + React) → `backend.instructions.md` + `frontend.instructions.md`
- Multi-language backend → `java.instructions.md` + `python.instructions.md`

#### **File Structure Template:**

```markdown
---
applyTo: ["glob/pattern/**/*.ext", "another/pattern/**"]
description: "Brief description of what code this applies to (e.g., 'Spring Boot backend services and controllers')"
---

# [Technology/Area] Copilot Instructions

> Extracted from `.github/copilot-instructions.md` on [DATE]
> Applies to: [Human-readable description of scope]
> Automatically loaded when editing files matching: [applyTo patterns]

---

## [Section Name]

[Content derived from the relevant sections in the monolithic file, adapted and focused for this specific technology/area]

**Evidence:**
- [File paths from original Evidence block that match this technology]

---

## [Next Section Name]

[Additional content derived from monolithic file, tailored for this context...]

**Evidence:**
- [File paths relevant to this section...]

---

## Related Guidelines

For comprehensive project context, see `.github/copilot-instructions.md` which includes:
- Complete project overview and architecture
- General coding standards across all technologies
- Universal security requirements
- Code review and documentation expectations

This specialized file provides focused guidance for [technology/area] and is loaded automatically when you edit matching files.
```

---

### Phase 4: Derive `applyTo` Glob Patterns

**Rules for Creating `applyTo` Patterns:**

1. **Start Specific, Then Generalize:**
   - If all evidence paths share `src/main/java/`, use `"src/main/java/**"`
   - If evidence spans `src/` and `lib/`, use `["src/**", "lib/**"]`

2. **Include File Extensions When Relevant:**
   - Java backend: `"src/main/java/**/*.java"`
   - React components: `["src/**/*.tsx", "src/**/*.jsx"]`
   - Python: `"**/*.py"` (if Python is project-wide)

3. **Separate Test Files from Production Patterns:**
   - Production code: `"src/main/java/**/*.java"` (excludes `src/test/`)
   - Test code: `"src/test/java/**/*.java"` (separate instruction file)
   - OR use test file patterns: `["**/*.test.*", "**/*.spec.*"]`

4. **Use Arrays for Multiple Patterns:**
   ```yaml
   applyTo: ["src/components/**/*.tsx", "src/pages/**/*.tsx", "src/hooks/**/*.ts"]
   ```

5. **Validate Patterns Against Actual Files:**
   After generating each `applyTo` pattern, **verify it matches actual files in the repo**:
   - Use `#codebase` or `#search` to confirm files exist at those paths
   - If no files match, revise the pattern or skip that instruction file

**Common Patterns by Technology:**

| Technology | Recommended `applyTo` | Notes |
|------------|----------------------|-------|
| Spring Boot Backend | `"src/main/java/**/*.java"` | Excludes test directory |
| React Frontend | `["src/**/*.tsx", "src/**/*.jsx"]` | Covers components, pages, hooks |
| Python Application | `"**/*.py"` or `"src/**/*.py"` | Adjust based on project structure |
| Unit Tests | `["**/*.test.*", "**/*.spec.*"]` | Captures all test file patterns |
| Integration Tests | `"src/test/java/**"` or `"tests/integration/**"` | Separate from unit tests |
| API/Controllers | `"src/**/controllers/**/*.java"` | Functional area focus |
| Database/Repositories | `"src/**/repositories/**/*.java"` | Data access layer |
| React Components | `"src/components/**/*.tsx"` | UI component focus |
| React Hooks | `"src/hooks/**/*.ts"` | Custom hooks only |

---

### Phase 5: Validation & Quality Checks

Before finalizing each specialized instruction playbook, verify:

**1. Content Derived Appropriately:**
- ✅ Content in specialized files is appropriately derived from the monolithic file as a reference
- ✅ All Evidence citations relevant to this technology area are included
- ✅ Content is focused and contextual for the specific technology (not just copied verbatim)
- ✅ Patterns from OTHER technologies have been removed (e.g., no React in Java playbook)
- ✅ Language adapted to be technology-specific (not generic cross-tech wording)
- ✅ Typical length: 50-200 lines (focused, not comprehensive like monolithic)
- ✅ Cross-cutting concerns applied in proper technology context (JWT in backend, XSS in frontend)

**2. `applyTo` Patterns Don't Overlap Inappropriately:**
- ✅ `backend.instructions.md` applies to `"src/main/java/**/*.java"`
- ✅ `tests.instructions.md` applies to `"src/test/java/**/*.java"`
- ⚠️ If patterns could overlap (e.g., `UserController.test.java`), ensure the most specific pattern wins
- ℹ️ Some overlap is acceptable if it provides valuable context (e.g., general Java patterns + Spring Boot patterns)

**3. Evidence Paths Match `applyTo` Pattern:**
- If `applyTo: "src/main/java/**/*.java"`, verify all Evidence paths start with `src/main/java/`
- If evidence includes paths outside the `applyTo` pattern, either:
  - Expand the pattern to include those paths
  - Remove mismatched evidence (if it's truly irrelevant)
  - Create a more specific instruction file for those paths

**4. Glob Patterns Match Real Files:**
Use workspace tools to verify:
```
#search pattern:"src/main/java/**/*.java"
```
If no files are found, revise the `applyTo` pattern.

**5. Each File Has a Clear Purpose:**
- Description should explain WHEN this file applies (e.g., "When editing Java backend services and controllers")
- Avoid generic descriptions like "Backend code" (be specific: "Spring Boot REST API implementation patterns")

**6. Ready for Phase 6:**
- ✅ All specialized playbooks created and validated
- ✅ All `applyTo` patterns confirmed to match real files
- ✅ Content appropriately derived from monolithic file with proper focus
- ✅ Now ready to generate the reference section for the monolithic file

---

### Phase 6: Generate Final Output & Update Monolithic File

**NOW** that all specialized playbooks have been created and validated, we can update the monolithic file with references.

**Deliverables:**

**1. Specialized Instruction Playbooks (in `.github/instructions/`):**
- Output the complete content for each specialized playbook created in Phase 3

**2. Reference Section to Append to Monolithic File:**

**AFTER** all specialized files are created, generate the reference section to be added at the END of `.github/copilot-instructions.md`:

**Append this to the monolithic file:**
```markdown
---

## Path-Specific Instruction Files

- `.github/instructions/springboot.instructions.md`
- `.github/instructions/react.instructions.md`
- `.github/instructions/tests.instructions.md`
```

**IMPORTANT:**
- ✅ The monolithic file retains ALL original content
- ✅ This reference section is APPENDED at the very end
- ✅ List ONLY the files that were actually created and validated

---

## Hard Rules (Apply Throughout)

1. **Evidence-Based Only:**
   - Only include patterns/rules found in the original monolithic file
   - Do NOT invent new rules or patterns
   - Use the monolithic file as a reference source to derive focused content

2. **Keep Monolithic File Complete:**
   - Do NOT remove any content from `.github/copilot-instructions.md`
   - DERIVE specialized playbook content using monolithic as reference (don't remove from monolithic)
   - ADD reference section at the end (don't replace anything)

3. **Validate Every `applyTo` Pattern:**
   - Use `#codebase` or `#search` to confirm files exist at the specified paths
   - If the pattern matches zero files, either fix it or skip that instruction file
   - Document validation results in the summary report

4. **Avoid Inappropriate Overlaps:**
   - Each specialized playbook should have a clear, distinct scope
   - If a file could match multiple patterns, ensure this is intentional and valuable
   - Document any intentional overlaps in the summary report

5. **Content Derivation and Focus:**
   - Specialized playbooks should be derived from the monolithic file, using it as a reference
   - The specialized playbooks provide focused, contextual guidance for specific technologies
   - Content may overlap with monolithic file but should be adapted for the specific context
   - Focus on relevance and clarity for the target technology/area

---

## Example Execution

**Given this section in the monolithic file (contains MULTIPLE technologies):**

```markdown
## Framework-Specific Patterns

### Spring Boot Backend
**Routing:**
- Use @RestController with @RequestMapping at class level
- Define endpoint methods with @GetMapping, @PostMapping, etc.

**Controllers:**
- Keep controllers thin; delegate business logic to services
- Use DTOs for request/response bodies, not entities

**Evidence:**
- `src/main/java/com/example/controller/UserController.java:12-45`
- `src/main/java/com/example/service/UserService.java:8-30`

### React Frontend
**Component Structure:**
- Use functional components with hooks (no class components)
- Custom hooks in `src/hooks/` directory

**State Management:**
- Use Zustand for global state
- React Query for server state

**Evidence:**
- `src/components/UserProfile.tsx:5-30`
- `src/hooks/useAuth.ts:10-25`

## Security & Best Practices
- Validate all user input (applies to both frontend and backend)
- JWT tokens for authentication (backend validates, frontend stores)
- XSS prevention: sanitize user input before rendering (frontend)
- SQL injection prevention: use parameterized queries (backend)

**Evidence:**
- `src/main/java/com/example/security/JwtValidator.java:15-40`
- `src/components/RichTextEditor.tsx:20-35`
```

**Your Output - Specialized Playbook (DERIVED, not copied):**

```markdown
### FILE: .github/instructions/springboot.instructions.md

---
applyTo: "src/main/java/**/*.java"
description: "Spring Boot backend patterns for REST controllers, services, and security"
---

# Spring Boot Backend Copilot Instructions

> Derived from `.github/copilot-instructions.md`
> Applies to: Java backend code in src/main/java/
> Automatically loaded when editing files matching: src/main/java/**/*.java

---

## REST API Patterns

**Controllers:**
- Use @RestController with @RequestMapping at class level
- Define endpoint methods with @GetMapping, @PostMapping, etc.
- Keep controllers thin; delegate business logic to services
- Use DTOs for request/response bodies, not entities

**Evidence:**
- `src/main/java/com/example/controller/UserController.java:12-45`
- `src/main/java/com/example/service/UserService.java:8-30`

---

## Security Best Practices

**Authentication:**
- JWT tokens for authentication: validate on backend endpoints
- Use parameterized queries to prevent SQL injection

**Input Validation:**
- Validate all user input at controller layer
- Use @Valid annotations with DTOs

**Evidence:**
- `src/main/java/com/example/security/JwtValidator.java:15-40`

---

## Related Guidelines

See `.github/copilot-instructions.md` for complete project context including architecture, general coding standards, and cross-technology patterns.
```

**Notice the derivation:**
1. ❌ **Removed** React patterns (not relevant to Java files)
2. ✅ **Kept** Spring Boot patterns (relevant to `src/main/java/`)
3. ✅ **Adapted** security section: included JWT validation + SQL injection (backend concerns), excluded XSS (frontend concern)
4. ✅ **Reorganized** sections with backend-focused headers ("REST API Patterns" instead of generic "Framework-Specific Patterns")
5. ✅ **Filtered** evidence: only Java files included

**Your Output - AFTER Creating All Specialized Files, Output Reference Section:**

```markdown
### APPEND TO: .github/copilot-instructions.md

---

## Path-Specific Instruction Files

- `.github/instructions/springboot.instructions.md`
- `.github/instructions/*... (additional files as created)
```

---

## BEGIN EXECUTION

**Input Required:**
Read the `.github/copilot-instructions.md` file from the repository, then execute the phases above.

## Final Reminders

**Critical Execution Order:**
1. ✅ Analyze → Plan → Create playbooks → Validate → Append references (Phases 1-6 in sequence)
2. ✅ Create ALL specialized playbooks FIRST before appending references to monolithic file
3. ✅ Monolithic file: Keep COMPLETE (nothing removed) + Append references at END

**Before Execution:**
- Review all 6 phases and Hard Rules above
- Ensure access to codebase for validation
- Remember: Specialized playbooks AUGMENT monolithic, they don't replace it
