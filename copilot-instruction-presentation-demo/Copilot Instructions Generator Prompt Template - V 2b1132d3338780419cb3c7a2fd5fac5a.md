# Copilot Instructions Generator Prompt Template - V1

## Summary

This template generates comprehensive, project-specific `.github/copilot-instructions.md` files that transform GitHub Copilot from generic code completion into a **project-aware development assistant**. Rather than one-size-fits-all suggestions, it leverages GitHub Copilot’s agent mode tools to analyze YOUR codebase and create instructions that guide Copilot to produce code consistent with your specific patterns, conventions, and architecture.

**Key Innovation**: Creates evidence-based instruction files derived from actual codebase analysis, not generic best practices

**Value**: Transforms Copilot into a team member who understands your project’s unique patterns and standards

---

## 🚀 Organizational Value & ROI

### The Problem We’re Solving

Every development team in our organization uses projects that have different technology stacks, frameworks, and coding conventions:

- **Spring Boot teams** have different entity patterns, REST conventions, and testing approaches
- **React teams** use varying state management, component structures, and styling patterns
- **Python teams** follow different Django/Flask patterns, ORM usage, and API designs
- **Full-stack teams** need consistent patterns across multiple technologies

Without project-specific Copilot configuration, developers get generic suggestions that don’t match team conventions, leading to:

- ❌ **Code inconsistency** across team members
- ❌ **Time wasted** reformatting AI-generated code to match standards
- ❌ **Knowledge silos** where only senior developers know the “right way”
- ❌ **Onboarding delays** for new team members learning project patterns

### The Solution: Automated Project Intelligence

This template **automatically analyzes each project** and creates custom Copilot instructions that:

- ✅ **Enforce team coding standards** through AI suggestions
- ✅ **Accelerate onboarding** by teaching Copilot your project patterns
- ✅ **Reduce code review time** with consistent, pattern-matching code generation
- ✅ **Scale best practices** across all team members instantly

---

## ⚠️ Important Notes

### What This Template Does Well

- ✅ Analyzes actual codebase patterns and conventions
- ✅ Generates project-specific coding standards
- ✅ Creates evidence-based instructions with file references
- ✅ Supports all major technology stacks (Spring Boot, React, Python, etc.)
- ✅ Prevents AI hallucination through “no invention” rules

### Best Use Cases

- **New team members** needing to understand project conventions
- **Large codebases** with established patterns and standards

### When the code base changes

- If the code base changes overtime significantly always re run the prompt to ensure that the copilot instructions file stays up to date based on your code changes over time.

Before using this template:

1. **Open Visual Studio Code** in your project root directory
2. **Project with established patterns** - works best on projects with existing code

---

## 📝 Prompt Template Usage Instructions

### Step 1: Prepare Information

Fill out these inputs before running:

- **Primary Technology**: Spring Boot, Node.js, Python, React, etc.
- **Framework/Tech Details**: Specific versions (e.g., “Spring Boot 3.2, Java 17, PostgreSQL”)
- **Project Context**: 1-3 lines describing what the system does

### Step 2: Execute

1. Copy the template and fill in your information
2. Open GitHub Copilot Chat and Set it to “Agent” Mode
- This will not work in “Ask” or “Edit” mode
1. Paste and submit the prompt
2. Wait 1-2 minutes for copilot analysis & generation to complete

### Step 3: Implement

1. Review the generated content

### The Prompt

> Prompt in markdown
> 

### 📊 Expected Output

The generated file includes:

> Example output
> 

---

## 💡 Pro Tips

- Update the instruction file **quarterly** as patterns evolve
- Use for **team onboarding** to share project conventions
- Works best with **consistent project structure** and naming
- Use GPT4.1 model because of its 1 Million token context window (Future release of Claude Sonnet 4.1 will have 1 million context window)

---

## Github Source Documentation

[Adding repository custom instructions for GitHub Copilot - GitHub Docs](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)