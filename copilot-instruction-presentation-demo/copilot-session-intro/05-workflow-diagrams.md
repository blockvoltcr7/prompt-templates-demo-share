# Workflow Diagrams for Copilot Presentation

Visual representations of AI-assisted workflows with human-in-the-loop review points.

---

## Diagram 1: QA Engineer Daily Workflow (Human + AI)

Shows where AI assists and where humans review/decide.

```mermaid
flowchart TD
    subgraph INPUT["INPUT PHASE"]
        A["JIRA Ticket Assigned"] --> B["Gather Context"]
        B --> B1["Title + Description"]
        B --> B2["Acceptance Criteria"]
        B --> B3["Attachments → Screenshots/MD"]
    end

    subgraph CONTEXT["CONTEXT SETUP"]
        B1 & B2 & B3 --> C["Create AI-docs/jira/TICKET-ID/"]
        C --> D["task.md + attachments"]
    end

    subgraph AI_UNDERSTAND["AI: UNDERSTAND"]
        D --> E["Copilot: Analyze Requirements"]
        E --> F["Output: Edge cases, questions, test data needs"]
    end

    subgraph HUMAN_REVIEW_1["HUMAN REVIEW"]
        F --> G{{"Review Analysis"}}
        G -->|"Gaps Found"| H["Ask PO/Dev for clarification"]
        H --> D
        G -->|"Complete"| I["Approved Understanding"]
    end

    subgraph AI_PLAN["AI: PLAN"]
        I --> J["Copilot: Generate Test Plan"]
        J --> K["Output: Scenarios, priorities, test types"]
    end

    subgraph HUMAN_REVIEW_2["HUMAN REVIEW"]
        K --> L{{"Review Test Plan"}}
        L -->|"Adjust"| J
        L -->|"Approved"| M["Final Test Plan"]
    end

    subgraph AI_GENERATE["AI: GENERATE"]
        M --> N["Copilot: Generate Gherkin"]
        N --> O["Copilot: Generate Step Definitions"]
        O --> P["Copilot: Generate Test Data"]
    end

    subgraph HUMAN_REVIEW_3["HUMAN REVIEW"]
        P --> Q{{"Code Review"}}
        Q -->|"Refine"| O
        Q -->|"Approved"| R["Execute Tests"]
    end

    subgraph VALIDATE["VALIDATE"]
        R --> S{{"Tests Pass?"}}
        S -->|"Fail"| T["Copilot: Debug Assistance"]
        T --> Q
        S -->|"Pass"| U["Commit & PR"]
    end

```

**Legend:**
- Green = AI assists
- Yellow = Human decision point

---

## Diagram 2: The Human-in-the-Loop Cycle

Every AI output goes through human review before becoming final.

```mermaid
flowchart LR
    subgraph CYCLE["AI-ASSISTED WORK CYCLE"]
        A["Define Input"] --> B["Craft Prompt"]
        B --> C["Copilot Generates"]
        C --> D{{"Human Review"}}
        D -->|"Needs refinement"| E["Refine Prompt"]
        E --> C
        D -->|"Accepted"| F["Use Output"]
        F --> G["Next Task"]
        G --> A
    end

```

**Key Point:** AI is the assistant, human is the decision maker.

---

## Diagram 3: JIRA to Copilot Context Flow

How task information flows from JIRA into Copilot's context.

```mermaid
flowchart TD
    subgraph JIRA["JIRA (Source)"]
        J1["Title"]
        J2["Description"]
        J3["Acceptance Criteria"]
        J4["Word/PDF Attachments"]
        J5["Screenshots"]
    end

    subgraph TRANSFORM["TRANSFORM"]
        J1 & J2 & J3 --> T1["Copy to task.md"]
        J4 --> T2["Screenshot pages OR<br/>Copy text to .md"]
        J5 --> T3["Save as .png/.jpeg"]
    end

    subgraph AIDOCS["AI-docs/jira/TICKET-ID/"]
        T1 --> F1["task.md"]
        T2 --> F2["requirements.md<br/>OR screenshots"]
        T3 --> F3["mockup.png"]
    end

    subgraph COPILOT["COPILOT CONTEXT"]
        F1 & F2 & F3 --> C1["@workspace sees all files"]
        C1 --> C2["AI has full context"]
    end


```

---

## Diagram 4: Prompt Engineering Workflow

The process of crafting effective prompts.

```mermaid
flowchart TD
    subgraph INPUTS["GATHER INPUTS"]
        I1["What am I trying to create?"]
        I2["What context does AI need?"]
        I3["What patterns should it follow?"]
        I4["What format do I want?"]
    end

    subgraph CRAFT["CRAFT PROMPT"]
        I1 & I2 & I3 & I4 --> P1["Write structured prompt"]
        P1 --> P2["Include: Task + Context + Pattern + Format"]
    end

    subgraph EXECUTE["EXECUTE"]
        P2 --> E1["Send to Copilot"]
        E1 --> E2["Receive output"]
    end

    subgraph EVALUATE["EVALUATE"]
        E2 --> R1{{"Does it meet needs?"}}
        R1 -->|"No - wrong approach"| I1
        R1 -->|"No - needs detail"| P1
        R1 -->|"Close - minor fixes"| M1["Manual adjustments"]
        R1 -->|"Yes"| D1["Done - Use output"]
    end

```

---

## Diagram 5: Test Automation Workflow Stages

Linear view of the QA workflow with AI touchpoints.

```mermaid
flowchart LR
    subgraph S1["STAGE 1"]
        A1["JIRA Task"]
        A2["AI: Analyze"]
        A3["Human: Review"]
    end

    subgraph S2["STAGE 2"]
        B1["Requirements"]
        B2["AI: Test Plan"]
        B3["Human: Approve"]
    end

    subgraph S3["STAGE 3"]
        C1["Test Plan"]
        C2["AI: Gherkin"]
        C3["Human: Review"]
    end

    subgraph S4["STAGE 4"]
        D1["Features"]
        D2["AI: Step Defs"]
        D3["Human: Review"]
    end

    subgraph S5["STAGE 5"]
        E1["Code"]
        E2["AI: Test Data"]
        E3["Human: Validate"]
    end

    subgraph S6["STAGE 6"]
        F1["Tests"]
        F2["Execute"]
        F3["AI: Debug if fail"]
    end

    A1 --> A2 --> A3 --> B1 --> B2 --> B3 --> C1 --> C2 --> C3 --> D1 --> D2 --> D3 --> E1 --> E2 --> E3 --> F1 --> F2 --> F3

```

---

## Diagram 6: Pattern-Based Code Generation

How patterns improve Copilot output quality.

```mermaid
flowchart TD
    subgraph WITHOUT["WITHOUT PATTERNS"]
        W1["Generic Prompt"] --> W2["Copilot"]
        W2 --> W3["Generic Output"]
        W3 --> W4["Lots of manual fixes"]
        W4 --> W5["Inconsistent with codebase"]
    end

    subgraph WITH["WITH PATTERNS"]
        P1["Prompt + Your Pattern"] --> P2["Copilot"]
        P2 --> P3["Pattern-Matched Output"]
        P3 --> P4["Minimal fixes needed"]
        P4 --> P5["Consistent with codebase"]
    end

```

---

## Diagram 7: AI-docs Folder Structure

Visual representation of the context folder structure.

```mermaid
flowchart TD
    subgraph PROJECT["your-project/"]
        SRC["src/"]
        TEST["src/test/"]

        subgraph AIDOCS["AI-docs/"]
            subgraph JIRA["jira/"]
                T1["IMS-12345/"]
                T2["IMS-12346/"]

                subgraph TICKET["IMS-12345/"]
                    F1["task.md"]
                    F2["requirements.md"]
                    F3["api-spec.png"]
                    F4["mockup.png"]
                end
            end

            subgraph PATTERNS["patterns/"]
                P1["step-definition-pattern.java"]
                P2["api-client-pattern.java"]
                P3["test-data-pattern.java"]
                P4["README.md"]
            end
        end
    end

```

---

## Diagram 8: Developer vs QA Workflow Comparison

Shows parallel workflows for both roles.

```mermaid
flowchart TD
    subgraph SHARED["SHARED INPUT"]
        S1["JIRA Task"]
    end

    subgraph DEV["DEVELOPER WORKFLOW"]
        D1["Understand Requirements"]
        D2["AI: Design/Architecture"]
        D3["AI: Implementation"]
        D4["Human: Code Review"]
        D5["Unit Tests"]
    end

    subgraph QA["QA ENGINEER WORKFLOW"]
        Q1["Analyze Testability"]
        Q2["AI: Test Plan"]
        Q3["AI: Test Implementation"]
        Q4["Human: Test Review"]
        Q5["Execute & Validate"]
    end

    subgraph CONVERGE["CONVERGENCE"]
        C1["PR Review"]
        C2["Merge to Main"]
        C3["Release"]
    end

    S1 --> D1 & Q1
    D1 --> D2 --> D3 --> D4 --> D5
    Q1 --> Q2 --> Q3 --> Q4 --> Q5
    D5 & Q5 --> C1 --> C2 --> C3

```

---

## Diagram 9: The Feedback Loop

Continuous improvement of prompts and patterns.

```mermaid
flowchart TD
    A["Use Prompt Template"] --> B["Generate Code"]
    B --> C["Review Output"]
    C --> D{{"Quality?"}}

    D -->|"Poor"| E["Identify Issue"]
    E --> F["Improve Prompt"]
    F --> A

    D -->|"Good but inconsistent"| G["Extract Pattern"]
    G --> H["Add to patterns/"]
    H --> I["Update Prompt Template"]
    I --> A

    D -->|"Excellent"| J["Document Success"]
    J --> K["Share with Team"]
    K --> L["Team Adopts"]

```

---

## Using These Diagrams in Your Presentation

1. **Opening:** Show Diagram 5 (Linear Workflow) - "This is what we do every day"

2. **Human-in-the-Loop:** Show Diagram 2 - "AI assists, YOU decide"

3. **Context Setup:** Show Diagram 3 (JIRA to Copilot) - "Here's how we get context to AI"

4. **Folder Structure:** Show Diagram 7 - "This is where everything lives"

5. **With/Without Patterns:** Show Diagram 6 - "This is why patterns matter"

6. **Full Workflow:** Show Diagram 1 - "Putting it all together"

---

## Rendering These Diagrams

**In VS Code:**
- Install "Markdown Preview Mermaid Support" extension
- Open preview: `Cmd+Shift+V`

**In GitHub:**
- Mermaid renders automatically in .md files

**For Presentation:**
- Use Mermaid Live Editor: https://mermaid.live
- Export as PNG/SVG for slides

**In Notion/Confluence:**
- Most support Mermaid natively or via plugin
