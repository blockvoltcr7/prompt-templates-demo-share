# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a **documentation repository** containing AI-assisted software development prompt templates and frameworks. It is not a buildable codebase - there are no tests to run, no build commands, or compilation steps. All content is Markdown documentation and YAML configuration templates designed to enhance productivity across engineering roles (developers, QA engineers, product managers).

## Repository Architecture

### Core Framework Systems

**CREATE Framework** (`/create-framework-guides/`)
- Role-based guides structured using the CREATE methodology:
  - **C**haracter: Define stakeholder roles
  - **R**equest: Articulate objectives
  - **E**xamples: Provide relevant scenarios
  - **A**pplication: Describe implementation context
  - **T**ask: Specify deliverables
  - **E**valuation: Establish success criteria
- Three role-specific guides in `guides/`: `developers/`, `product-managers/`, `qa-engineers/`
- Shared resources in `guides/shared/` include framework overview and glossary
- Real-world examples in `examples/` demonstrating each role's application
- YAML templates in `templates/` for quick adaptation

**Spec-Kit-Copilot System** (`/spec-kit-copilot/version-9-29-25/`)
- Agentic workflow system with 7-stage process: CLARIFY → ANALYZE → SPECIFY → PLAN → IMPLEMENT → TASKS → CONSTITUTION
- Prompt files in `.github/prompts/` define each stage's behavior
- Templates in `.specify/templates/` provide structured outputs
- Constitution system in `.specify/memory/` enforces project principles with semantic versioning

**Agent Core** (`/agent/.agent-core/`)
- Task-specific prompts in `tasks/` for common activities: Test Plans, Bug Reports, Code Review, Jira tickets, Meta-prompts
- Corresponding templates in `templates/` for standardized outputs

**Phase-Based Copilot Instruction Generator** (`/copilot-instruction-presentation-demo/phase-based-copilot-instruction-generation/`)
- 4-phase automated system for generating custom `.github/copilot-instructions.md` files
- Prompts in `prompts/` directory: Phase 1 (Tech Stack) → Phase 2 (Architecture) → Phase 3 (Testing) → Phase 4 (Finalization)
- Key innovation: Session isolation between phases to prevent context overflow
- Supporting documentation in `docs/` and Confluence-ready exports in `confluence/`
- Automation scripts in `scripts/` for parallel execution

### Root-Level Template Categories

1. **Test Automation Templates**
   - `PARAMETERIZED-PROMPT-TEMPLATES-GITHUB-COPILOT-AI-CODING-V1.md` (1424 lines): BDD feature generation with test data
   - `SQL-TEST-DATA-EXTRACTION-TEMPLATE-SCHEMA-BASED-QUERY-GENERATION.md`: Schema-based test data creation

2. **Development & Architecture Templates**
   - `BUSINESS-REQUIREMENTS-TO-TECHNICAL-ANALYSIS-TEMPLATE.md`: Breaks down features into sprint-ready stories
   - `rest-assured-template-implementation.md`: REST Assured test implementation patterns
   - `Reliability-Droidi-issue Investigation-Template.md`: Issue investigation methodology

3. **Context Engineering & Research Templates**
   - `CONTEXT-ENGINEERING-SPIKE-RESEARCH-TEMPLATE-CHAIN.md`: 4-step research to implementation workflow
   - `CONTEXT-ENGINEERING-SPIKE-RESEARCH-TEMPLATE-CHAING-V2.md`: Enhanced version with additional validation steps

4. **GitHub Copilot Templates**
   - `GitHub-Copilot-Instructions-Generator-System-Enterprise-Edition.md`: Enterprise-wide Copilot configuration
   - `ENHANCED-PULL-REQUEST-REVIEW-TEMPLATE-GITHUB-COPILOT-AGENT-MODE.md`: Automated PR review workflows
   - `github-instructions-prompt-v2.md`: Copilot instruction patterns

5. **Template Composition Examples**
   - `TEMPLATE-COMPOSITION-CHAINING-EXAMPLE.md`: Demonstrates multi-step template workflows (test data → BDD features → implementation)

## Key Template Patterns

### Placeholder Convention
All templates use `[PLACEHOLDER]` syntax for user-customizable sections:
- `[PROJECT_NAME]`, `[JIRA_TICKET]`, `[API_ENDPOINT]`, etc.
- When adapting templates, replace ALL placeholders with concrete values

### Multi-Step Chaining
Templates are designed to compose together sequentially:
1. Output from one template feeds directly into the next
2. Chain handoff points are explicitly marked (e.g., "Chain Output:", "Chain Input:")
3. Example: Test Data Generation → BDD Feature File → REST Assured Implementation

### Structured Output Format
Every template specifies:
- **Role Definition**: Who the AI should act as
- **Context**: Background information and constraints
- **Task**: Specific deliverables required
- **Output Goals**: Quality criteria using emojis (🧩 🎯 🔁 📽️)
- **Examples**: Expected output format
- **Quality Checklist**: Validation steps

### Framework Alignment
- **CREATE Framework**: Applied consistently across role-based guides with tailored examples
- **Spec-Kit Constitution**: Uses placeholder tokens with semantic versioning for governance changes
- **Agentic Workflows**: Multi-stage processes with clear transitions between stages

## Working with Templates

### Adapting Templates for Projects
1. Identify the template matching your use case (see template categories above)
2. Copy the template content
3. Replace all `[PLACEHOLDER]` values with project-specific information
4. For chained workflows, execute templates in sequence and pass outputs forward
5. Validate outputs against the quality checklist included in each template

### Template Composition Workflow
When combining multiple templates:
1. Start with the earliest stage template (e.g., test data generation)
2. Save outputs with the filename specified in "Chain Output" section
3. Reference saved outputs in subsequent template "Chain Input" sections
4. Maintain consistent terminology across the chain

### Spec-Kit Constitution Updates
When modifying `.specify/memory/constitution.md`:
- Update `CONSTITUTION_VERSION` using semantic versioning:
  - **MAJOR**: Breaking governance changes or principle removals
  - **MINOR**: New principles or expanded guidance
  - **PATCH**: Clarifications or typo fixes
- Update `LAST_AMENDED_DATE` to current date (ISO format YYYY-MM-DD)
- Propagate changes to dependent templates in `.specify/templates/`
- Add Sync Impact Report as HTML comment at top of file

## Directory Navigation Guide

- **Role-based guides**: `/create-framework-guides/guides/{role}/`
- **Agentic prompts**: `/spec-kit-copilot/version-9-29-25/.github/prompts/`
- **Task templates**: `/agent/.agent-core/{tasks,templates}/`
- **Chaining examples**: Root-level files with "CHAIN" or "COMPOSITION" in filename
- **Copilot instruction generator**: `/copilot-instruction-presentation-demo/phase-based-copilot-instruction-generation/`
- **Presentation materials**: `/copilot-instruction-presentation-demo/`
- **Reference docs**: `/notes/` and `/share/`

## Multi-AI Configuration

This repository contains AI instruction files for multiple AI coding assistants:
- `CLAUDE.md` - Instructions for Claude Code (this file)
- `GEMINI.md` - Instructions for Google Gemini
- `.github/copilot-instructions.md` - Instructions for GitHub Copilot

The `.github/copilot-instructions.md` file contains comprehensive naming conventions, anti-patterns, and framework-specific patterns. Refer to it for detailed template structure guidance.

## Important Conventions

### No Build or Test Commands
This repository contains only documentation. Do not attempt to:
- Run build commands (no build system exists)
- Execute tests (no test framework configured)
- Compile code (no source code present)
- Run CI/CD pipelines (none defined)

### File Modification Guidelines
When updating templates:
- Preserve the structured format (Role → Context → Task → Output Goals → Examples → Checklist)
- Maintain placeholder syntax `[PLACEHOLDER]` for customizable sections
- Keep emoji indicators for quality goals (🧩 🎯 🔁 📽️)
- Update chain references if modifying input/output contracts
- For Spec-Kit files, follow the strict versioning and propagation rules

### Cross-Role Consistency
When creating or modifying role-specific content:
- Use shared glossary from `/create-framework-guides/guides/shared/glossary.md`
- Follow CREATE framework structure across all role guides
- Ensure examples demonstrate realistic scenarios from that role's perspective
- Maintain consistent terminology across developer, QA, and PM guides

### Naming Conventions
- **Root templates**: `SCREAMING-KEBAB-CASE.md` (e.g., `TEMPLATE-COMPOSITION-CHAINING-EXAMPLE.md`)
- **Guide files**: `Title_Case_With_Underscores.md` (e.g., `CREATE_Framework_Guide_for_Developers.md`)
- **YAML templates**: `kebab-case.yaml` (e.g., `feature-implementation-template.yaml`)
- **Prompt files**: `lowercase.prompt.md` (e.g., `clarify.prompt.md`)
- **Phase files**: `phase-N-description.md` (e.g., `phase-1-tech-stack-discovery.md`)
