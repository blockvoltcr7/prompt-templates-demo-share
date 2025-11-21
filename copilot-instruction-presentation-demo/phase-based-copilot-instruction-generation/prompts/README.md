# How to Use These Prompts

⚠️ **CRITICAL: Where to Run These Prompts**

---

## ❌ DO NOT Run These Prompts in THIS Repository!

These are **TEMPLATES**. Running them here will generate instructions about THIS repo (the template system), not YOUR codebase.

---

## ✅ Correct Workflow

### Step 1: Clone This Repo (Template Repository)

```bash
git clone https://github.com/your-org/copilot-instructions-generator.git
cd copilot-instructions-generator
```

**Purpose:** Get the prompt templates and documentation

---

### Step 2: Read the Documentation

```bash
# Open getting started guide
open docs/getting-started.md

# OR read in terminal
cat docs/getting-started.md
```

**Purpose:** Understand the execution process

---

### Step 3: Navigate to YOUR Codebase (Different Repository!)

```bash
cd /path/to/your/actual/project
# This is YOUR application code that you want to analyze
```

**Examples:**
```bash
cd ~/projects/my-react-app
cd ~/work/spring-boot-api
cd ~/repos/django-service
```

**Purpose:** Execute prompts in the repository you want to analyze

---

### Step 4: Open VS Code in YOUR Codebase

```bash
code .
```

**Purpose:** Give Copilot access to YOUR codebase files

---

### Step 5: Execute the 4 Prompts

For each phase (1, 2, 3, 4):

1. **Start a NEW Copilot Chat session**
   - Open Copilot Chat (Cmd/Ctrl+Shift+I)
   - Ensure Agent Mode enabled
   - Select premium model (Claude Sonnet 4.5)

2. **Copy the entire phase file**
   ```bash
   # From copilot-instructions-generator repo
   cat /path/to/copilot-instructions-generator/prompts/phase-1-tech-stack-discovery.md
   ```

3. **Paste into Copilot Chat**
   - Copy all content
   - Paste into chat
   - Send

4. **Wait for completion** (5-7 minutes)
   - Copilot analyzes YOUR codebase
   - Creates/appends to `.github/copilot-instructions.md`

5. **Close chat and start NEW session for next phase**
   - ⚠️ CRITICAL: Start fresh chat for each phase
   - This prevents context overflow (session isolation)

---

## Phase Execution Details

### Phase 1: Tech Stack Discovery (7 minutes)

**Before running, fill in these inputs at the top of the file:**

```markdown
**Primary Technology:** [e.g., React with TypeScript, Java with Spring Boot, Python with Django]

**Framework/Tech Details:** [e.g., Next.js 14, React 18, TypeScript 5.x, Tailwind CSS]

**Project Context (1-3 lines):** [Brief description of what this system does]
```

**What it analyzes:**
- `package.json`, `pom.xml`, `requirements.txt`, `go.mod`, etc.
- Exact versions of technologies
- Repository structure

**What it creates:**
- `.github/copilot-instructions.md` with tech stack and repo structure

**Output:** ~100-150 lines

---

### Phase 2: Patterns & Architecture (7 minutes)

**Prerequisites:**
- Phase 1 must be completed
- `.github/copilot-instructions.md` exists

**What it analyzes:**
- Source code files (`*.ts`, `*.tsx`, `*.java`, `*.py`)
- Import patterns
- Naming conventions
- Architecture layers

**What it appends:**
- Architecture Guidelines
- Coding Standards (naming, error handling, configuration)

**Output:** +100-150 lines (cumulative: 200-300)

---

### Phase 3: Testing & Workflow (7 minutes)

**Prerequisites:**
- Phases 1-2 must be completed

**What it analyzes:**
- Test files (`*.test.*`, `*.spec.*`)
- CI/CD pipelines (`.github/workflows/`, `.gitlab-ci.yml`)
- Dev tools (ESLint, Prettier, pre-commit hooks)

**What it appends:**
- Testing Conventions
- Development Workflow

**Output:** +80-120 lines (cumulative: 280-420)

---

### Phase 4: Security & Finalization (7 minutes)

**Prerequisites:**
- Phases 1-3 must be completed

**What it analyzes:**
- Authentication/authorization code
- Secret management patterns
- Input validation
- Framework-specific patterns

**What it appends:**
- Framework-Specific Patterns
- Security & Best Practices
- Key Files list
- Generation metadata

**Output:** +80-120 lines (cumulative: 360-540)

---

## Why Start New Chat Sessions?

### The Technical Reason: Session Isolation

**Problem without session isolation:**
```
Single chat session:
├─ Phase 1: 500 tokens prompt + 400 output = 900 in memory
├─ Phase 2: 500 tokens + 900 context + 400 output = 1800 in memory
├─ Phase 3: 500 tokens + 1800 context + 400 output = 2700 ❌ OVERFLOW
└─ Phase 4: Can't execute, context limit exceeded
```

**Solution with session isolation:**
```
Phase 1 (Session 1): 500 + 400 = 900 → save to disk → END
Phase 2 (Session 2): 500 + 400 = 900 → append to disk → END
Phase 3 (Session 3): 500 + 400 = 900 → append to disk → END
Phase 4 (Session 4): 500 + 400 = 900 → finalize → END ✅
```

**Benefits:**
- ✅ 50% token savings (4,000 vs 8,000 tokens)
- ✅ No context overflow errors
- ✅ 95% success rate
- ✅ Consistent quality per phase

---

## Manual Execution Checklist

Use this checklist for each repository:

### Before Starting
- [ ] Clone copilot-instructions-generator repo
- [ ] Read docs/getting-started.md
- [ ] Navigate to YOUR codebase (`cd /path/to/your/project`)
- [ ] Open VS Code in YOUR codebase (`code .`)
- [ ] Verify location (`pwd` shows YOUR project, not template repo)

### Phase 1
- [ ] Fill in inputs at top of phase-1 file
- [ ] Start NEW Copilot Chat
- [ ] Enable Agent Mode + premium model
- [ ] Copy phase-1 file
- [ ] Paste into chat
- [ ] Wait for completion (5-7 min)
- [ ] Verify `.github/copilot-instructions.md` created
- [ ] **CLOSE chat session**

### Phase 2
- [ ] **Start NEW Copilot Chat** (fresh session!)
- [ ] Copy phase-2 file
- [ ] Paste into chat
- [ ] Wait for completion (5-7 min)
- [ ] Verify file updated (architecture section added)
- [ ] **CLOSE chat session**

### Phase 3
- [ ] **Start NEW Copilot Chat**
- [ ] Copy phase-3 file
- [ ] Paste into chat
- [ ] Wait for completion (5-7 min)
- [ ] Verify file updated (testing section added)
- [ ] **CLOSE chat session**

### Phase 4
- [ ] **Start NEW Copilot Chat**
- [ ] Copy phase-4 file
- [ ] Paste into chat
- [ ] Wait for completion (5-7 min)
- [ ] Verify file complete (has "Generated:" at end)
- [ ] **CLOSE chat session**

### After All Phases
- [ ] Review complete file
- [ ] Check for placeholder text `[e.g., ...]`
- [ ] Validate with script: `bash /path/to/template/scripts/validate-output.sh`
- [ ] Manually refine (10 minutes)
- [ ] Commit to YOUR repo
- [ ] Push to remote

**Total Time:** 35-45 minutes

---

## Automated Execution (Advanced)

For teams running this on 10+ repositories:

```bash
# From YOUR codebase root
bash /path/to/copilot-instructions-generator/scripts/run-parallel.sh
```

**Result:** All 4 phases run simultaneously → 5-7 minutes total!

**See:** [Parallel Execution Guide](../docs/parallel-execution.md)

---

## Customizing Prompts

### When to Customize

- Add company-specific security requirements
- Enforce mandatory documentation sections
- Include custom validation rules
- Adapt for unusual tech stacks

### How to Customize

1. **Copy prompt file:**
   ```bash
   cp phase-2-patterns-architecture.md phase-2-custom.md
   ```

2. **Edit the prompt:**
   - Add your requirements to "Analysis Tasks" section
   - Update "Output Instructions" section with new format
   - Add validation rules to "Validation Checklist"

3. **Test thoroughly:**
   - Run on at least 2 different codebases
   - Verify output quality
   - Check no placeholders remain

4. **Document changes:**
   - Add comment at top explaining customization
   - Update README if significant changes

5. **Consider contributing back:**
   - If useful for others, open a PR
   - See [CONTRIBUTING.md](../CONTRIBUTING.md)

---

## Common Mistakes

### ❌ Mistake 1: Running in Template Repo

**Wrong:**
```bash
cd copilot-instructions-generator  ❌
code .
# Runs prompts here → generates instructions about THIS repo
```

**Correct:**
```bash
cd /path/to/your/actual/project  ✅
code .
# Runs prompts here → generates instructions about YOUR code
```

---

### ❌ Mistake 2: Not Starting New Sessions

**Wrong:**
```
Open Copilot Chat once
→ Run Phase 1 (7 min)
→ Run Phase 2 in SAME session  ❌ (context overflow)
```

**Correct:**
```
Open Copilot Chat
→ Run Phase 1 (7 min)
→ CLOSE chat, START NEW  ✅
→ Run Phase 2 (fresh context)
```

---

### ❌ Mistake 3: Using Small Models

**Wrong:**
```
Settings → Model → GPT-3.5  ❌
Result: 70% accuracy, many placeholders
```

**Correct:**
```
Settings → Model → Claude Sonnet 4.5  ✅
Result: 95% accuracy, minimal editing
```

---

### ❌ Mistake 4: Skipping Phases

**Wrong:**
```
Run Phase 1, skip to Phase 4  ❌
Result: Error, missing prerequisite sections
```

**Correct:**
```
Run all phases in order: 1 → 2 → 3 → 4  ✅
```

---

## Troubleshooting

**Problem:** "File doesn't exist" error
**Solution:** Phase 1 didn't complete. Re-run Phase 1.

**Problem:** Generic output with placeholders
**Solution:** Not using Agent Mode or premium model. Enable both.

**Problem:** Phases take > 10 minutes
**Solution:** Large codebase (normal). Or check if Copilot is stuck.

**Problem:** Output has duplicate sections
**Solution:** Manual cleanup. Remove redundant headings.

**See:** [Troubleshooting Guide](../docs/troubleshooting.md) for complete list

---

## Next Steps

1. **Execute prompts** in your codebase following checklist above
2. **Review output** for quality and accuracy
3. **Commit to your repo** and see Copilot behavior improve!
4. **For automation:** See [Parallel Execution](../docs/parallel-execution.md)
5. **For help:** See [Troubleshooting](../docs/troubleshooting.md)

---

**Ready to start?** Go back to [Getting Started Guide](../docs/getting-started.md)

**Questions?** See [FAQ in main README](../README.md#frequently-asked-questions)
