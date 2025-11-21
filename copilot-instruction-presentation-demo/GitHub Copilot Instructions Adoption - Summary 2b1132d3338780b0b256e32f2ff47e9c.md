# GitHub Copilot Instructions Adoption - Summary

**By Sami Sabir-Idrissi** | 1 min | 2 reactions

We’re proposing a **PROCESS** for generating custom `.github/copilot-instructions.md` files across all TAM-PAU repositories. Using an automated prompt template, each repository gets a **unique, project-specific instruction file** that transforms GitHub Copilot from generic code completion into a project-aware development assistant matching that specific codebase’s patterns, frameworks, and conventions.

---

## Why This Matters

| Problem | Impact |
| --- | --- |
| Generic AI suggestions don’t match team standards | Code inconsistency + review rework |
| New developers struggle learning project patterns | Longer onboarding, more mentoring |
| Knowledge silos - only seniors know “the right way” | Reduced productivity across team |
| AI hallucination and off-pattern code | Technical debt accumulation |

---

## The Solution

1. **Distribute** the standardized prompt template to all development teams
2. **Generate** custom Copilot instructions per repository using automated codebase analysis
3. **Commit** project-specific `.github/copilot-instructions.md` file to each repository
4. **Maintain** quarterly as codebases evolve. In the future we will use github actions to have an ai agent autoupdate the instructions file based on code changes.

---

## Organizational Value

- ✅ **Consistency**: All team members get AI suggestions matching project patterns
- ✅ **Onboarding**: New developers learn conventions faster through smart AI assistance
- ✅ **Velocity**: Reduced code review cycles with pattern-compliant suggestions
- ✅ **Scalability**: Best practices enforced automatically across entire organization

### Estimated ROI

By reducing AI hallucinations, eliminating code rework, and minimizing developer frustration from off-pattern suggestions, project-specific Copilot instructions can improve developer productivity by **20-30%**.

---

## Adoption Path

| Timeline | Action |
| --- | --- |
| **Q4 2025** | Pilot with 3-5 high-priority repositories (50% adoption goal) |
| **Q1 2026** | Roll out to all active/production repositories (100% adoption) |
| **Q2 2026** | Automate maintenance via GitHub Actions |

---

## How to Get Started (Per Repository)

1. **Open** VS Code in the repository root directory
2. **Run** the provided prompt template in Copilot Chat (Set to Agent mode, with Model Claude Sonnet 4.5 recommended)
3. **Generate** project-specific instructions file from automated codebase analysis
4. **Review** & peer-approve the generated file
5. **Commit & Push** to `.github/copilot-instructions.md` in your repository
6. **PR Review and Merge** process to finalize changes and approve
7. **Update** quarterly when significant codebase changes occur

---

## Key Differentiator

Unlike generic Copilot best practices, **this approach creates evidence-based instructions derived from YOUR actual code patterns** - ensuring Copilot becomes a team-aware assistant, not a generic code generator.