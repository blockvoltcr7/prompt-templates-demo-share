# GitHub Copilot Modes in VS Code: Ask vs Edit vs Agent

A comprehensive comparison of the three GitHub Copilot interaction modes for developers and QA engineers.

---

## Quick Summary

| Mode | Purpose | Control Level | Best For |
|------|---------|---------------|----------|
| **Ask** | Q&A assistant | Highest (read-only) | Questions, explanations |
| **Edit** | Targeted changes | High (you select files) | Surgical refactoring |
| **Agent** | Autonomous execution | Lowest (AI decides) | Complex multi-file tasks |

---

## 1. Ask Mode

### What It Does
Conversational Q&A assistant that answers programming questions without modifying your code. A "quiet whisper in your editor" for guidance.

### When to Use It
- Asking questions about your codebase
- Learning framework syntax and features
- Understanding how specific code works
- Debugging and error explanations
- Quick informational queries

### Key Capabilities
- Natural language questions about code
- Explains existing code in your project
- Provides code examples and suggestions
- Reviews and analyzes code snippets

### Limitations
- Cannot modify code files directly
- Only provides suggestions you must manually implement
- Single response without iterative refinement
- Does not run terminal commands

### How to Activate
- **Open Chat:** `Ctrl+Alt+I` (Windows/Linux) or `Ctrl+Cmd+I` (Mac)
- **Select Mode:** Click dropdown at bottom of Chat panel, select "Ask"
- **Inline Chat:** `Ctrl+I` / `Cmd+I` for quick questions in editor

### QA Engineer Examples
```
"How does this authentication middleware work?"
"What test patterns are used in this project?"
"Explain this error message from the test suite"
"What's the best way to test this component?"
```

---

## 2. Edit Mode

### What It Does
Targeted code modifications across files you explicitly select. Shows each change inline for review before saving. "Surgical precision" editing.

### When to Use It
- Targeted refactoring across specific files
- Making well-defined changes to existing code
- Brownfield projects where you need to avoid touching unrelated systems
- Updating code styles or naming conventions
- When you need visibility into every change before applying

### Key Capabilities
- Choose which files can be edited (Working Set)
- Multi-file simultaneous edits
- Natural language description of changes
- Inline diffs for review before accepting
- Iterative refinement: run, verify, undo if needed

### Limitations
- Requires explicit file selection before making changes
- Cannot automatically infer related changes outside working set
- Does not run terminal commands or execute tests
- Best for well-defined changes, not exploratory tasks

### How to Activate
- **Open Chat:** `Ctrl+Alt+I` (Windows/Linux) or `Ctrl+Cmd+I` (Mac)
- **Select Mode:** Click dropdown, select "Edit"
- **Add Files:**
  - Drag and drop files/tabs
  - Press `#` to explicitly add files
  - Use file picker dialog

### QA Engineer Examples
- Updating test assertions across multiple test files
- Refactoring test setup/teardown code
- Standardizing test naming conventions
- Adding missing test documentation
- Converting test framework syntax

---

## 3. Agent Mode

### What It Does
Most autonomous mode. You provide a high-level task, and Copilot independently plans, selects files, runs terminal commands, iterates, and self-corrects until complete. Like a pair programmer that works independently.

### When to Use It
- Building complete features from high-level requirements
- Scaffolding entire sections of an application
- Large refactoring across multiple files
- Creating new files and project structure
- Complex tasks requiring terminal commands and tests
- Greenfield projects with clear guidelines
- Migrating legacy code to modern frameworks

### Key Capabilities
- Autonomous multi-step task execution
- Analyzes and identifies necessary changes across files
- Selects and edits relevant files automatically
- Runs terminal commands and tests
- Self-healing: detects and fixes errors automatically
- Iterates until task completion
- Creates new files and directories
- Applies consistent changes across codebase

### Limitations
- Less user control than Ask or Edit modes
- Requires detailed context in prompts for best results
- May make assumptions about architecture
- Can take longer for complex tasks
- Requires VS Code 1.99 or later

### How to Activate
- **Prerequisites:** VS Code 1.99+
- **Enable Setting:** `chat.agent.enabled` = true
- **Open Chat:** `Ctrl+Alt+I` (Windows/Linux) or `Ctrl+Cmd+I` (Mac)
- **Select Mode:** Click dropdown, select "Agent"
- **Switch Shortcut:** `Ctrl+Shift+I` (Windows)

### QA Engineer Examples
```
"Create a comprehensive test suite for the authentication module"
"Set up end-to-end tests for the user registration flow"
"Migrate all tests from Jest to Vitest with proper configuration"
"Generate performance benchmarks for critical API endpoints"
"Build testing infrastructure with CI/CD integration"
```

---

## Detailed Comparison Table

| Feature | Ask Mode | Edit Mode | Agent Mode |
|---------|----------|-----------|------------|
| **User Control** | Highest | High | Lowest |
| **Code Modification** | None | Selected files | Multi-file autonomous |
| **Scope** | Read-only | Working set | Entire project |
| **Best For** | Quick questions | Targeted changes | Complex features |
| **Iteration** | Single response | User-directed | Autonomous loops |
| **Terminal Commands** | No | No | Yes |
| **Test Execution** | No | No | Yes |
| **Self-Healing** | N/A | N/A | Yes |
| **File Selection** | N/A | Explicit | Automatic |
| **Approval Process** | N/A | Per-change review | Less frequent |

---

## Keyboard Shortcuts Reference

### Common Shortcuts

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Open Chat view | `Ctrl+Alt+I` | `Ctrl+Cmd+I` |
| Inline chat | `Ctrl+I` | `Cmd+I` |
| Accept suggestion | `Tab` | `Tab` |
| Reject suggestion | `Esc` | `Esc` |
| Next suggestion | `Alt+]` | `Option+]` |
| Previous suggestion | `Alt+[` | `Option+[` |

### Mode-Specific

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Switch to Agent mode | `Ctrl+Shift+I` | `Shift+Cmd+I` |
| Quick chat | `Ctrl+Shift+Alt+L` | `Shift+Option+Cmd+L` |
| Add files (Edit mode) | `#` | `#` |

---

## When to Use Each Mode: Decision Flowchart

```
What do you need?
│
├─ Just have a question?
│  └─ Use ASK MODE
│
├─ Need to change specific files you can identify?
│  └─ Use EDIT MODE
│
└─ Need to build/refactor something complex across many files?
   └─ Use AGENT MODE
```

---

## Tips for Best Results

### Ask Mode
- Ask specific, focused questions
- Reference files or code blocks for context
- Use for learning and understanding

### Edit Mode
- Clearly define which files should be modified
- Describe the desired outcome specifically
- Review each change before accepting

### Agent Mode
- Provide detailed custom instructions (`.github/instructions.md`)
- Define coding standards and architectural guidelines
- Be specific about requirements
- Let it iterate - don't interrupt unless necessary
- Enable `github.copilot.chat.agent.autoFix` setting

---

## Sources

- [GitHub Blog: Copilot ask, edit, and agent modes](https://github.blog/ai-and-ml/github-copilot/copilot-ask-edit-and-agent-modes-what-they-do-and-when-to-use-them/)
- [VS Code Blog: Introducing GitHub Copilot agent mode](https://code.visualstudio.com/blogs/2025/02/24/introducing-copilot-agent-mode)
- [VS Code Docs: Use agent mode](https://code.visualstudio.com/docs/copilot/chat/chat-agent-mode)
- [GitHub Docs: Copilot features](https://docs.github.com/en/copilot/get-started/features)
- [GitHub Docs: Keyboard shortcuts](https://docs.github.com/en/copilot/reference/keyboard-shortcuts?tool=vscode)
