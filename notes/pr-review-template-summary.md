# How to Use the Pull Request Review Template - Copilot Agent Mode V1

## 📋 **Summary**

This template orchestrates GitHub Copilot's **agent mode tools** to perform systematic pull request analysis. Rather than generic AI assistance, it specifically leverages tools like `Git Changes` (to analyze diffs), `Codebase` (to understand context), `Find Usages` (to map dependencies), `Find Test Files` (to validate coverage), and `Get Problems` (to identify issues). The prompt guides Copilot to use these tools in a structured workflow, automatically discovering code relationships, security vulnerabilities, and integration impacts that manual reviews typically miss.

**Key Innovation**: Turns Copilot's individual tools into an **orchestrated code review workflow**  
**Time Investment**: 5-10 minutes setup → 2-3 minutes automated tool execution → Comprehensive review report + generated file  
**Value**: Systematic analysis using Copilot's full agent mode capabilities, not just chat responses

---

---

## ⚠️ **Important Notes & Limitations**

### **What This Template Does Well**
- ✅ Identifies security vulnerabilities
- ✅ Maps code dependencies and impact
- ✅ Validates test coverage comprehensively
- ✅ Finds performance bottlenecks
- ✅ Ensures acceptance criteria are met
- ✅ Provides specific, actionable feedback

### **What This Template Cannot Do**
- ❌ Replace human judgment on business logic
- ❌ Understand complex domain-specific requirements
- ❌ Make architectural decisions
- ❌ Test the actual functionality (only analyzes code)
- ❌ Access external systems or databases

### **Best Use Cases**
- **Complex PRs** with multiple file changes
- **Security-critical features** requiring thorough analysis
- **Integration changes** affecting multiple services
- **Large teams** where consistency is important
- **Junior developer PRs** needing comprehensive guidance

### **When NOT to Use**
- **Simple, single-file changes** (overkill)
- **Emergency hotfixes** (too time-consuming)
- **Experimental/prototype code** (analysis may not be relevant)
- **Documentation-only changes** (limited value)

---

## 🔧 **Prerequisites**

Before using this template:

1. **Open Visual Studio Code** in your project directory
2. **Check out the PR branch** that you want to analyze locally
3. **Agent Mode enabled** in VS Code settings
4. **Verification**: Open Copilot Chat (Ctrl+Shift+I or Cmd+Shift+I), look for "Agent" mode in the dropdown, and verify you can see tools like "Git Changes", "Codebase", "Find Usages" in the tool selection

---

## 📝 **Step-by-Step Usage Instructions**

### **Step 1: Prepare Your Environment**

**Checkout the PR Branch**:
```bash
git fetch 
git checkout [pr-branch-name]
```


---

### **Step 2: Gather Required Information**

Collect the following information to fill the template:
- **Story Description** 
- **Acceptance Criteria**
- **Technical Requirements & Notes**

---

### **Step 3: Fill Out the Template**

1. **Copy the template** from the prompt section above
2. **Replace the placeholders** with your gathered information:
   - `[PASTE USER STORY DESCRIPTION HERE]` → Your story description
   - `[PASTE ACCEPTANCE CRITERIA HERE]` → Your acceptance criteria  
   - `[PASTE TECHNICAL REQUIREMENTS HERE]` → Your technical requirements

3. **Keep everything else unchanged** - the tool instructions and workflow are pre-configured

---

### **Step 4: Execute the Analysis**

1. **Open GitHub Copilot Chat** (Ctrl+Shift+I or Cmd+Shift+I)
2. **Select "Agent" mode** from the dropdown
3. **Paste the completed template** into the chat
4. **Press Enter** to submit the prompt

**⏱️ Expected Duration**: 2-3 minutes for comprehensive analysis

---

## 📊 **What to Expect in the Output**

The AI will generate a comprehensive analysis and **create a review file in your project's root directory**. This file will contain detailed findings, specific file references, and actionable recommendations categorized by priority.

---

## ⚠️ **Important Notes & Limitations**

### **What This Template Does Well**
- ✅ Identifies security vulnerabilities
- ✅ Maps code dependencies and impact
- ✅ Validates test coverage comprehensively
- ✅ Finds performance bottlenecks
- ✅ Ensures acceptance criteria are met
- ✅ Provides specific, actionable feedback

### **What This Template Cannot Do**
- ❌ Replace human judgment on business logic
- ❌ Understand complex domain-specific requirements
- ❌ Make architectural decisions
- ❌ Test the actual functionality (only analyzes code)
- ❌ Access external systems or databases

### **Best Use Cases**
- **Complex PRs** with multiple file changes
- **Security-critical features** requiring thorough analysis
- **Integration changes** affecting multiple services
- **Large teams** where consistency is important
- **Junior developer PRs** needing comprehensive guidance

### **When NOT to Use**
- **Simple, single-file changes** (overkill)
- **Emergency hotfixes** (too time-consuming)
- **Experimental/prototype code** (analysis may not be relevant)
- **Documentation-only changes** (limited value)