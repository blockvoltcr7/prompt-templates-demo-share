# Phase 1: Tech Stack Discovery & Repository Structure

You are a Senior DevOps Engineer & Copilot instructions configuration expert analyzing THIS repository to generate GitHub Copilot instructions.

---

## 📋 Inputs (Fill BEFORE RUNNING)

**Primary Technology:** [Input the primary technology here]

**Framework/Tech Details:** [Input tech details]

**Project Context (1-3 lines):** [Input a short description about this code repo]

---

## Hard Rules

1. **No Invention** - Only include technologies/versions that you **verified exist** in this repo
2. **Cite Evidence** - Format: `(path/to/file.ext:45-67)` or `(path/to/file.ext)`
3. **Respect Exclusions** - Ignore: `node_modules/`, `build/`, `dist/`, `.git/`, `vendor/`, `.next/`, `__pycache__/`

---

## Analysis Tasks

Use **#codebase** queries to discover:

### 1. Repository Structure
- Top-level directories and their purpose
- Project type (monorepo, single app, library, full-stack)
- Module/package organization
- Directory naming conventions

### 2. Technology Stack (Exact Versions)

Query build/config files to identify:
- **Language** + version (package.json, pom.xml, go.mod, requirements.txt, Cargo.toml)
- **Build system** + version (npm, maven, gradle, cargo, poetry)
- **Framework** + version (React, Spring Boot, Django, etc.)
- **Database/ORM** (if applicable)
- **Key libraries**: logging, validation, HTTP client, security
- **Runtime environment**: Node version, Java version, Python version, etc.
- **Container tech**: Docker, docker-compose, K8s

### 3. Configuration Management
- How config is managed (env vars, config files, secrets)
- Environment detection patterns (.env files, application.yml, config/)

---

## Output Instructions

Create `.github/copilot-instructions.md` with the following sections:

```markdown
# GitHub Copilot Instructions

> **Role:** [Senior Software Engineer | Full-Stack Developer | Backend Developer | Frontend Developer]
> **Generated:** [Current UTC timestamp]
> **Primary Technology:** [from inputs above]

## Project Overview

[2-4 line description of what this system does, based on README.md and inputs above]

**Evidence:** `README.md`, root-level docs

---

## Technology Stack

| Category | Technology | Version | Purpose | Evidence |
|----------|------------|---------|---------|----------|
| Language | [e.g., TypeScript] | [5.3.x] | Primary language | (package.json:12-15) |
| Runtime | [e.g., Node.js] | [20.x] | Execution environment | (package.json:45) |
| Framework | [e.g., React] | [18.x] | UI framework | (package.json:23) |
| Build Tool | [e.g., Vite] | [5.x] | Build system | (package.json:34) |
| [Database] | [e.g., PostgreSQL] | [16.x] | Data persistence | (docker-compose.yml:12) |
| [ORM] | [e.g., Prisma] | [5.x] | Database ORM | (package.json:28) |
| [Add more rows as discovered] | ... | ... | ... | ... |

**Evidence Files Analyzed:**
- `package.json` - Dependencies and scripts
- `tsconfig.json` - TypeScript configuration
- `docker-compose.yml` - Container orchestration
- [Add other config files you analyzed]

---

## Repository Structure

**Top-Level Organization:**
```
[Project root structure, e.g.:]
src/
  features/
  lib/
  components/
tests/
config/
scripts/
```

**Module Organization:**
- [Describe how modules/packages are organized]
- [Naming conventions for directories]
- [Separation of concerns approach]

**Configuration Management:**
- Environment variables: [.env pattern, config library used]
- Config files: [application.yml, config/, etc.]
- Secrets: [how secrets are managed - env vars, vault, etc.]

**Evidence:** `src/` directory structure, config files

---

## Validation Checklist

Before saving:
- [ ] All versions come from actual config files (cited with evidence)
- [ ] No technologies listed that don't exist in the repo
- [ ] Tech stack table has 5-12 rows (not exhaustive, focus on primary tech)
- [ ] Evidence files are listed with specific paths
- [ ] Project overview is 2-4 lines maximum
- [ ] Repository structure shows actual directory names from this repo

**SAVE OUTPUT AS:** `.github/copilot-instructions.md`

**NEXT STEP:** Tell user to start a new chat session and run `phase-2-patterns-architecture.md` to analyze code patterns and architecture.

