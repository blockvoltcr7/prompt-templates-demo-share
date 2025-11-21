# Automation Scripts

This folder contains automation scripts for the GitHub Copilot Instructions Generator.

---

## Available Scripts

### `run-parallel.sh` - Parallel Execution

**Purpose:** Run all 4 phases simultaneously for 70% time savings

**Time:** 5-7 minutes (vs 35-45 minutes sequential)

**Usage:**
```bash
# From YOUR codebase root (not this repo!)
cd /path/to/your/actual/project
bash /path/to/copilot-instructions-generator/scripts/run-parallel.sh
```

**Requirements:**
- GitHub Copilot CLI installed: `gh extension install github/gh-copilot`
- Bash shell (macOS, Linux, WSL)
- Active Copilot license

**How it works:**
```bash
# Runs all phases simultaneously using background jobs
gh copilot chat -f phase-1.md > output-1.md &
gh copilot chat -f phase-2.md > output-2.md &
gh copilot chat -f phase-3.md > output-3.md &
gh copilot chat -f phase-4.md > output-4.md &

# Waits for all to complete
wait

# Combines outputs
cat output-*.md > .github/copilot-instructions.md
```

**See:** [Parallel Execution Guide](../docs/parallel-execution.md) for detailed information

---

### `validate-output.sh` - Output Validation

**Purpose:** Validate generated `.github/copilot-instructions.md` file

**Usage:**
```bash
# From YOUR codebase root
bash /path/to/copilot-instructions-generator/scripts/validate-output.sh
```

**What it checks:**
- ✅ File exists
- ✅ Minimum length (>100 lines)
- ⚠️ Warns if placeholder text found `[e.g., ...]`
- ⚠️ Warns if file seems short (<200 lines)

**Example output:**
```bash
✅ File exists: .github/copilot-instructions.md
⚠️  Warning: File contains placeholder text [e.g., ...]
✅ File length: 384 lines (within expected range)
✅ Validation complete
```

**When to use:**
- After running all 4 phases
- Before committing to repository
- When troubleshooting quality issues

---

## Future Scripts (Planned)

### `generate-for-all-repos.sh` (Coming Soon)

**Purpose:** Generate instructions for multiple repositories in batch

**Example usage:**
```bash
bash generate-for-all-repos.sh repos-list.txt
```

### `auto-update.sh` (Coming Soon)

**Purpose:** Automated quarterly updates via GitHub Actions

**Integration:** Will be called by `.github/workflows/update-instructions.yml`

---

## Custom Scripts

### Creating Your Own Automation

If you need custom automation (e.g., organization-specific requirements):

1. **Create new script:**
   ```bash
   cp validate-output.sh my-custom-script.sh
   ```

2. **Make executable:**
   ```bash
   chmod +x my-custom-script.sh
   ```

3. **Test thoroughly:**
   ```bash
   # Test on sample project first
   cd /path/to/test/project
   bash my-custom-script.sh
   ```

4. **Document:**
   - Add comments in script
   - Update this README
   - Consider contributing back!

---

## Troubleshooting Scripts

### Problem: `run-parallel.sh` fails with "command not found: gh"

**Solution:**
```bash
# Install GitHub CLI
brew install gh  # macOS
# OR
# Download from https://cli.github.com/

# Install Copilot extension
gh extension install github/gh-copilot
```

---

### Problem: Permission denied when running scripts

**Solution:**
```bash
chmod +x scripts/*.sh
```

---

### Problem: Parallel execution hits rate limits

**Solution:**
- Add delays between phase starts
- Or use sequential execution (slower but no limits)
- Contact GitHub support about Copilot rate limits

---

## Contributing Scripts

Have a useful automation script? We'd love to add it!

1. **Create the script** following conventions above
2. **Test thoroughly** on multiple repositories
3. **Document usage** in this README
4. **Submit PR** with:
   - Script file
   - Updated README
   - Example usage
   - Test results

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

---

## Script Conventions

When creating scripts, follow these conventions:

### Naming
- Use kebab-case: `validate-output.sh`, `run-parallel.sh`
- Descriptive names that indicate purpose
- `.sh` extension for bash scripts

### Structure
```bash
#!/bin/bash
# Script Name - Brief description
# Usage: ./script-name.sh [arguments]

set -e  # Exit on error

# Configuration variables at top
VARIABLE="value"

# Functions
function main() {
    # Main logic here
}

# Execute
main "$@"
```

### Documentation
- Header comment with purpose and usage
- Comments for complex logic
- Error messages that guide user to solution

---

**Ready to automate?** See [Parallel Execution Guide](../docs/parallel-execution.md)
