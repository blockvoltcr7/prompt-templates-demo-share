# Troubleshooting Guide

**Last Updated:** 2025-11-21

Common issues and solutions when generating GitHub Copilot instructions.

---

## Phase Execution Issues

### Problem: "File doesn't exist" error in Phase 2, 3, or 4

**Symptoms:**
```
Error: Cannot read .github/copilot-instructions.md
File does not exist
```

**Cause:** Phase 1 didn't complete successfully or you're in the wrong directory

**Solution:**

1. **Check if file exists:**
   ```bash
   ls -la .github/copilot-instructions.md
   ```

2. **If file doesn't exist:**
   - Re-run Phase 1 from the beginning
   - Verify you're in the correct repository root directory
   - Ensure Phase 1 completed without errors

3. **If you're in wrong directory:**
   ```bash
   cd /path/to/your/actual/codebase
   # NOT the copilot-instructions-generator repo!
   ```

---

### Problem: Copilot says "I can't find evidence of that technology"

**Symptoms:**
```
I searched for React but couldn't find package.json
Unable to verify TypeScript version
```

**Cause:** Inputs in Phase 1 don't match actual tech stack or file naming differs

**Solution:**

1. **Verify your tech stack:**
   ```bash
   # For Node.js projects
   cat package.json | grep "react\|typescript\|vue"

   # For Java projects
   cat pom.xml | grep "<artifactId>"

   # For Python projects
   cat requirements.txt
   ```

2. **Update Phase 1 inputs** to match what's actually in config files

3. **Re-run Phase 1** with corrected inputs

4. **If config files have non-standard names:**
   - Add explicit instructions: "Search for custom-package.json instead of package.json"

---

### Problem: Generated content seems generic

**Symptoms:**
- Output has placeholder text like `[e.g., ...]`
- Code examples aren't from your codebase
- Patterns don't match your actual code

**Cause:** Copilot didn't use `#codebase` queries effectively or not in Agent Mode

**Solution:**

1. **Verify Agent Mode enabled:**
   - Click settings icon in Copilot Chat
   - Ensure "Agent Mode" is selected
   - Choose premium model (Claude Sonnet 4.5, GPT-5, or Opus)

2. **Verify workspace is correct:**
   ```bash
   pwd
   # Should show YOUR codebase, not copilot-instructions-generator
   ```

3. **Re-run with more specific instructions:**
   - Add to prompt: "Use #codebase to search for actual examples in src/"
   - Add: "Find real component files in src/components/"

4. **Check file access:**
   - Ensure VS Code has opened the folder (not just a file)
   - Workspace should show full directory tree

---

### Problem: Some sections are duplicated

**Symptoms:**
- Architecture section appears twice
- Same code example repeated
- Naming conventions listed in multiple places

**Cause:** Phase 4 didn't deduplicate or phases overlapped

**Solution:**

1. **Manual cleanup:**
   - Open `.github/copilot-instructions.md`
   - Search for duplicate headings (Cmd/Ctrl+F)
   - Remove redundant sections

2. **Use Find & Replace:**
   ```
   Find: ## Architecture Guidelines.*?## Architecture Guidelines
   Replace: ## Architecture Guidelines
   ```

3. **Prevention for next time:**
   - Ensure you start NEW chat session for each phase
   - Don't manually edit file between phases

---

### Problem: Phase execution takes longer than 7 minutes

**Symptoms:**
- Phase 1 takes 12-15 minutes
- Copilot seems stuck or slow

**Cause:** Large codebase (10,000+ files) or complex analysis

**Solution:**

1. **This is normal for large repositories:**
   - Budget 10-15 minutes per phase for large codebases
   - Total time might be 50-60 minutes instead of 35-45

2. **Check Copilot isn't actually stuck:**
   - Look for "thinking" indicator
   - If no activity for 5 minutes, cancel and retry

3. **Optimize for large repos:**
   - Use [Parallel Execution](parallel-execution.md) (5-7 min total)
   - Or manually specify subdirectories to analyze

---

### Problem: Output has placeholder text like `[e.g., ...]`

**Symptoms:**
```markdown
**Files:** [pattern with example: `user-service.ts`]
**Testing:** [e.g., Jest, Vitest, PyTest]
```

**Cause:** AI couldn't find specific examples in codebase

**Solution:**

1. **Manually replace placeholders:**
   - Search for `[e.g.,` and `[pattern`
   - Fill in with actual examples from your code

2. **Re-run specific phase with explicit instructions:**
   ```
   Phase 2 prompt + "Find actual file examples in src/ directory"
   ```

3. **Check if files exist:**
   ```bash
   # For Node.js
   ls src/**/*.ts | head -10

   # For Java
   find . -name "*.java" | head -10
   ```

4. **If files are in non-standard locations:**
   - Add to prompt: "Source files are in lib/ not src/"

---

## Quality Issues

### Problem: Output is too short (< 150 lines)

**Symptoms:**
- File only has 80-100 lines
- Missing expected sections
- Incomplete documentation

**Cause:** Phases didn't complete fully or codebase is very simple

**Solution:**

1. **Check if all 4 phases ran:**
   - Search for "Generated:" at bottom (only appears after Phase 4)
   - Count main sections (should have 6-8)

2. **For simple codebases (< 10 files):**
   - This might be normal
   - Still useful even if shorter

3. **Re-run missing phases:**
   - Identify which phase created short output
   - Re-run that specific phase

---

### Problem: Output is too long (> 600 lines)

**Symptoms:**
- File has 800+ lines
- Too much detail
- Hard to maintain

**Cause:** AI included too much detail or examples

**Solution:**

1. **This isn't necessarily a problem:**
   - More detail can be helpful
   - Copilot handles long instructions files well

2. **If you want to trim:**
   - Remove duplicate code examples
   - Consolidate similar sections
   - Keep architecture/patterns, remove verbose explanations

---

### Problem: Instructions don't match recent code changes

**Symptoms:**
- Outdated framework versions
- Mentions removed features
- Missing new patterns

**Cause:** Codebase changed since generation

**Solution:**

1. **Re-run all 4 phases:**
   - Takes 35-45 minutes
   - Generates fresh instructions

2. **Quick update specific section:**
   - Re-run just one phase (e.g., Phase 1 for tech stack)
   - Manually merge into existing file

3. **Set up quarterly updates:**
   - Calendar reminder every 3 months
   - Or after major refactors

---

## Model & Configuration Issues

### Problem: Low quality output with GPT-3.5 or smaller models

**Symptoms:**
- Many placeholders
- Generic advice
- Inaccurate patterns
- Success rate < 70%

**Cause:** Model not powerful enough for complex analysis

**Solution:**

**Use premium models:**
- ✅ Claude Sonnet 4.5 (recommended - 95% accuracy)
- ✅ GPT-5
- ✅ Claude Opus

**In Copilot Chat settings:**
1. Click gear icon
2. Select "Agent Mode"
3. Choose premium model from dropdown

---

### Problem: Rate limit errors

**Symptoms:**
```
Error: Rate limit exceeded
Too many requests, please try again later
```

**Cause:** Too many Copilot requests in short time

**Solution:**

1. **Wait 5-10 minutes** then retry

2. **For parallel execution:**
   - Add delays between phase starts
   - See [Parallel Execution Guide](parallel-execution.md)

3. **If persistent:**
   - Contact GitHub support about Copilot rate limits
   - Use sequential execution (slower but no limits)

---

## Workflow Issues

### Problem: Forgot to start new chat session

**Symptoms:**
- Phase 2-4 takes very long
- Context overflow errors
- Quality degraded in later phases

**Cause:** Ran multiple phases in same chat session

**Solution:**

1. **For current session:**
   - Stop current phase
   - Close chat window
   - Start fresh session
   - Re-run the phase

2. **Why this matters:**
   - Session isolation saves 50% tokens
   - Prevents context overflow
   - Maintains quality

3. **How to remember:**
   - Set timer for each phase
   - Use checklist: Run → Complete → Close → New session

---

### Problem: Accidentally edited file between phases

**Symptoms:**
- Phases overwrite manual changes
- Inconsistent formatting
- Merge conflicts

**Cause:** Manual editing while phases are running

**Solution:**

1. **Let all phases complete first:**
   - Don't edit file during execution
   - Wait until all 4 phases done
   - Then make manual refinements

2. **If you must edit during:**
   - Note your changes
   - Complete remaining phases
   - Re-apply your edits after Phase 4

---

## Validation Issues

### Problem: validate-output.sh shows warnings

**Symptoms:**
```bash
⚠️  Warning: File contains placeholder text [e.g., ...]
⚠️  Warning: File seems short (95 lines). Expected 200-500 lines.
```

**Cause:** Output quality issues detected

**Solution:**

1. **For placeholder warnings:**
   - Search file for `[e.g.,` and `[pattern`
   - Replace with actual examples

2. **For short file warnings:**
   - Check if all phases ran
   - For small codebases, this might be normal
   - Verify Phase 4 completed (check for "Generated:" at end)

3. **Ignore warnings if:**
   - Codebase is legitimately small
   - You're testing on a sample project

---

## Environment Issues

### Problem: Can't find Copilot Chat in VS Code

**Symptoms:**
- No Copilot Chat option in command palette
- Extensions menu doesn't show Copilot

**Cause:** Copilot extension not installed or not activated

**Solution:**

1. **Install Copilot extension:**
   ```
   Extensions (Cmd/Ctrl+Shift+X)
   → Search "GitHub Copilot"
   → Install
   ```

2. **Verify license:**
   - Go to github.com/settings/copilot
   - Ensure subscription is active

3. **Restart VS Code:**
   - Close completely
   - Reopen in your codebase folder

---

### Problem: Running prompts in wrong repository

**Symptoms:**
- Generates instructions about THIS repo (copilot-instructions-generator)
- Instructions mention "prompts/", "docs/", etc.

**Cause:** Executing prompts in the template repo instead of your codebase

**Solution:**

1. **Navigate to YOUR codebase:**
   ```bash
   # NOT this:
   cd copilot-instructions-generator  ❌

   # But this:
   cd /path/to/your/actual/project  ✅
   ```

2. **Open VS Code in correct location:**
   ```bash
   cd /path/to/your/project
   code .
   ```

3. **Verify before starting:**
   ```bash
   pwd  # Should show YOUR project, not copilot-instructions-generator
   ```

---

## Getting More Help

### Self-Service Resources

1. **[Getting Started Guide](getting-started.md)** - Step-by-step instructions
2. **[How It Works](how-it-works.md)** - System overview
3. **[Technical Deep Dive](technical-deep-dive.md)** - Advanced details
4. **[FAQ in README](../README.md#frequently-asked-questions)** - Common questions

### Community Support

1. **Search existing issues:**
   ```
   https://github.com/your-org/copilot-instructions-generator/issues
   ```

2. **Open new issue:**
   - Include error messages
   - Describe what phase failed
   - Share relevant parts of output (no secrets!)
   - Mention your tech stack

3. **Join discussions:**
   ```
   https://github.com/your-org/copilot-instructions-generator/discussions
   ```

### When to Seek Help

**Definitely ask if:**
- Error persists after trying solutions above
- Output quality consistently poor (< 70% accuracy)
- Unique tech stack not documented
- Found a bug in prompts

**Probably don't need to ask if:**
- Phase just takes longer (large repo)
- Minor placeholders (easy to fill manually)
- File slightly shorter than expected (small repo)

---

## Prevention Tips

### For Best Results

1. **✅ Use Agent Mode** with premium model (Claude Sonnet 4.5)
2. **✅ Start fresh chat** for each phase
3. **✅ Verify directory** before each phase (`pwd`)
4. **✅ Don't edit file** until all phases complete
5. **✅ Budget 40-50 min** for first execution
6. **✅ Review output** after each phase

### Common Mistakes to Avoid

1. **❌ Don't** run prompts in copilot-instructions-generator repo
2. **❌ Don't** use GPT-3.5 or small models
3. **❌ Don't** skip starting new chat sessions
4. **❌ Don't** manually edit during phase execution
5. **❌ Don't** expect 100% perfect output (90-95% is normal)

---

**Still stuck?** [Open an issue](https://github.com/your-org/copilot-instructions-generator/issues/new) with details about your problem.
