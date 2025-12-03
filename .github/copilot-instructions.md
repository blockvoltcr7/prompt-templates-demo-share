# GitHub Copilot Instructions

> **Roles:** Senior Prompt Engineer | Technical Writer | AI-Assisted Development Specialist

**Generated:** 2025-12-02T00:00:00Z  
**Primary Technology:** Markdown, YAML

---

## Project Overview

This is a **documentation repository** containing AI-assisted software development prompt templates and frameworks. It is NOT a buildable codebase—there are no tests to run, no build commands, or compilation steps. All content is Markdown documentation and YAML configuration templates designed to enhance productivity across engineering roles (developers, QA engineers, product managers).

**Key Systems:**
- **CREATE Framework** (`/create-framework-guides/`): Role-based prompt engineering methodology
- **Spec-Kit-Copilot** (`/spec-kit-copilot/`): Agentic workflow system with 7-stage process
- **Agent Core** (`/agent/.agent-core/`): Task-specific prompts and templates

---

## Technology Stack

| Category | Technology | Version | Purpose |
|----------|------------|---------|---------|
| Documentation | Markdown | N/A | Primary content format |
| Configuration | YAML | N/A | Template configurations |
| AI Instructions | Claude, Gemini, Copilot | N/A | Multi-AI configuration files |

---

## Architecture Guidelines

**Repository Structure:**
```
prompt-templates-demo-share/
├── create-framework-guides/       # CREATE Framework system
│   ├── guides/                    # Role-specific guides
│   │   ├── developers/            # Developer-focused guides
│   │   ├── qa-engineers/          # QA-focused guides
│   │   ├── product-managers/      # PM-focused guides
│   │   └── shared/                # Shared resources (glossary, overview)
│   └── templates/                 # YAML templates for each role
│       ├── dev-templates/
│       ├── qa-templates/
│       └── pm-templates/
├── spec-kit-copilot/              # Agentic workflow system
│   └── version-9-29-25/
│       ├── .github/prompts/       # Stage-specific prompts
│       └── .specify/              # Templates, memory, scripts
├── agent/                         # Agent configuration
│   ├── .agent-core/               # Tasks and templates
│   └── chatmodes/                 # Chat mode configurations
├── prompts/                       # Code review prompts
├── notes/                         # Reference documentation
└── share/                         # Shared resources
```

**Module Organization:**
- Group by **framework system** (CREATE, Spec-Kit, Agent Core)
- Within each system, separate **guides** from **templates**
- Role-based organization: `developers/`, `qa-engineers/`, `product-managers/`

**Cross-Module Communication:**
- Templates chain together via explicit "Chain Output" and "Chain Input" markers
- Spec-Kit stages flow: CLARIFY → ANALYZE → SPECIFY → PLAN → IMPLEMENT → TASKS → CONSTITUTION

---

## General Coding Standards

### Naming Conventions

**Files:**
- Markdown files: Use `SCREAMING-KEBAB-CASE` for root templates: `TEMPLATE-COMPOSITION-CHAINING-EXAMPLE.md`
- Guide files: Use `Title_Case_With_Underscores`: `CREATE_Framework_Guide_for_Developers.md`
- YAML templates: Use `kebab-case`: `feature-implementation-template.yaml`
- Prompt files: Use `lowercase.prompt.md` pattern: `clarify.prompt.md`

**Template Sections:**
- Section headers: Use `##` with descriptive titles
- Subsections: Use `###` for component breakdowns
- Code blocks: Always specify language after triple backticks

**Placeholder Convention:**
Always use `[PLACEHOLDER]` syntax (brackets with SCREAMING_SNAKE_CASE) for user-customizable sections:

```markdown
**Story**: [PASTE JIRA TITLE HERE]
**Description**: [PASTE JIRA DESCRIPTION HERE]
**Project Name**: [PROJECT_NAME]
**Ticket ID**: [JIRA_TICKET]
```

### Directory Structure Standards

When creating new templates:

```
templates/
├── {role}-templates/              # Role-specific folder
│   ├── {task}-template.yaml       # YAML template file
│   └── {task}-template.md         # Markdown alternative
```

When creating new guides:

```
guides/
├── {role}/
│   └── CREATE_Framework_Guide_for_{Role}.md
└── shared/
    ├── framework-overview.md
    └── glossary.md
```

### Template Structure Pattern

Always structure templates with these sections **in this order**:

```markdown
## Character (C)
[Define the AI's role, expertise level, and technical specialization]

## Request (R)
[Clearly state what needs to be accomplished]

## Examples (E)
[Provide code samples, patterns, or reference implementations]

## Application (A)
[Describe the specific technical context and constraints]

## Task (T)
[Specify the exact work with clear scope and deliverables]

## Evaluation (E)
[Define success criteria and quality standards]
```

### Output Goals Convention

Always include output goals using these emoji markers:

```markdown
### Output Goals:
Ensure your output is:
- 🧩 **[Quality 1]**: [Description]
- 🎯 **[Quality 2]**: [Description]
- 🔁 **[Quality 3]**: [Description]
- 📽️ **[Quality 4]**: [Description]
```

**NEVER Do:**
- ❌ Create templates without placeholder syntax `[PLACEHOLDER]`
- ❌ Omit the CREATE framework sections in role-based templates
- ❌ Mix implementation details in specification documents
- ❌ Create guides without practical examples
- ❌ Use inconsistent heading hierarchy
- ❌ Forget to include Quality Checklist sections
- ❌ Leave out Chain Input/Output markers for chainable templates

---

## Framework-Specific Patterns

### CREATE Framework Templates

Always structure CREATE templates using YAML format with this pattern:

```yaml
# Template Title
# Use this template for [specific use case]

prompt: |
  ## Character (C)
  Act as a [seniority_level] [specialization] with [years]+ years of 
  experience in [primary_tech_stack]. You specialize in [domain_expertise].
  
  ## Request (R)
  [Specific task description with business value statement]
  
  ## Examples (E)
  Follow our existing patterns:
  ```[language]
  [Code or content examples]
  ```
  
  Anti-patterns to avoid:
  ```[language]
  [Examples of what NOT to do]
  ```
  
  ## Application (A)
  [System_name] serving [scale_metrics]:
  
  **Tech Stack:**
  - **Runtime:** [e.g., Node.js 18.x]
  - **Framework:** [e.g., React 18.x]
  
  ## Task (T)
  [Specific deliverables with acceptance criteria]
  
  ## Evaluation (E)
  The implementation must meet ALL of these criteria:
  - ✅ [Criterion 1]
  - ✅ [Criterion 2]

context:
  jira_ticket: "[TICKET-ID]"
  sprint: "[Sprint XX]"
  
expected_output:
  format: "[output format]"
  files: ["list", "of", "expected", "outputs"]
```

### Spec-Kit Prompt Files

Structure `.prompt.md` files with YAML frontmatter:

```markdown
```prompt
---
description: [Brief description of what the prompt does]
---

The user input to you can be provided directly by the agent or as a command argument.

User input:

$ARGUMENTS

Goal: [Clear statement of the prompt's objective]

Execution steps:

1. [Step 1 with specific instructions]
2. [Step 2 with validation checks]
3. [Continue with numbered steps]

Behavior rules:
- [Rule 1]
- [Rule 2]

Context for prioritization: $ARGUMENTS
```
```

### Agent Chat Mode Configuration

Structure `.chatmode.md` or `.chatagent` files with embedded YAML:

```markdown
````chatagent
---
description: "[Agent description]"
tools: ['list', 'of', 'available', 'tools']
---

# agent-name

ACTIVATION-NOTICE: [Activation instructions]

```yaml
agent:
  name: [Agent Name]
  id: [agent-id]
  title: [Agent Title]
  icon: [Emoji]
  
persona:
  role: [Role Description]
  style: [Communication Style]
  focus: [Primary Focus Area]
  core_principles:
    - [Principle 1]
    - [Principle 2]

commands:
  - help: [Help description]
  - [command]: [Description]
  
dependencies:
  tasks:
    - [task-file.md]
  templates:
    - [template-file.yaml]
```
````
```

### Template Chaining Pattern

When creating chainable templates, always include explicit chain markers:

```markdown
### 🔹 Chain Input:
Use the [previous output artifact] from Step [N-1]:
- `[filename-from-previous-step.ext]`

### 🔹 Chain Output:
Save the generated output as `[output-filename.ext]` for use in the next template.

---

## 🔗 CHAINING WORKFLOW SUMMARY

### Input: [Initial input description]
### Output: [Final deliverable]

**Chain Flow:**
```
[Step 1 Input]
    ↓
[Template 1] → [Output 1]
    ↓
[Template 2] → [Output 2] (using Output 1)
    ↓
[Final Output]
```
```

---

## Documentation Standards

### Required Deliverables Section

Always include explicit deliverables with checkmarks:

```markdown
### Required Deliverables:
- ✅ **[Deliverable 1]**: [Description]
- ✅ **[Deliverable 2]**: [Description]
- ✅ **[Deliverable 3]**: [Description]
```

### Quality Checklist Pattern

Include at end of every template:

```markdown
## Quality Checklist

### Clarity
- [ ] Purpose is clearly stated
- [ ] Instructions are unambiguous
- [ ] Technical terms are defined
- [ ] Examples illustrate expected behavior

### Completeness
- [ ] All necessary context is provided
- [ ] Input/output formats are specified
- [ ] Constraints are clearly stated
- [ ] Edge cases are addressed

### Effectiveness
- [ ] Produces consistent results
- [ ] Output quality meets requirements
- [ ] Handles various input types
```

### Version Control Pattern for Constitutions

When modifying constitution files, follow semantic versioning:

```markdown
**Version**: [MAJOR.MINOR.PATCH] | **Ratified**: [YYYY-MM-DD] | **Last Amended**: [YYYY-MM-DD]
```

- **MAJOR**: Breaking governance changes or principle removals
- **MINOR**: New principles or expanded guidance
- **PATCH**: Clarifications or typo fixes

---

## Testing Conventions

This repository has **no automated tests**—it is documentation only.

**Validation Approach:**
- Review templates against the Quality Checklist
- Verify all `[PLACEHOLDER]` values are documented
- Ensure chain inputs/outputs are correctly linked
- Test templates by running them with AI assistants

**Template Testing Pattern:**
Include test cases in meta-prompt templates:

```markdown
## Testing Results

### Test Case 1
**Input:** [TEST_INPUT]
**Expected:** [EXPECTED_OUTPUT]
**Actual:** [ACTUAL_OUTPUT]
**Status:** [PASS/FAIL/PARTIAL]
```

---

## Development Workflow

### File Modification Guidelines

When updating templates:
1. Preserve the structured format (Character → Request → Examples → Application → Task → Evaluation)
2. Maintain placeholder syntax `[PLACEHOLDER]` for customizable sections
3. Keep emoji indicators for quality goals (🧩 🎯 🔁 📽️)
4. Update chain references if modifying input/output contracts
5. For Spec-Kit files, follow strict versioning and propagation rules

### Contributing Pattern

Follow the standard contribution workflow:

```bash
# 1. Fork and clone
git clone https://github.com/your-username/prompt-templates-demo-share.git

# 2. Create feature branch
git checkout -b feature/your-feature-name

# 3. Make changes following template conventions

# 4. Commit with descriptive message
git commit -m "Add: Brief description of template addition"

# 5. Push and create PR
git push origin feature/your-feature-name
```

### Cross-Role Consistency

When creating role-specific content:
- Use shared glossary from `/create-framework-guides/guides/shared/glossary.md`
- Follow CREATE framework structure across all role guides
- Ensure examples demonstrate realistic scenarios from that role's perspective
- Maintain consistent terminology across developer, QA, and PM guides

---

## Anti-Patterns to Avoid

### Template Anti-Patterns
- ❌ Generic placeholders without clear naming: `[FILL IN]`
- ❌ Missing Examples (E) section in CREATE templates
- ❌ Vague task descriptions: "Help with the project"
- ❌ No evaluation criteria for outputs
- ❌ Implementation details in specification documents

### Good vs Poor Examples

```markdown
✅ Good Character Definition:
"Act as a senior full-stack developer with 7+ years in React/Node.js, 
specializing in microservices architecture and RESTful API design"

❌ Poor Character Definition:
"Act as a programmer"

---

✅ Good Request:
"Implement a scalable authentication middleware using JWT tokens with 
refresh token rotation for our Express.js API"

❌ Poor Request:
"Help with authentication"

---

✅ Good Application Context:
"Microservices architecture using Node.js 18, Express 4.x, PostgreSQL 14, 
Redis for caching, deployed on AWS ECS with Docker containers. 
System handles 10K req/sec with 99.9% uptime SLA"

❌ Poor Application Context:
"A Node.js application"
```

---

## Key Principles Summary

1. **Write Prescriptive Instructions**: "Always use `[PLACEHOLDER]` syntax" not "The codebase uses placeholders"
2. **Include Real Examples**: Every pattern should have a concrete example
3. **Maintain Framework Consistency**: CREATE (Character, Request, Examples, Application, Task, Evaluation)
4. **Use Explicit Chain Markers**: Chain Input/Output for composable templates
5. **Follow Quality Checklists**: Include validation criteria in every template
6. **No Build/Test Commands**: This is documentation only—never attempt to compile or run tests
7. **Role-Based Organization**: Separate guides and templates by developer/QA/PM roles
