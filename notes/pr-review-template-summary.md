# How to Use the Pull Request Review Template - Copilot Agent Mode V1

## 📋 **Summary**

This template transforms GitHub Copilot into an autonomous code review specialist that analyzes pull requests using advanced agent mode tools. Instead of manually reviewing code changes, the AI performs comprehensive analysis including security scanning, performance assessment, test coverage validation, and dependency impact mapping - all while you focus on higher-level architectural decisions.

**Time Investment**: 5-10 minutes setup → 2-3 minutes AI analysis → Comprehensive review report  
**Value**: Catches security vulnerabilities, performance issues, and integration problems that manual reviews often miss

---

## 🔧 **Prerequisites**

Before using this template, ensure you have:

### **Required Tools**
- **VS Code** with GitHub Copilot extension (latest version)
- **GitHub Copilot subscription** (Business, Enterprise, or Pro+)
- **Agent Mode enabled** in VS Code settings
- **Local access** to the repository and PR branch

### **Required Access**
- Pull request details (story description, acceptance criteria)
- Technical requirements or implementation notes
- Ability to checkout the PR branch locally

### **Verification Steps**
1. Open VS Code → Open Copilot Chat (Ctrl+Shift+I or Cmd+Shift+I)
2. Look for "Agent" mode in the chat dropdown
3. Verify you can see tools like "Git Changes", "Codebase", "Find Usages" in the tool selection

---

## 📝 **Step-by-Step Usage Instructions**

### **Step 1: Prepare Your Environment**

**Checkout the PR Branch**:
```bash
# Option A: Using GitHub CLI
gh pr checkout [PR-NUMBER]

# Option B: Using git directly
git fetch origin
git checkout [pr-branch-name]
```

**Open VS Code**:
```bash
# Navigate to your project directory
cd /path/to/your/project
code .
```

**Open GitHub Copilot Chat**:
- Press `Ctrl+Shift+I` (Windows/Linux) or `Cmd+Shift+I` (Mac)
- Select **"Agent"** from the mode dropdown
- Ensure tools are enabled (you should see 27+ tools available)

---

### **Step 2: Gather Required Information**

You need to collect the following information to fill the template:

#### **A. Story Description**
```
Example:
As a user, I want to register a new account with email verification
So that I can securely access the application with a verified email address
```

#### **B. Acceptance Criteria**
```
Example:
- User can register with email, password, and basic profile info
- System sends verification email after registration
- User must verify email before account activation
- Password must meet security requirements (8+ chars, special chars)
- Duplicate email addresses are rejected
- Registration form validates input client-side and server-side
```

#### **C. Technical Requirements & Notes**
```
Example:
- Use Spring Security for password hashing
- Implement email service integration (SendGrid)
- Add database tables for user and email_verification
- Include comprehensive error handling
- Add audit logging for security events
```

**💡 Pro Tip**: You can find this information in:
- Jira ticket description and acceptance criteria
- PR description on GitHub
- Technical design documents
- Team discussion notes

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

1. **Paste the completed template** into GitHub Copilot Chat
2. **Press Enter** to submit the prompt
3. **Watch the AI work** - you'll see it automatically:
   - Use `Git Changes` to identify modified files
   - Use `Codebase` to understand context
   - Use `Find Usages` to map dependencies
   - Use `Find Test Files` to check test coverage
   - Use `Get Problems` to identify issues

4. **Approve tool usage** when prompted (tools require confirmation for security)

**⏱️ Expected Duration**: 2-3 minutes for comprehensive analysis

---

## 📊 **What to Expect in the Output**

The AI will generate a comprehensive review report with the following sections:

### **🔍 Discovery Phase Results**
```
Example Output:
- 12 files modified across authentication module
- New UserController, UserService, EmailService classes
- Database migration files for user tables
- Integration points with existing SecurityConfig
```

### **🔧 Code Quality Assessment**
```
Example Output:
🔴 BLOCKER: Password hashing not implemented in UserService.createUser()
🟡 IMPORTANT: Email validation regex inconsistent with existing patterns
🟢 NICE-TO-HAVE: Consider extracting email templates to configuration
```

### **🛡️ Security Analysis**
```
Example Output:
🔴 BLOCKER: Email verification tokens not cryptographically secure
🔴 BLOCKER: SQL injection risk in custom user lookup query
🟡 IMPORTANT: Missing rate limiting on registration endpoint
```

### **⚡ Performance Assessment**
```
Example Output:
🟡 IMPORTANT: Registration endpoint makes 3 separate DB calls - consider transaction
🟢 NICE-TO-HAVE: Add caching for duplicate email checks
```

### **🧪 Test Coverage Analysis**
```
Example Output:
🔴 BLOCKER: No tests found for EmailService integration
🟡 IMPORTANT: Missing edge case tests for password validation
✅ GOOD: UserController has comprehensive unit tests
```

### **📁 Generated Review File**

**IMPORTANT**: The AI will create a review document in your project's root directory:

**File Location**: `./pull-request-review-[timestamp].md`

**File Contents**:
- Complete analysis results
- Specific file names and line numbers for issues
- Actionable recommendations with code examples
- Priority categorization (Blockers, Important, Nice-to-have)
- Dependency impact mapping

---

## 🎯 **How to Act on the Results**

### **🔴 Blockers (Must Fix Before Merge)**
- Address security vulnerabilities immediately
- Fix critical bugs or missing functionality
- Resolve failing tests or syntax errors
- **Action**: Request changes on the PR

### **🟡 Important (Should Address)**
- Performance improvements
- Code quality enhancements
- Minor security considerations
- **Action**: Discuss with PR author, may or may not block merge

### **🟢 Nice-to-Have (Future Improvements)**
- Code style suggestions
- Optimization opportunities
- Documentation improvements
- **Action**: Create follow-up tickets for future sprints

### **💡 Recommendations (Best Practices)**
- Architecture improvements
- Pattern consistency suggestions
- Tool/library recommendations
- **Action**: Consider for broader team adoption

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

## 🚀 **Pro Tips for Maximum Effectiveness**

### **📝 Input Quality Tips**
1. **Be specific** in acceptance criteria - vague requirements lead to incomplete analysis
2. **Include technical constraints** - mention specific frameworks, security requirements, performance targets
3. **Reference related PRs** - if this PR builds on previous work, mention it in technical notes

### **🔧 Tool Usage Tips**
1. **Enable all tools** in Copilot Chat for maximum analysis depth
2. **Review the generated file** thoroughly - it contains more detail than the chat output
3. **Save successful prompts** - you can reuse the same pattern for similar PRs

### **📊 Results Analysis Tips**
1. **Focus on blockers first** - security and functionality issues take priority
2. **Cross-reference with manual review** - AI catches different issues than humans
3. **Share findings with the team** - use this as a learning opportunity
4. **Track common patterns** - if the AI finds the same issues repeatedly, consider process improvements

---

## 🔄 **Troubleshooting Common Issues**

### **Issue**: "Agent mode not available"
**Solution**: 
- Update VS Code to latest version
- Ensure GitHub Copilot extension is updated
- Check that your Copilot subscription includes agent mode

### **Issue**: "Tools not working"
**Solution**:
- Verify you're on the correct PR branch
- Check that tools are enabled in Copilot Chat settings
- Try refreshing VS Code or restarting Copilot

### **Issue**: "Analysis seems incomplete"
**Solution**:
- Ensure all placeholders in template are filled
- Verify the PR branch has actual changes (use `git status`)
- Check that acceptance criteria are specific and detailed

### **Issue**: "No review file generated"
**Solution**:
- Look for the file in project root directory
- Check VS Code file explorer for new `.md` files
- Verify agent mode has write permissions in the project directory

This template transforms a traditionally time-consuming manual process into a systematic, AI-powered workflow that delivers enterprise-grade code review results in minutes instead of hours.