## 🎯 **The Step 1 Template (With Placeholders):**


### **🔹 Role:**
You are acting as a **Senior Solution Architect and Technology Research Lead**, responsible for conducting comprehensive spike research for new technology integration.

---

### **🔹 Context:**
We need to research and plan integration of a new technology into our existing system:

**Spike Ticket**: [PASTE JIRA SPIKE TICKET TITLE HERE]

**Description**:
[PASTE SPIKE DESCRIPTION HERE]

**Business Requirements**:
[PASTE BUSINESS JUSTIFICATION AND REQUIREMENTS HERE]

**Current System Context**:
[PASTE CURRENT ARCHITECTURE/TECH STACK/CONSTRAINTS HERE]

**Research Goals**:
[PASTE SPECIFIC RESEARCH QUESTIONS AND OBJECTIVES HERE]

**Reference Documentation URLs** (Context Engineering):
Use the **fetch** tool to retrieve content from:
[PASTE OFFICIAL DOCS URLS HERE - e.g., https://supabase.com/docs/guides/functions/**]

---

### **🔹 Your Task:**
Use the following tools systematically to create a comprehensive integration plan:

**Required Tool Usage**:
- ✅ **codebase**: Analyze current implementation patterns in our workspace
- ✅ **search**: Find existing code and implementation details
- ✅ **fetch**: Retrieve official documentation and capabilities
- ✅ **githubRepo**: Search for real-world implementation examples
- ✅ **findTestFiles**: Locate existing tests for validation strategy
- ✅ **problems**: Check for any current issues in related files

---

### **🔹 Required Research Areas:**
- Current system architecture analysis using **codebase** and **search** tools
- Technology compatibility assessment using **fetch** for official documentation
- Integration points identification using **codebase** analysis
- Performance and scalability implications from documentation review
- Security and compliance considerations from official docs
- Development effort estimation based on code analysis

---

### **🔹 Required Deliverables:**
- ✅ **Technology Assessment**: Pros/cons analysis with our tech stack
- ✅ **Integration Architecture**: How technology fits into current system
- ✅ **Code Impact Analysis**: Files/modules requiring modification
- ✅ **Configuration Requirements**: Infrastructure and environment changes
- ✅ **Development Plan**: Step-by-step implementation approach
- ✅ **Risk Assessment**: Technical challenges and mitigation strategies
- ✅ **Proof of Concept**: Minimal viable integration example

---

### **🔹 Output Goals:**
Ensure your research is:
- 🧩 **Codebase-Aware** leveraging tool-based analysis of existing patterns
- 🎯 **Context-Rich** incorporating all fetched documentation and examples
- 🔁 **Actionable** with concrete next steps for implementation
- 📽️ **Decision-Ready** providing clear go/no-go recommendation

**YOU MUST WRITE ALL DOCUMENTATION TO THE ROOT DIRECTORY.**

---

### **🔹 Chain Output:**
Generate comprehensive spike research report with:
1. **Integration Architecture Diagram**
2. **Detailed Implementation Plan**
3. **Code Examples** using existing patterns discovered via codebase analysis
4. **Configuration Scripts/Files**

Save outputs for use in Step 2 solution architecture phase.



-------------------STEP 2------------------------


## 🎯 **The REAL Step 2 Template (With Placeholders):**


### **🔹 Role:**
You are acting as a **Senior Solution Architect and Lead Developer**, responsible for preparing **technical documentation and demo-ready artifacts** for both engineering teams and non-technical stakeholders.

---

### **🔹 Context:**
We are implementing a new feature within the system based on completed spike research:

**Spike Research Summary**:
[PASTE ENTIRE STEP 1 RESEARCH REPORT HERE]

---

### **🔹 Your Task:**
@workspace Provide a complete and accessible explanation of the current system and how the new technology integration fits into our architecture.

---

**Required Tool Usage**:
- ✅ **codebase**: Analyze current system architecture and integration points
- ✅ **search**: Find existing patterns and implementation details
- ✅ **editFiles**: Create architecture documentation files in root directory
- ✅ **fetch**: Retrieve additional technical references if needed for diagrams


### **🔹 Required Deliverables:**
Create and include the following artifacts as part of your output:

- ✅ **Flow Diagrams**: End-to-end process for how the system behaves before and after integration
- ✅ **Component Interaction Maps**: How new technology modules work together with existing services
- ✅ **Function-Level Summaries**: Highlight the responsibilities of key classes/methods
- ✅ **Integration Sequence**: Define where new technology logic fits in the execution chain
- ✅ **Visual Architecture Overview**: System map showing technology placement in overall architecture
- ✅ **Stakeholder Demo Summary**: Plain-language explanation of integration's purpose and benefits

**YOU MUST WRITE ALL DOCUMENTATION TO THE ROOT DIRECTORY.**

---

### **🔹 Output Goals:**
Ensure your output is:
- 🧩 **Technically accurate** and aligned with current implementation patterns
- 🎯 **Stakeholder-friendly** and easy to visualize in a live demo
- 🔁 **Reusable and maintainable** for future technology enhancements
- 📽️ **Demo-Ready**: supports storytelling for internal/external presentations

---

### **🔹 Chain Output:**
Generate comprehensive solution architecture package:
1. **Technical Architecture Documentation**
2. **Visual System Diagrams** (ASCII or Mermaid format)
3. **Demo-Ready Presentation Materials**
4. **Implementation Blueprints**
5. **Stakeholder Communication Artifacts**

Save all artifacts for use in Steps 3 and 4.


-------------------STEP 3------------------------

### **🔹 Role:**
You are acting as a **Senior Developer**, responsible for creating a detailed proof of concept plan following solution architecture blueprints.

---

### **🔹 Context:**
Create a comprehensive POC implementation plan based on solution architecture documentation:

**Solution Architecture Package**:
[PASTE ALL ARCHITECTURE FILES FROM STEP 2 HERE - Copy contents of ARCHITECTURE_OVERVIEW.md, FUNCTION_SUMMARIES.md, IMPLEMENTATION_BLUEPRINT.md, STAKEHOLDER_SUMMARY.md, SYSTEM_DIAGRAMS.md]

---

### **🔹 Your Task:**
Use the following tools systematically to create a detailed proof of concept implementation plan:

**Required Tool Usage**:
- ✅ **codebase**: Analyze existing code patterns for POC planning
- ✅ **search**: Find current implementation files that POC would modify
- ✅ **editFiles**: Create POC planning documentation
- ✅ **findTestFiles**: Identify existing tests for POC validation strategy

---

### **🔹 Required Deliverables:**
Create the following planning documents using **editFiles** tool:

- ✅ **POC Implementation Plan**: Detailed code examples and file structure (NO actual code changes)
- ✅ **Configuration Templates**: Example setup files and environment configs
- ✅ **Test Strategy**: Testing approach and validation scenarios
- ✅ **Setup Instructions**: Step-by-step POC execution guide
- ✅ **Demo Script**: Instructions for showcasing POC to stakeholders
- ✅ **Risk Mitigation**: Technical challenges and solutions

**WRITE ALL DOCUMENTATION TO THE ROOT DIRECTORY.**
**DO NOT MODIFY ANY EXISTING CODE FILES - PLANNING PHASE ONLY.**

---

### **🔹 Output Goals:**
Ensure your POC plan is:
- 🧩 **Architecture-Driven** following solution architecture blueprints
- 🎯 **Implementation-Ready** with detailed code examples in documentation
- 🔁 **Runnable** when team decides to implement
- 📽️ **Demo-Ready** with clear presentation materials

---

### **🔹 Chain Output:**
Complete POC planning package ready for:
1. **Architecture Review & Approval**
2. **Stakeholder Demo** (using Step 2 materials)
3. **Team Implementation** (when approved)
4. **Step 4 Knowledge Transfer**



-------------------STEP 4------------------------


### **🔹 Role:**
You are acting as a **Technical Lead and Solution Architecture Evangelist**, responsible for transferring complete solution knowledge to the development team.

---

### **🔹 Context:**
Create comprehensive knowledge transfer leveraging all solution artifacts:

**Complete Solution Package**:
[PASTE ALL 11 FILES FROM STEPS 2 & 3 HERE - All ARCHITECTURE_*.md and POC_*.md files]

### **🔹 Your Task:**
Use the following tools systematically to create comprehensive knowledge transfer materials:

**Required Tool Usage**:
- ✅ **codebase**: Understand current team patterns and skill levels
- ✅ **search**: Find existing documentation standards and formats
- ✅ **editFiles**: Create knowledge transfer documentation

---

### **🔹 Required Deliverables:**
Create the following knowledge transfer materials using **editFiles** tool:

- ✅ **Architecture Handbook**: Complete solution guide for team reference
- ✅ **Implementation Cookbook**: Step-by-step development guide
- ✅ **Team Onboarding Kit**: Developer training materials
- ✅ **Demo Playbook**: Reusable presentation materials
- ✅ **User Story Breakdown**: Development tasks mapped to components
- ✅ **Future Evolution Plan**: Path for ongoing enhancements

**WRITE ALL DOCUMENTATION TO THE ROOT DIRECTORY.**

---

### **🔹 Output Goals:**
Ensure your materials are:
- 🧩 **Team-Ready** matching current development practices
- 🎯 **Implementation-Ready** with proven development patterns
- 🔁 **Reference-Complete** for ongoing architectural guidance
- 📽️ **Presentation-Complete** supporting all stakeholder needs

---

### **🔹 Chain Output:**
Complete knowledge transfer package enabling team to:
1. **Understand Complete Solution Design**
2. **Implement Following Validated Architecture**
3. **Present to Stakeholders with Confidence**
4. **Evolve Architecture Over Time**
