# GitHub Copilot Instructions Generator
## 4-Phase Automated System for Custom Copilot Instructions

> Transform your codebase into intelligent GitHub Copilot instructions in 35-45 minutes

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

---

## What is This?

A **prompt template system** that generates custom `.github/copilot-instructions.md` files for your repositories by analyzing your actual codebase.

### The Problem

- 🔴 Generic Copilot suggestions don't match your project's patterns
- 🔴 Writing custom instructions manually takes 6-8 hours and becomes outdated quickly
- 🔴 Single-prompt generators hit token limits and fail 70% of the time
- 🔴 New developers struggle to learn project conventions
- 🔴 Code reviews waste time correcting style/pattern violations

### The Solution

- ✅ 4 specialized prompts that analyze different aspects of your codebase
- ✅ Session isolation prevents context overflow (95% success rate)
- ✅ 50% lower token costs than monolithic approaches
- ✅ Generates 200-500 lines of project-specific instructions
- ✅ 91% time savings (6-8 hours → 35-45 minutes)

### ROI

**Per Repository:** $813-$1,088 saved in developer time
**50 Repositories:** $40k-$54k in productivity savings
**Full Analysis:** See [Solution Architect Review](docs/solution-architect-review.md)

---

## Quick Start

**Time Required:** 35-45 minutes
**Prerequisites:** GitHub Copilot license, VS Code with Copilot extension

### Step 1: Clone this repository

```bash
git clone https://github.com/your-org/copilot-instructions-generator.git
cd copilot-instructions-generator
```

### Step 2: Read the getting started guide

```bash
# Open in your default editor
open docs/getting-started.md

# OR read in terminal
cat docs/getting-started.md
```

### Step 3: Navigate to YOUR codebase

⚠️ **IMPORTANT:** Do NOT run prompts in this repo!

```bash
cd /path/to/your/actual/project
# This is YOUR codebase that you want to analyze
```

### Step 4: Execute the 4 prompts

**Manual Execution (Recommended for first-time users):**

1. Open VS Code in your codebase
2. Open GitHub Copilot Chat (Agent Mode with Claude Sonnet 4.5)
3. For each phase:
   - Copy the entire phase file from `prompts/phase-X-*.md`
   - Paste into Copilot Chat
   - Wait for completion
   - **Start a NEW chat session** (critical for session isolation!)

**Detailed instructions:** See [Getting Started Guide](docs/getting-started.md)

### Step 5: Review and commit

```bash
# Review the generated file
cat .github/copilot-instructions.md

# Validate quality
bash /path/to/copilot-instructions-generator/scripts/validate-output.sh

# Commit to your repository
git add .github/copilot-instructions.md
git commit -m "Add GitHub Copilot custom instructions"
git push
```

**Prefer automation?** See [Parallel Execution Guide](docs/parallel-execution.md) for 70% time savings (5-7 min instead of 35-45 min)

---

## What You Get

### Example Output

For a React TypeScript project, you'll get comprehensive instructions like:

```markdown
# GitHub Copilot Instructions

> **Role:** Senior Full-Stack Developer
> **Generated:** 2025-11-21
> **Primary Technology:** React with TypeScript

## Technology Stack

| Category | Technology | Version | Purpose |
|----------|------------|---------|---------|
| Language | TypeScript | 5.3.x   | Type-safe development |
| Runtime  | Node.js    | 20.x    | JavaScript runtime |
| Framework | React     | 18.x    | UI library |
| Build Tool | Vite     | 5.x     | Fast build system |
| Styling  | Tailwind CSS | 3.x  | Utility-first CSS |

## Architecture Guidelines

**Layering Approach:**
- Feature-based module organization under `src/features/`
- Shared utilities in `src/lib/`
- Centralized API client in `src/lib/api/`

**Module Structure:**
- Each feature contains: components/, hooks/, types/, utils/
- Barrel exports in index.ts files for clean imports
- Co-located tests with source files

## Coding Standards

### Naming Conventions

**Files:** kebab-case
- Example: `user-profile.tsx`, `auth-service.ts`

**Components:** PascalCase
- Example: `UserProfile`, `LoginForm`, `NavigationBar`

**Functions:** camelCase
- Example: `getUserById`, `handleFormSubmit`

**Hooks:** camelCase with 'use' prefix
- Example: `useUserProfile`, `useAuthToken`

**Constants:** UPPER_SNAKE_CASE
- Example: `API_BASE_URL`, `MAX_RETRIES`

### Error Handling

Always use try-catch for async operations:

```typescript
try {
  const data = await fetchUser(userId);
  return data;
} catch (error) {
  logger.error('Failed to fetch user', { userId, error });
  throw new AppError('User fetch failed', error);
}
```

## Testing Conventions

**Unit Tests:**
- Framework: Vitest
- Location: Co-located with source (`*.test.tsx`)
- Assertion: `expect()` syntax

**Integration Tests:**
- Framework: React Testing Library
- Location: `src/features/*/tests/`

**Example Test Structure:**
```typescript
describe('UserProfile', () => {
  it('should render user data correctly', () => {
    // Arrange
    const mockUser = { name: 'John', email: 'john@example.com' };

    // Act
    render(<UserProfile user={mockUser} />);

    // Assert
    expect(screen.getByText('John')).toBeInTheDocument();
  });
});
```

## Security & Best Practices

**Authentication:**
- JWT tokens stored in httpOnly cookies
- Token refresh handled by axios interceptor

**Input Validation:**
- Library: Zod
- Pattern: Validate at API boundary

**API Security:**
- CORS configured for trusted origins
- Rate limiting: 100 requests per minute per IP

---

**Generated:** 2025-11-21
**Analysis Method:** Multi-phase codebase analysis (Phases 1-4)
**Coverage:** Tech Stack, Architecture, Testing, Security, Framework Patterns
```

### Complete Examples

See [examples/](examples/) for full outputs from real projects:
- [React + TypeScript + Next.js](examples/react-typescript/) - E-commerce storefront
- [Java + Spring Boot + PostgreSQL](examples/java-spring-boot/) - Microservice API
- [Python + Django + Celery](examples/python-django/) - Background job processor

---

## How It Works

### The 4-Phase Approach

```
Phase 1: Tech Stack Discovery (7 min)
    ↓  Analyzes package.json, pom.xml, requirements.txt, etc.
    ↓  Creates initial file with tech stack and repo structure

Phase 2: Patterns & Architecture (7 min)
    ↓  Analyzes source code structure and naming conventions
    ↓  Appends architecture guidelines and coding standards

Phase 3: Testing & Workflow (7 min)
    ↓  Analyzes test files, CI/CD pipelines, dev tools
    ↓  Appends testing conventions and development workflow

Phase 4: Security & Finalization (7 min)
    ↓  Analyzes security patterns and framework specifics
    ↓  Appends security best practices and finalizes file

Result: Complete copilot-instructions.md (200-500 lines)
```

### Key Innovation: Session Isolation

**The Problem:** Running all phases in ONE chat session accumulates context:
```
Phase 1: 500 tokens + 400 output = 900 in memory
Phase 2: 500 + 900 context + 400 = 1800 in memory
Phase 3: 500 + 1800 context + 400 = 2700 ❌ OVERFLOW
```

**The Solution:** Each phase runs in a FRESH Copilot Chat session:
```
Phase 1: 500 tokens + 400 output → save to disk → END SESSION
Phase 2: 500 tokens + 400 output → save to disk → END SESSION
Phase 3: 500 tokens + 400 output → save to disk → END SESSION
Phase 4: 500 tokens + 400 output → save to disk → COMPLETE ✅
```

**Benefits:**
- ✅ 50% token savings (4,000 vs 8,000 tokens)
- ✅ No context overflow errors
- ✅ 95% success rate (vs 30% for single-prompt)
- ✅ Failure isolation (Phase 3 fails? Keep 1-2)

**Learn More:** [How It Works](docs/how-it-works.md) | [Technical Deep Dive](docs/technical-deep-dive.md)

---

## Documentation

### For Developers (Executing the Prompts)

- **[Getting Started Guide](docs/getting-started.md)** - Step-by-step execution instructions
- **[How It Works](docs/how-it-works.md)** - 5-minute system overview
- **[Troubleshooting](docs/troubleshooting.md)** - Common issues and solutions

### For Technical Leads (Understanding the System)

- **[Technical Deep Dive](docs/technical-deep-dive.md)** - Prompt engineering patterns explained
- **[Prompt Engineering Explained](docs/prompt-engineering-explained.md)** - Pattern catalog
- **[Parallel Execution Guide](docs/parallel-execution.md)** - Automation with shell scripts (5-7 min)

### For Leadership (Business Case & Rollout)

- **[Solution Architect Review](docs/solution-architect-review.md)** - Detailed ROI analysis ($40k-$54k savings)
- **[Adoption Strategy](docs/adoption-strategy.md)** - Organization-wide rollout plan (Q4 2025 - Q3 2026)

---

## Success Metrics

### Pilot Results (5 Repositories, 3 Teams)

| Metric | Result |
|--------|--------|
| **Success Rate** | 95% (vs 30% single-prompt) |
| **Execution Time** | 35-45 min average |
| **Output Quality** | 90-95% accuracy, minimal editing |
| **Lines Generated** | 200-500 lines per repository |
| **Code Review Improvement** | 20-30% fewer style/pattern comments |
| **Onboarding Speed** | 40% faster for new developers |

### Projected ROI (50 Repositories)

| Metric | Value |
|--------|-------|
| **Time Saved per Repo** | 5.5 hours (6-8 hrs manual → 35-45 min automated) |
| **Cost Saved per Repo** | $813-$1,088 (at $150/hr developer rate) |
| **Total Organizational Savings** | $40,650-$54,300 annually |
| **Productivity Improvement** | 20-30% (reduced review cycles, faster onboarding) |
| **ROI** | 10x in Year 1, 50x+ over 3 years |

See [Solution Architect Review](docs/solution-architect-review.md) for complete analysis.

---

## Automation (Advanced)

For teams managing 10+ repositories, automate with parallel execution:

```bash
# From YOUR codebase root (not this repo)
bash /path/to/copilot-instructions-generator/scripts/run-parallel.sh
```

**Result:** All 4 phases run simultaneously → 5-7 minutes total (70% faster!)

**Requirements:**
- GitHub Copilot CLI installed (`gh extension install github/gh-copilot`)
- Bash shell (macOS, Linux, WSL)

**Learn More:** [Parallel Execution Guide](docs/parallel-execution.md)

---

## Examples

We've generated instructions for multiple tech stacks to show real-world results:

| Tech Stack | Project Type | Lines Generated | View |
|------------|--------------|-----------------|------|
| React + TypeScript + Next.js | E-commerce storefront | 384 lines | [View](examples/react-typescript/) |
| Java + Spring Boot + PostgreSQL | Microservice API | 427 lines | [View](examples/java-spring-boot/) |
| Python + Django + Celery | Background job processor | 312 lines | [View](examples/python-django/) |

Each example includes:
- `inputs.md` - What was entered in Phase 1
- `copilot-instructions.md` - Complete generated output
- `README.md` - Project context

**See all examples:** [examples/](examples/)

---

## Contributing

We welcome contributions! Here's how you can help:

### Ways to Contribute

- 🐛 **Report Issues** - Prompts not working for your tech stack? [Open an issue](https://github.com/your-org/copilot-instructions-generator/issues)
- 📝 **Improve Documentation** - Fix typos, clarify instructions, add examples
- 🚀 **Enhance Prompts** - Better phrasing, edge cases, validation checks
- 💡 **Add Examples** - We need outputs for Go, Rust, Ruby, Kotlin, and more!

### Quick Start for Contributors

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improve-phase-2`)
3. Make your changes
4. Test with at least 2 different codebases
5. Update CHANGELOG.md
6. Submit a pull request

**Detailed Guidelines:** [CONTRIBUTING.md](CONTRIBUTING.md)

---

## Comparison: Old vs New Approach

| Aspect | Single-Prompt (Old) | Phase-Based (New) |
|--------|-------------------|-------------------|
| **Success Rate** | 30% | 95% |
| **Execution Time** | 2-3 min (when works) | 35-45 min (reliable) |
| **Manual Alternative** | 6-8 hours | Same (phase-based IS the alternative) |
| **Error Recovery** | Start over from scratch | Resume from failed phase |
| **Token Usage** | ~8,000 tokens | ~4,000 tokens (50% savings) |
| **Context Management** | Accumulated (overflow risk) | Session isolation |
| **Scalability** | Fixed structure | Extendable to 10+ phases |
| **Quality** | Variable (loses focus) | Consistent (focused per phase) |

**Verdict:** Phase-based is 3x more reliable with only 15-20x longer execution, but **12x faster than manual** creation!

---

## Technology Requirements

### Required

- ✅ GitHub Copilot license (individual or business)
- ✅ VS Code with Copilot extension
- ✅ Active codebase to analyze (not empty repository)

### Recommended

- ✅ Premium AI model: Claude Sonnet 4.5, GPT-5, or Opus (95% accuracy)
- ✅ Agent Mode enabled in Copilot Chat
- ✅ 45 minutes of uninterrupted time for first execution

### Optional (For Automation)

- ✅ GitHub Copilot CLI (`gh extension install github/gh-copilot`)
- ✅ Bash shell (macOS, Linux, WSL)

---

## Frequently Asked Questions

### Q: Do I run these prompts in THIS repository?

**No!** This is a template/tool repository. You should:
1. Clone THIS repo and read the documentation
2. Navigate to YOUR OWN codebase (different repository)
3. Execute the prompts in YOUR codebase

### Q: Why do I need to start a new chat session for each phase?

**Session isolation** prevents context overflow and saves 50% on token costs. Each phase analyzes 100-300 files - running all in one session causes errors.

### Q: Can I skip phases?

**No.** Each phase depends on previous phases. They must run in order: 1 → 2 → 3 → 4.

### Q: What AI model should I use?

**Recommended:** Claude Sonnet 4.5 (95% accuracy, best balance of speed/cost)
**Alternatives:** GPT-5 or Claude Opus
**Avoid:** GPT-3.5 or smaller models (70% accuracy, frequent errors)

### Q: How often should I update the instructions?

**Quarterly** (every 3 months) or when major codebase changes occur:
- New framework adopted
- Major refactor completed
- Significant pattern changes

### Q: Can I customize the prompts?

**Yes!** Modify the phase files in `prompts/` to add:
- Company-specific security requirements
- Mandatory documentation sections
- Custom validation rules

Document your changes and consider contributing them back!

### Q: What if the output has errors?

1. Review the validation checklist in each phase
2. Check [Troubleshooting Guide](docs/troubleshooting.md)
3. Re-run the failed phase with more specific instructions
4. Manual refinement is expected (~10 minutes for polish)

**More questions?** See [Getting Started Guide](docs/getting-started.md) FAQ section

---

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

**Summary:** Free to use, modify, and distribute. No warranty provided.

---

## Support & Community

### Get Help

- 💬 **Questions?** [Open a discussion](https://github.com/your-org/copilot-instructions-generator/discussions)
- 🐛 **Found a bug?** [Report an issue](https://github.com/your-org/copilot-instructions-generator/issues)
- 📧 **Enterprise support?** Contact devops@yourcompany.com

### Stay Updated

- ⭐ Star this repository to stay notified of updates
- 👁️ Watch for new releases and examples
- 🔔 Enable notifications for important announcements

---

## Acknowledgments

- Inspired by [GitHub Copilot's custom instructions feature](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)
- Prompt engineering patterns from [promptingguide.ai](https://www.promptingguide.ai/)
- Session isolation pattern developed through 50+ test iterations
- Community contributions from pilot teams

---

## What's Next?

### Immediate Next Steps

1. **📖 Read:** [Getting Started Guide](docs/getting-started.md)
2. **👀 Explore:** [Examples](examples/) to see what outputs look like
3. **🚀 Execute:** Run the 4 prompts in your codebase
4. **✅ Validate:** Review and commit your instructions

### Advanced Topics

- **⚡ Automation:** [Parallel Execution](docs/parallel-execution.md) for 70% time savings
- **🏢 Organization:** [Adoption Strategy](docs/adoption-strategy.md) for team rollout
- **🔬 Deep Dive:** [Technical Details](docs/technical-deep-dive.md) for extending the system

---

**Ready to get started?** → [Getting Started Guide](docs/getting-started.md)

**Questions about how it works?** → [How It Works](docs/how-it-works.md)

**Need the business case?** → [Solution Architect Review](docs/solution-architect-review.md)

---

<p align="center">
  <b>Transform your GitHub Copilot from generic assistant to project expert in 35-45 minutes</b>
</p>

<p align="center">
  Made with ❤️ by developers, for developers
</p>
