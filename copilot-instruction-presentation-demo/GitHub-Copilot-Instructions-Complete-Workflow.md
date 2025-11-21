# GitHub Copilot Instructions - Complete Workflow
## Two-Step Automated Instruction System

---

## 📋 Overview

This document provides a visual representation of the complete two-step workflow for generating GitHub Copilot instruction files in your repository.

**Total Time:** ~20 minutes initially | ~5 minutes for quarterly updates
**Result:** Comprehensive monolithic file + focused specialized playbooks

---

## 🔄 Complete Workflow Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          PREREQUISITES                                   │
├─────────────────────────────────────────────────────────────────────────┤
│ ✅ GitHub Copilot license active                                        │
│ ✅ VS Code with GitHub Copilot extension installed                      │
│ ✅ Repository contains actual code (not empty)                          │
│ ✅ Copilot set to "Agent" mode (not "Ask" or "Edit")                   │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                    STEP 1: GENERATE MONOLITHIC FILE                      │
│                        (2-3 minutes automated)                           │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  📄 Run: copilot-instruction-main-file-generator.md                      │
│                                                                           │
│  Actions Performed:                                                      │
│  ├── 1. Analyzes entire codebase                                        │
│  ├── 2. Detects technology stack (languages, frameworks, versions)      │
│  ├── 3. Identifies patterns (architecture, testing, security)           │
│  ├── 4. Cites evidence (actual files with line numbers)                 │
│  └── 5. Generates comprehensive instruction file                        │
│                                                                           │
│  Output:                                                                 │
│  └── .github/copilot-instructions.md (~200-500 lines)                   │
│      ├── Project Overview                                               │
│      ├── Technology Stack (all languages/frameworks)                    │
│      ├── Architecture Guidelines                                        │
│      ├── General Coding Standards                                       │
│      ├── Framework-Specific Patterns (ALL technologies)                 │
│      ├── Security & Best Practices                                      │
│      ├── Testing Conventions                                            │
│      ├── Development Workflow                                           │
│      └── Evidence References                                            │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                    STEP 2: HUMAN REVIEW & APPROVAL                       │
│                          (15 minutes)                                    │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  Team Actions:                                                           │
│  ├── ✅ Senior developer reviews generated file for accuracy            │
│  ├── ✅ Team adds project-specific context (e.g., "never use X library")│
│  ├── ✅ Remove irrelevant sections (if any)                             │
│  ├── ✅ Verify evidence citations match actual code                     │
│  └── ✅ Commit approved .github/copilot-instructions.md to repo         │
│                                                                           │
│  Quality Check:                                                          │
│  └── File should be ~90% accurate from automation, 10% human refinement │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│              STEP 3: GENERATE SPECIALIZED PLAYBOOKS                      │
│                        (2-3 minutes automated)                           │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  📄 Run: Create-Path-Specific-Copilot-Instructions-V2.md                │
│                                                                           │
│  Input:                                                                  │
│  └── Approved .github/copilot-instructions.md from Step 2               │
│                                                                           │
│  Actions Performed:                                                      │
│  ├── 1. Analyzes monolithic file for technology boundaries              │
│  ├── 2. Maps evidence paths to directory patterns                       │
│  ├── 3. Derives focused playbooks for each technology:                  │
│  │   ├── Extract patterns relevant to specific tech                     │
│  │   ├── Remove patterns from other technologies                        │
│  │   ├── Adapt language to be technology-specific                       │
│  │   └── Generate applyTo glob patterns                                 │
│  ├── 4. Validates playbooks against actual codebase                     │
│  └── 5. Appends file list to monolithic file                            │
│                                                                           │
│  Output:                                                                 │
│  ├── .github/instructions/backend.instructions.md (~50-150 lines)       │
│  │   ├── applyTo: "src/main/java/**/*.java"                             │
│  │   └── Contains: Java/Spring Boot patterns only                       │
│  │                                                                        │
│  ├── .github/instructions/frontend.instructions.md (~50-150 lines)      │
│  │   ├── applyTo: ["src/**/*.tsx", "src/**/*.jsx"]                      │
│  │   └── Contains: React/TypeScript patterns only                       │
│  │                                                                        │
│  ├── .github/instructions/tests.instructions.md (~50-150 lines)         │
│  │   ├── applyTo: ["**/*.test.*", "**/*.spec.*"]                        │
│  │   └── Contains: Testing patterns only                                │
│  │                                                                        │
│  └── Updated .github/copilot-instructions.md                            │
│      └── (Appends list of specialized files at end)                     │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                    STEP 4: COMMIT ALL FILES                              │
│                          (1 minute)                                      │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  Git Actions:                                                            │
│  ├── git add .github/copilot-instructions.md                            │
│  ├── git add .github/instructions/*.instructions.md                     │
│  ├── git commit -m "Add GitHub Copilot instruction files"               │
│  └── git push                                                            │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                     ✅ COMPLETE: NOW ACTIVE                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  How It Works in Practice:                                              │
│                                                                           │
│  📂 When developer starts ANY Copilot chat session:                     │
│  └── Copilot loads .github/copilot-instructions.md (complete context)   │
│                                                                           │
│  📂 When developer edits UserController.java:                           │
│  ├── Copilot loads .github/copilot-instructions.md (as always)          │
│  └── ALSO loads .github/instructions/backend.instructions.md            │
│      └── Result: Complete context + focused Java/Spring Boot patterns   │
│                                                                           │
│  📂 When developer edits LoginForm.tsx:                                 │
│  ├── Copilot loads .github/copilot-instructions.md (as always)          │
│  └── ALSO loads .github/instructions/frontend.instructions.md           │
│      └── Result: Complete context + focused React patterns              │
│                                                                           │
│  📂 When developer edits auth.test.ts:                                  │
│  ├── Copilot loads .github/copilot-instructions.md (as always)          │
│  └── ALSO loads .github/instructions/tests.instructions.md              │
│      └── Result: Complete context + focused testing patterns            │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 🔄 Maintenance Workflow (Quarterly - Every 3 Months)

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    QUARTERLY UPDATE PROCESS                              │
│                          (5 minutes total)                               │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  Trigger: Significant codebase changes                                  │
│  ├── New framework/library added                                        │
│  ├── Major refactoring completed                                        │
│  ├── Architectural patterns changed                                     │
│  └── New testing strategies adopted                                     │
│                                                                           │
│  Actions:                                                                │
│  ├── 1. Re-run copilot-instruction-main-file-generator.md               │
│  │   └── Generates updated monolithic file (2 min)                      │
│  ├── 2. Team reviews for accuracy                                       │
│  │   └── Merge with any custom team additions (2 min)                   │
│  ├── 3. Re-run Create-Path-Specific-Copilot-Instructions-V2.md          │
│  │   └── Regenerates specialized playbooks (1 min)                      │
│  └── 4. Commit updated files                                            │
│                                                                           │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 📊 File Structure Summary

```
your-repository/
├── .github/
│   ├── copilot-instructions.md          ← MONOLITHIC (Complete context)
│   │                                        Loaded: EVERY Copilot session
│   │                                        Contains: All technologies, all patterns
│   │
│   └── instructions/
│       ├── backend.instructions.md       ← SPECIALIZED (Focused guidance)
│       │                                    Loaded: When editing *.java files
│       │                                    Contains: Java/Spring Boot only
│       │
│       ├── frontend.instructions.md      ← SPECIALIZED (Focused guidance)
│       │                                    Loaded: When editing *.tsx/*.jsx files
│       │                                    Contains: React/TypeScript only
│       │
│       └── tests.instructions.md         ← SPECIALIZED (Focused guidance)
│                                            Loaded: When editing *.test.* files
│                                            Contains: Testing patterns only
```

---

## ✅ Success Criteria Checklist

### Initial Setup (First Time)
- [ ] Monolithic file generated and committed
- [ ] Team reviewed and approved monolithic file
- [ ] Specialized playbooks generated and committed
- [ ] All applyTo patterns validated (match actual files)
- [ ] File list appended to monolithic file
- [ ] Developers can see instructions loading in Copilot

### Validation (After Setup)
- [ ] Open a Java file → backend.instructions.md loads
- [ ] Open a React file → frontend.instructions.md loads
- [ ] Open a test file → tests.instructions.md loads
- [ ] Copilot suggestions match our patterns (not generic)
- [ ] No noise (React devs don't see Java patterns)

### Long-Term Maintenance
- [ ] Quarterly review calendar event created
- [ ] Process documented for team onboarding
- [ ] Designated owner for quarterly updates
- [ ] GitHub Actions for drift detection (future automation)

---

## 🎯 Key Benefits Recap

```
┌──────────────────────────────────────────────────────────────────┐
│                    BEFORE (Generic Copilot)                      │
├──────────────────────────────────────────────────────────────────┤
│ ❌ Generic code suggestions                                      │
│ ❌ Inconsistent patterns across team                             │
│ ❌ Long code review cycles (fixing style/patterns)               │
│ ❌ Slow onboarding (learning wrong patterns)                     │
│ ❌ Knowledge silos (tribal rules not documented)                 │
└──────────────────────────────────────────────────────────────────┘
                                ↓
┌──────────────────────────────────────────────────────────────────┐
│              AFTER (Two-Step Instruction System)                 │
├──────────────────────────────────────────────────────────────────┤
│ ✅ Project-specific code matching YOUR patterns                  │
│ ✅ Consistent code across all team members                       │
│ ✅ 20-30% reduction in code review time                          │
│ ✅ 50% faster onboarding for new developers                      │
│ ✅ Knowledge democratization (AI teaches best practices)         │
│ ✅ No noise (focused guidance per file type)                     │
└──────────────────────────────────────────────────────────────────┘
```

---

## 📚 Related Documentation

- **Primary Prompt:** `copilot-instruction-main-file-generator.md`
- **Follow-Up Prompt:** `Create-Path-Specific-Copilot-Instructions-V2.md`
- **Presentation Deck:** `GitHub-Copilot-Instructions-Presentation-Deck-FINAL.md`
- **Official GitHub Docs:** [Adding repository custom instructions for GitHub Copilot](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)

---

## ❓ FAQ

**Q: Do I need to run both prompts every time?**
A: Only initially and for quarterly updates. Day-to-day development just uses the existing files.

**Q: What if my repo has multiple languages (full-stack)?**
A: Perfect! The monolithic file documents all technologies, and you'll get multiple specialized playbooks (backend.instructions.md + frontend.instructions.md + tests.instructions.md).

**Q: Can I manually edit the generated files?**
A: Yes! The prompts generate 90% accuracy. Teams should refine the remaining 10% with project-specific rules.

**Q: What happens if I skip Step 3 (specialized files)?**
A: The monolithic file alone still works and provides value. Specialized files are the "advanced layer" that eliminates noise.

**Q: How do I know if specialized files are loading?**
A: When editing a file, ask Copilot "What instructions do you have for this file?" It will reference both monolithic and specialized files.

---

**END OF WORKFLOW DOCUMENTATION**
