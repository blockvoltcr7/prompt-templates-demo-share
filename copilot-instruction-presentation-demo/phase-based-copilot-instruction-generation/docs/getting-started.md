# Quick Start Guide: Phase-Based Copilot Instructions

**Target Audience:** Engineers executing the phase-based prompt system
**Time Required:** 35-45 minutes
**Prerequisites:** GitHub Copilot license, VS Code with Copilot extension

---

## 📋 Overview

This guide walks you through generating a custom `.github/copilot-instructions.md` file for your repository using the 4-phase prompt template system.

**What You'll Do:**
1. Prepare inputs (2 minutes)
2. Run Phase 1: Tech Stack Discovery (7 minutes)
3. Run Phase 2: Patterns & Architecture (7 minutes)
4. Run Phase 3: Testing & Workflow (7 minutes)
5. Run Phase 4: Security & Finalization (7 minutes)
6. Review & polish (10 minutes)
7. Commit and push (1 minute)

**Total Time:** 35-45 minutes

---

## 🎯 Success Checklist

Before you start, ensure:
- [ ] You have GitHub Copilot license active
- [ ] VS Code is installed with Copilot extension
- [ ] You're using Agent mode in Copilot Chat
- [ ] You're using a premium model (Claude Sonnet 4.5, GPT-5, or Opus recommended)
- [ ] Repository has code to analyze (not empty)
- [ ] You have 45 minutes of uninterrupted time

---

## Step 0: Setup (2 Minutes)

### 1. Clone or Navigate to Repository

```bash
cd /path/to/your/repository
```

### 2. Open VS Code in Repository Root

```bash
code .
```

### 3. Open GitHub Copilot Chat

- **Keyboard Shortcut:** `Cmd+Shift+I` (Mac) or `Ctrl+Shift+I` (Windows/Linux)
- **Menu:** View → Command Palette → "GitHub Copilot: Open Chat"

### 4. Enable Agent Mode

- Click the settings icon in Copilot Chat
- Select **Agent Mode**
- Choose **Claude Sonnet 4.5** (or GPT-5/Opus)

### 5. Locate Phase Files

The phase files are located in:
```
prompt-template-phases/
├── phase-1-tech-stack-discovery.md
├── phase-2-patterns-architecture.md
├── phase-3-testing-workflow.md
└── phase-4-finalize-polish.md
```

---

## Step 1: Prepare Inputs (2 Minutes)

### Open `phase-1-tech-stack-discovery.md`

Find this section:

```markdown
## 📋 Inputs (Fill BEFORE RUNNING)

**Primary Technology:** [Input the primary technology here]

**Framework/Tech Details:** [Input tech details]

**Project Context (1-3 lines):** [Input a short description about this code repo]
```

### Fill In Your Project Details

**Example:**
```markdown
**Primary Technology:** React with TypeScript

**Framework/Tech Details:** Next.js 14, React 18, TypeScript 5.x, Tailwind CSS

**Project Context (1-3 lines):** E-commerce storefront application with server-side rendering,
user authentication, product catalog, shopping cart, and checkout flow. Uses Supabase for
backend and Stripe for payments.
```

**Tips:**
- Be specific about versions if you know them
- Mention key frameworks and libraries
- Keep project context concise (2-3 sentences max)

---

## Step 2: Run Phase 1 - Tech Stack Discovery (7 Minutes)

### 1. Start a New Chat Session

- Close any existing Copilot Chat tabs
- Open a fresh Copilot Chat window
- **Why?** Session isolation prevents context overflow

### 2. Copy Entire Phase 1 File

- Open `phase-1-tech-stack-discovery.md`
- Select all content (`Cmd+A` or `Ctrl+A`)
- Copy (`Cmd+C` or `Ctrl+C`)

### 3. Paste into Copilot Chat

- Paste into Copilot Chat (`Cmd+V` or `Ctrl+V`)
- Send the message

### 4. Wait for Completion (5-7 Minutes)

Copilot will:
- ✅ Analyze `package.json`, `pom.xml`, or equivalent config files
- ✅ Detect technology versions
- ✅ Map repository structure
- ✅ Generate initial `.github/copilot-instructions.md` file
- ✅ Create "Project Overview", "Technology Stack", and "Repository Structure" sections

### 5. Verify Output

Check that `.github/copilot-instructions.md` was created with:
- [ ] Project overview (2-4 lines)
- [ ] Technology stack table with versions
- [ ] Repository structure diagram
- [ ] No placeholder text like `[e.g., ...]`

### 6. Start a NEW Chat Session

⚠️ **CRITICAL:** Close the current chat and start fresh for Phase 2

**Why this matters:**
- Prevents context window accumulation
- Reduces token costs by 50%
- Keeps each phase focused and reliable

---

## Step 3: Run Phase 2 - Patterns & Architecture (7 Minutes)

### 1. Start a New Chat Session

- Close the Phase 1 chat
- Open a fresh Copilot Chat window

### 2. Copy Entire Phase 2 File

- Open `phase-2-patterns-architecture.md`
- Select all content (`Cmd+A` or `Ctrl+A`)
- Copy (`Cmd+C` or `Ctrl+C`)

### 3. Paste into Copilot Chat

- Paste and send

### 4. Wait for Completion (5-7 Minutes)

Copilot will:
- ✅ Read existing `.github/copilot-instructions.md` from Phase 1
- ✅ Analyze source code patterns
- ✅ Identify naming conventions
- ✅ Document architecture layers
- ✅ Append "Architecture Guidelines" and "Coding Standards" sections

### 5. Verify Output

Check that `.github/copilot-instructions.md` now includes:
- [ ] Architecture Guidelines section
- [ ] Naming conventions (files, classes, functions, variables)
- [ ] Error handling patterns with code examples
- [ ] Configuration patterns
- [ ] "NEVER Do" anti-patterns section

### 6. Start a NEW Chat Session

⚠️ Close and start fresh for Phase 3

---

## Step 4: Run Phase 3 - Testing & Workflow (7 Minutes)

### 1. Start a New Chat Session

- Close the Phase 2 chat
- Open a fresh Copilot Chat window

### 2. Copy Entire Phase 3 File

- Open `phase-3-testing-workflow.md`
- Select all (`Cmd+A` or `Ctrl+A`)
- Copy (`Cmd+C` or `Ctrl+C`)

### 3. Paste into Copilot Chat

- Paste and send

### 4. Wait for Completion (5-7 Minutes)

Copilot will:
- ✅ Read existing file from Phases 1-2
- ✅ Analyze test files and test frameworks
- ✅ Review CI/CD pipeline configuration
- ✅ Document development workflow
- ✅ Append "Testing Conventions" and "Development Workflow" sections

### 5. Verify Output

Check that `.github/copilot-instructions.md` now includes:
- [ ] Testing Conventions (unit, integration, E2E)
- [ ] Test framework details
- [ ] Mocking/stubbing patterns
- [ ] Coverage requirements
- [ ] CI/CD pipeline steps
- [ ] Code quality tools (linter, formatter)
- [ ] Example test structure

### 6. Start a NEW Chat Session

⚠️ Close and start fresh for Phase 4 (final phase)

---

## Step 5: Run Phase 4 - Security & Finalization (7 Minutes)

### 1. Start a New Chat Session

- Close the Phase 3 chat
- Open a fresh Copilot Chat window

### 2. Copy Entire Phase 4 File

- Open `phase-4-finalize-polish.md`
- Select all (`Cmd+A` or `Ctrl+A`)
- Copy (`Cmd+C` or `Ctrl+C`)

### 3. Paste into Copilot Chat

- Paste and send

### 4. Wait for Completion (5-7 Minutes)

Copilot will:
- ✅ Read existing file from Phases 1-3
- ✅ Analyze security patterns (authentication, authorization)
- ✅ Document framework-specific patterns
- ✅ Add secret management approach
- ✅ Document input validation patterns
- ✅ Append "Framework-Specific Patterns", "Security & Best Practices", and "Key Files" sections
- ✅ Finalize the complete file

### 5. Verify Output

Check that `.github/copilot-instructions.md` is now complete with:
- [ ] Framework-Specific Patterns section
- [ ] Security & Best Practices section
- [ ] Authentication & Authorization details
- [ ] Secret Management approach
- [ ] Input Validation patterns
- [ ] API Security measures
- [ ] Key Files list
- [ ] Generation timestamp and metadata

---

## Step 6: Review & Polish (10 Minutes)

### 1. Read the Complete File

Open `.github/copilot-instructions.md` and review all sections.

### 2. Validation Checklist

- [ ] **No Placeholder Text:** All `[e.g., ...]` or `[pattern]` placeholders filled in
- [ ] **Real Examples:** All code examples from actual codebase files
- [ ] **Accurate Tech Stack:** All technology versions match your project
- [ ] **Relevant Patterns:** No generic advice, all patterns specific to your code
- [ ] **No Duplicates:** No repeated content across sections
- [ ] **Prescriptive Language:** Instructions use "Always do X" not "The codebase does X"
- [ ] **Complete Sections:** All expected sections present

### 3. Manual Refinements (Optional)

Add any project-specific rules or guidelines that the AI might have missed:

```markdown
## Custom Team Rules

**Code Review Standards:**
- All PRs require 2 approvals
- No commits directly to main branch
- Automated tests must pass before merge

**Deployment Process:**
- Only deploy on Tuesday/Thursday
- Staging deployment required before production
- Rollback plan documented in each PR
```

### 4. Get Team Feedback

Consider:
- Share with 2-3 team members for quick review
- Ask: "Does this match our actual patterns?"
- Incorporate feedback before final commit

---

## Step 7: Commit & Push (1 Minute)

### 1. Stage the File

```bash
git add .github/copilot-instructions.md
```

### 2. Commit with Descriptive Message

```bash
git commit -m "Add GitHub Copilot instructions (phase-based generation)

- 4-phase automated analysis of codebase
- Tech stack, patterns, testing, security documented
- Generated using Claude Sonnet 4.5 in agent mode
- Reviewed and validated by team"
```

### 3. Push to Remote

```bash
git push origin main
```

(Or create a PR if that's your team's workflow)

---

## ✅ Verification: Is It Working?

### Test 1: Open a Source File

1. Open any `.ts`, `.tsx`, `.java`, or `.py` file in your repo
2. Start typing a function or component
3. **Expected:** Copilot suggestions should match your project's patterns

### Test 2: Ask Copilot

In Copilot Chat, ask:
```
What instructions do you have for this project?
```

**Expected Response:** Copilot should reference `.github/copilot-instructions.md` and summarize the key patterns.

### Test 3: Check Naming Conventions

Start typing a new file name or function name. Copilot should suggest names matching the conventions documented in your instructions.

---

## 🔧 Troubleshooting

### Problem: "File doesn't exist" error in Phase 2+

**Cause:** Phase 1 didn't complete successfully

**Solution:**
1. Check if `.github/copilot-instructions.md` exists
2. If not, re-run Phase 1
3. Verify file has content before moving to Phase 2

---

### Problem: Copilot says "I can't find evidence of that technology"

**Cause:** Inputs in Phase 1 don't match actual tech stack

**Solution:**
1. Check `package.json`, `pom.xml`, or equivalent config file
2. Update Phase 1 inputs to match actual technologies
3. Re-run Phase 1 with corrected inputs

---

### Problem: Generated content seems generic

**Cause:** Copilot didn't use `#codebase` queries effectively

**Solution:**
1. Ensure you're in Agent Mode
2. Verify workspace is correctly set to repository root
3. Try adding more specific prompts: "Search for actual test files in this repo"

---

### Problem: Some sections are duplicated

**Cause:** Phase 4 didn't deduplicate properly

**Solution:**
1. Manually remove duplicate sections
2. Use Find & Replace to consolidate repeated content

---

### Problem: Phase execution takes longer than 7 minutes

**Cause:** Large codebase or complex analysis

**Solution:**
- This is normal for large repositories
- Budget 10-12 minutes per phase for very large codebases
- Total time might be 50-60 minutes instead of 35-45

---

### Problem: Output has placeholder text like `[e.g., ...]`

**Cause:** AI couldn't find specific examples in codebase

**Solution:**
1. Manually replace placeholders with real examples
2. Check if files exist in locations AI searched
3. Add specific file paths in follow-up prompt: "Analyze src/components/Button.tsx for naming patterns"

---

## 📊 What Success Looks Like

### Immediate Success (Day 1)
- ✅ Complete `.github/copilot-instructions.md` file
- ✅ 200-500 lines of project-specific instructions
- ✅ All sections present and filled in
- ✅ Team reviewed and approved

### Short-Term Success (Week 1-4)
- ✅ Copilot suggestions match team patterns
- ✅ Fewer code review comments about style/patterns
- ✅ New developers report helpful Copilot guidance
- ✅ No generic or off-pattern code suggestions

### Long-Term Success (Quarter 1-4)
- ✅ 20-30% reduction in code review time
- ✅ Faster onboarding (new devs productive in days, not weeks)
- ✅ Consistent code quality across team
- ✅ Quarterly update process established

---

## 🚀 Next Steps

### For This Repository
1. ✅ Share the instructions file with your team
2. ✅ Add calendar reminder for quarterly update (3 months)
3. ✅ Document any manual refinements you made
4. ✅ Track metrics (code review time, onboarding speed)

### For Your Organization
1. Document your experience (what worked well, what didn't)
2. Share learnings with other teams
3. Consider pilot program for organization-wide rollout
4. Explore automation (parallel execution, GitHub Actions)

---

## 📚 Related Documentation

- **[Overview](./01-Overview-Phase-Based-Copilot-Instructions.md)** - Complete system overview
- **[Technical Deep Dive](./03-Technical-Deep-Dive.md)** - Prompt engineering patterns
- **[Solution Architect Review](../docs/SOLUTION-ARCHITECT-REVIEW.md)** - Business case and ROI
- **[Parallel Execution Guide](../docs/PARALLEL-EXECUTION-GUIDE.md)** - Automation approach

---

## ❓ FAQ

**Q: Do I need to start a new chat session for EVERY phase?**
A: Yes! Session isolation is critical. It prevents context overflow and reduces costs by 50%.

**Q: Can I skip phases?**
A: No. Each phase depends on previous phases. Running them out of order will fail.

**Q: Can I run phases in parallel?**
A: Not manually, but yes with automation! See `PARALLEL-EXECUTION-GUIDE.md` for shell script approach.

**Q: What if I need to stop midway?**
A: No problem! Your progress is saved in `.github/copilot-instructions.md`. Just resume from the next phase when ready.

**Q: Can I customize the phase files?**
A: Yes, but carefully. The structure and validation checkpoints are important. Document any changes you make.

**Q: What model should I use?**
A: **Recommended:** Claude Sonnet 4.5 (95% accuracy), GPT-5, or Opus. Avoid smaller models like GPT-3.5.

**Q: How often should I update the instructions?**
A: **Quarterly** (every 3 months) or when major codebase changes occur (new framework, major refactor, etc.)

---

**Last Updated:** 2025-11-21
**Version:** 2.0
**Status:** Production Ready

For questions or issues, contact the DevOps team or open an issue in the project repository.
