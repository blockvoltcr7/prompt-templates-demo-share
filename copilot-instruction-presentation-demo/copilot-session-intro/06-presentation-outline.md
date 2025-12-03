# Copilot for QA Engineers - Presentation Outline

**Duration:** 20 minutes
**Format:** Live demo with visual aids
**Audience:** Developers and QA Engineers onboarding to GitHub Copilot

---

## Pre-Presentation Setup

- [ ] VS Code open with your test automation project
- [ ] Empty test class file ready for demos
- [ ] Mermaid diagrams exported to PNG (or preview ready)
- [ ] Sample JIRA task content copied (for context demo)
- [ ] AI-docs folder created in project (can be empty to start)
- [ ] Copilot Chat panel accessible

---

## Presentation Flow

### Opening: The Hook (2 min)

**Goal:** Immediate "wow" moment - show value in 30 seconds

**Do:**
1. Open empty Java file
2. Type:
   ```java
   // validate that CSV row has valid email, non-empty name, and age between 18-120
   public ValidationResult validateRow(String[] row) {
   ```
3. Tab → Accept suggestion
4. Done.

**Say:**
> "That took 10 seconds. Let me show you how to do this consistently."

---

### Section 1: The Big Picture (3 min)

**Goal:** Show where AI fits in our workflow

**Show:** Diagram 5 (Linear Workflow Stages)

```
JIRA → Understand → Plan → Gherkin → Implement → Test Data → Execute
         AI          AI       AI         AI          AI
```

**Say:**
> "This is what we do every day. At each stage, AI can help - but notice the human review between every stage."

**Show:** Diagram 2 (Human-in-the-Loop)

**Say:**
> "Critical point: AI is the assistant, YOU are the decision maker. Every AI output gets reviewed before it becomes real code."

**Key message:** AI accelerates, humans validate.

---

### Section 2: Context is Everything (4 min)

**Goal:** Explain why context matters and how to provide it

**Show:** Diagram 6 (With/Without Patterns)

**Say:**
> "Generic prompt = generic output. Your context = your style."

**Show:** Diagram 3 (JIRA to Copilot Flow)

**Say:**
> "Copilot can't read JIRA. So we bring JIRA to Copilot."

**Live Demo:**
1. Show AI-docs folder structure
2. Show a task.md example (or create one live)
3. Show how screenshots of Word/PDF go in the folder

**Show:** Diagram 7 (Folder Structure)

**Say:**
> "This is where all your AI context lives. JIRA tasks, patterns, everything Copilot needs."

---

### Section 3: Live Demos (8 min)

**Goal:** Show practical AI-assisted test creation

#### Demo 3.1: API Test Generation (3 min)

**Setup:** Have endpoint spec visible or paste in chat

**Do:**
1. Open Copilot Chat
2. Type prompt:
   ```
   Generate a Serenity BDD REST Assured test for a GET /users/{id} endpoint
   that returns 200 with user object. Include happy path and 404 scenario.

   Follow our patterns: @workspace AI-docs/patterns/step-definition-pattern.java
   ```
3. Show generated code
4. Point out how it matches your patterns

**Say:**
> "Notice I told it the framework AND referenced our pattern. That's why the output matches our style."

#### Demo 3.2: Gherkin from Requirements (2 min)

**Do:**
1. Paste acceptance criteria in chat:
   ```
   Given this requirement:
   "Users can reset password via email. Link expires 24 hours.
   Must meet complexity requirements. Old password invalidated."

   Generate Gherkin scenarios for Serenity BDD.
   Include: happy path, expired link, invalid password, password reuse.
   ```
2. Show generated feature file

**Say:**
> "From AC to Gherkin in seconds. I'll review it, adjust if needed, then implement."

#### Demo 3.3: Quick Wins Rapid Fire (3 min)

Fast demonstrations - show each in 30-45 seconds:

1. **Explain code:** Select confusing method → `/explain`
2. **Add Javadoc:** Select test → `/doc`
3. **Debug failure:** After error in terminal → `@terminal what went wrong?`
4. **Find code:** `@workspace where do we validate user input?`

**Say:**
> "These are your daily shortcuts. Memorize them."

---

### Section 4: The Workflow in Practice (2 min)

**Goal:** Tie it all together

**Show:** Diagram 1 (Full QA Workflow)

**Walk through:**
1. JIRA task comes in
2. Create AI-docs context
3. AI helps analyze → YOU review
4. AI generates test plan → YOU approve
5. AI writes Gherkin → YOU review
6. AI implements steps → YOU review
7. Execute → AI helps debug if fails

**Say:**
> "Every yellow diamond is YOU making a decision. AI proposes, you dispose."

---

### Section 5: Getting Started (1 min)

**Goal:** Give them actionable next steps

**Say:**
> "Three things to do after this session:"

1. **Create your AI-docs folder**
   - `AI-docs/jira/` for task context
   - `AI-docs/patterns/` for your code patterns

2. **Extract one pattern**
   - Find your best step definition class
   - Copy it to patterns folder
   - Add comments explaining the structure

3. **Try one workflow**
   - Next JIRA task: create task.md first
   - Use the prompts we showed today
   - Review everything AI generates

---

### Closing (30 sec)

**Say:**
> "Remember three things:"
> 1. **Context is everything** - garbage in, garbage out
> 2. **Patterns produce consistency** - show Copilot your style
> 3. **Human in the loop** - AI assists, you decide

> "Questions?"

---

## Timing Summary

| Section | Duration | Content |
|---------|----------|---------|
| Hook | 2 min | CSV validation demo |
| Big Picture | 3 min | Workflow diagrams, human-in-loop |
| Context | 4 min | JIRA flow, folder structure |
| Live Demos | 8 min | API test, Gherkin, quick wins |
| Workflow | 2 min | Full diagram walkthrough |
| Getting Started | 1 min | Three action items |
| **Total** | **20 min** | |

---

## Backup Plans

**If Copilot gives poor output:**
> "This is why we iterate. Let me refine the prompt..."
> Add more context, reference a pattern, be more specific

**If Copilot is slow/unresponsive:**
> Have screenshots of expected outputs ready
> "Here's what this typically produces..."

**If demo fails:**
> Switch to showing the workflow diagrams
> Explain conceptually, offer to demo 1:1 later

---

## Materials Checklist

**Documents (this folder):**
- [ ] 01-demo-script-qa-focused.md (detailed demo steps)
- [ ] 02-jira-context-workflow.md (JIRA process)
- [ ] 03-workflow-driven-prompts.md (prompt templates)
- [ ] 04-capturing-your-patterns.md (pattern extraction)
- [ ] 05-workflow-diagrams.md (all diagrams)

**Diagrams to export:**
- [ ] Diagram 2: Human-in-the-Loop
- [ ] Diagram 3: JIRA to Copilot Flow
- [ ] Diagram 5: Linear Workflow Stages
- [ ] Diagram 6: With/Without Patterns
- [ ] Diagram 7: Folder Structure
- [ ] Diagram 1: Full QA Workflow (optional - complex)

**In your project:**
- [ ] AI-docs/jira/ folder exists
- [ ] Sample task.md ready
- [ ] AI-docs/patterns/ folder exists
- [ ] At least one pattern file ready
- [ ] Empty test class for live coding

---

## Post-Presentation

**Share with attendees:**
- Link to this folder (or export as PDF)
- Prompt templates from 03-workflow-driven-prompts.md
- Folder structure guide from 02-jira-context-workflow.md

**Follow-up offer:**
> "I'm happy to do 1:1 sessions to help you set up your first AI-docs folder and extract your patterns."
