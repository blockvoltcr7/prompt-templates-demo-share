---
description: Identify unclear test requirements and ask targeted clarification questions to the product owner or development team.
---

The user input to you can be provided directly by the agent or as a command argument - you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

Goal: Detect ambiguities, missing test conditions, and unclear acceptance criteria in the story analysis. Ask up to 5 highly targeted questions to clarify what needs to be tested.

This command runs AFTER `/analyze-story` and BEFORE `/test-plan`.

Execution steps:

1. Run `.specify/scripts/powershell/check-test-prerequisites.ps1 -Json -PathsOnly` from repo root and parse JSON for STORY_DIR and ANALYSIS_FILE.
   - If analysis file not found, instruct user to run `/analyze-story` first.

2. Load the story analysis file and scan for:
   - `[NEEDS CLARIFICATION]` markers
   - `[INFERRED]` acceptance criteria
   - Vague acceptance criteria (e.g., "user-friendly", "fast", "secure")
   - Missing test data specifications
   - Unclear error handling requirements
   - Undefined boundary conditions
   - Missing integration/dependency details
   - Unclear non-functional requirements

3. Categorize ambiguities by impact:
   - **CRITICAL**: Blocks test planning or creates invalid test scenarios
   - **HIGH**: Significantly affects test coverage or automation strategy
   - **MEDIUM**: Affects specific test cases or edge case handling
   - **LOW**: Minor details that don't affect overall test approach

4. Generate up to 5 prioritized clarification questions:
   - Focus on CRITICAL and HIGH impact ambiguities first
   - Each question must be answerable with:
     * A multiple-choice selection (2-5 options), OR
     * A short answer (≤10 words), OR
     * A yes/no response
   - Questions should target:
     * Missing acceptance criteria
     * Unclear validation rules
     * Undefined error scenarios
     * Missing boundary values
     * Unclear data dependencies
     * Integration behavior expectations

5. Question format examples:
   ```
   Q: What should happen when a user submits an empty form?
   Options:
   | Option | Behavior |
   |--------|----------|
   | A | Show inline validation errors |
   | B | Show popup error message |
   | C | Disable submit button until valid |
   | D | Allow submission but show error on next page |
   ```

6. Interactive questioning loop:
   - Present EXACTLY ONE question at a time
   - Wait for user answer
   - Validate answer format
   - Record answer in working memory
   - Move to next question or stop if all clarified

7. After each accepted answer, immediately update story-analysis.md:
   - Ensure a `## Clarifications` section exists
   - Add subsection `### Session YYYY-MM-DD` for today
   - Append: `- Q: <question> → A: <answer>`
   - Update the relevant section (Acceptance Criteria, Test Scenarios, Edge Cases, etc.)
   - Remove `[NEEDS CLARIFICATION]` markers that are now resolved
   - Save file after each update

8. Completion report:
   - Number of questions asked and answered
   - Sections updated in analysis file
   - Remaining ambiguities (if any under 5 question limit)
   - Recommendation: Proceed to `/test-plan` or ask more questions

Behavior rules:
- Maximum 5 questions per session
- Never ask questions about automation implementation (that comes later)
- Focus on test requirements, not technical architecture
- If story has no critical ambiguities, report "Ready for test planning" and suggest `/test-plan`
- Preserve all manual edits to the analysis file
- Only ask questions that materially affect test case design

Context: $ARGUMENTS
