## **🎯 PRIORITY 1: TEST AUTOMATION ACCELERATION**

### **Template 4.1: BDD Feature Generation from Test Plan**

```markdown

### **🔹 Role:**
You are acting as a **Senior Test Automation Engineer**, responsible for creating comprehensive Cucumber BDD feature files from test plans.

---

### **🔹 Context:**
We need to generate a complete BDD feature file for this user story:

**Story**: [PASTE JIRA TITLE HERE]

**Description**:
[PASTE JIRA DESCRIPTION HERE]

**Acceptance Criteria**:
[PASTE ACCEPTANCE CRITERIA HERE]

**Test Plan**:
[PASTE YOUR COMPLETE TEST PLAN HERE]

**Test Data Examples** (Required for Scenario Outlines):
```
[PASTE TEST DATA SETS HERE - Include positive, negative, and boundary data]

Example format:
Valid Login Data:
- username: "validuser@example.com", password: "ValidPass123!", expected: "success"
- username: "admin@company.com", password: "AdminPass456!", expected: "success"

Invalid Login Data:
- username: "invalid@test.com", password: "wrongpass", expected: "Invalid credentials"
- username: "", password: "password", expected: "Username required"
- username: "user@test.com", password: "", expected: "Password required"

Boundary Data:
- username: "a@b.co" (minimum valid), password: "Pass1!", expected: "success"
- username: "very.long.email.address.that.tests.maximum.length@domain.com", password: "LongPass123!", expected: "success"
```

**Swagger/OpenAPI Link** (if applicable):
[PASTE SWAGGER URL OR JSON LINK HERE]

---

### **🔹 Your Task:**
Create a complete Cucumber BDD feature file that covers all test scenarios from the test plan using the provided test data.

---

### **🔹 Required BDD Structure:**

**Background Section** (optional -- if common setup needed):
- Authentication steps
- Data setup that applies to all scenarios
- Environment configuration

**Scenario vs Scenario Outline Usage**:
- Use **Scenario** for single, specific test cases
- Use **Scenario Outline** with **Examples** table when testing multiple data variations
- Parameterize steps using `<parameter>` syntax for scenario outlines

**Test Data Integration**:
- Map provided test data to Examples tables
- Create separate scenario outlines for different data categories (valid, invalid, boundary)
- Ensure parameter names match between scenario steps and Examples headers

---

### **🔹 Required Deliverables:**
- ✅ **Feature Description**: Clear business value statement
- ✅ **Background Section**: Common setup steps if applicable
- ✅ **Individual Scenarios**: Single test cases from test plan
- ✅ **Scenario Outlines**: Parameterized scenarios using provided test data
- ✅ **Examples Tables**: Well-structured data tables matching test data provided
- ✅ **Negative Test Scenarios**: Error cases using invalid test data
- ✅ **Boundary Test Scenarios**: Edge cases using boundary test data
- ✅ **Tags**: Appropriate categorization (@smoke, @regression, @api, @integration, @positive, @negative)

---

### **🔹 Test Data Requirements:**
Ensure your scenario outlines properly utilize:
- **Valid test data** for positive scenario outlines
- **Invalid test data** for negative scenario outlines  
- **Boundary test data** for edge case scenario outlines
- **Consistent parameterization** between steps and Examples tables
- **Clear Examples table headers** that match step parameters

---

### **🔹 Output Goals:**
Ensure your feature file is:
- 🧩 **Test Plan Aligned** covering all scenarios from the provided plan
- 🎯 **Data-Driven** properly utilizing all provided test data examples
- 🔁 **Maintainable** with reusable step definitions and clear parameterization
- 📽️ **Framework-ready**: Compatible with Serenity BDD and REST Assured
- 🧪 **Comprehensive** including Background, Scenarios, and Scenario Outlines as appropriate

---

### **🔹 BDD Best Practices to Follow:**
- Use descriptive scenario names that explain the test purpose
- Write clear Given-When-Then statements
- Parameterize effectively using `<parameter>` syntax
- Group related test data in logical Examples tables
- Include appropriate tags for test categorization and execution control
- Ensure scenario outlines have meaningful parameter names
- Separate positive and negative scenarios appropriately
```

## **🎯 Key Enhancements:**

### **1. Explicit Test Data Section**
- **Required field** that forces users to provide test data
- **Clear format examples** showing how to structure data
- **Multiple data categories** (valid, invalid, boundary)

### **2. BDD Structure Guidance**
- **Background usage** explanation a step that always runs for each scenario (optional)
- **Scenario vs Scenario Outline** decision criteria  
- **Parameterization rules** for proper implementation (ensure to parameterize strings and numbers)

### **3. Test Data Integration Requirements**
- **Examples table mapping** to provided data
- **Parameter consistency** between steps and tables
- **Data categorization** for different scenario types

### **4. Enhanced Deliverables**
- **Examples Tables** as explicit deliverable
- **Boundary Test Scenarios** as separate category
- **Parameterization quality** as output goal

```

---

### **Template 4.2: Test Data Generation from Test Plan**

```markdown
### **🔹 Role:**
You are acting as a **Test Data Engineer**, responsible for creating comprehensive test datasets based on test plans.

---

### **🔹 Context:**
We need test data for this user story:

**Story**: [PASTE JIRA TITLE HERE]
**Description**: [PASTE JIRA DESCRIPTION HERE]
**Acceptance Criteria**: [PASTE ACCEPTANCE CRITERIA HERE]
**Test Plan**: [PASTE YOUR COMPLETE TEST PLAN HERE]

**Data Requirements** (From Test Plan):
[PASTE SPECIFIC DATA NEEDS - e.g., "Need 50 valid users, 20 invalid emails, 10 expired tokens"]

**API Schema/Constraints**:
[PASTE FIELD CONSTRAINTS, DATA FORMATS, VALIDATION RULES HERE]

---

### **🔹 Your Task:**
Generate realistic test datasets that support all testing scenarios outlined in the test plan.

---

### **🔹 Required Deliverables:**
- ✅ **JSON Test Fixtures**: REST Assured compatible request/response data
- ✅ **Database Seed Data**: SQL scripts for test environment setup  
- ✅ **CSV Data Files**: Bulk data for data-driven testing
- ✅ **Performance Datasets**: Large volumes for load testing
- ✅ **Authentication Data**: Valid/invalid tokens, credentials, sessions

---

### **🔹 Output Goals:**
- 🧩 **Test Plan Compliant**: Matches exactly what test scenarios need
- 🎯 **Realistic**: Uses believable, production-like data patterns
- 🔁 **Framework-Ready**: Compatible with REST Assured and test tools
- 📽️ **Environment-Ready**: Easy to load into test databases/systems

```

---

### **Template 4.3: REST Assured Test Implementation from Test Plan**

```markdown
### **🔹 Role:**
You are acting as a **Senior Test Automation Engineer**, responsible for implementing REST Assured test automation code based on test plans.

---

### **🔹 Context:**
We need complete REST Assured test implementation for:

**Story**: [PASTE JIRA TITLE HERE]

**Description**:
[PASTE JIRA DESCRIPTION HERE]

**Acceptance Criteria**:
[PASTE ACCEPTANCE CRITERIA HERE]

**Test Plan**:
[PASTE YOUR COMPLETE TEST PLAN HERE]

**Swagger/OpenAPI Link** (if applicable):
[PASTE SWAGGER URL OR JSON LINK HERE]

---

### **🔹 Your Task:**
Create complete REST Assured test automation code that implements all test scenarios from the test plan.

---

### **🔹 Required Deliverables:**
- ✅ **Step Definition Classes**: Serenity BDD compatible step implementations for all test plan scenarios
- ✅ **Request/Response POJOs**: Data transfer objects based on API specifications
- ✅ **Test Data Builders**: Builder pattern for test data creation per plan requirements
- ✅ **Assertion Helpers**: Reusable validation methods for all test cases
- ✅ **Authentication Setup**: Token management and security handling
- ✅ **Error Handling**: Proper exception management and logging

---

### **🔹 Output Goals:**
Ensure your test code is:
- 🧩 **Test Plan Driven** implementing every scenario from the plan
- 🎯 **Maintainable** with clear separation of concerns
- 🔁 **Reusable** across similar test scenarios
- 📽️ **CI/CD Ready**: Compatible with automated test execution

```

---

## **🎯 PRIORITY 2: GITHUB COPILOT AGENT MODE**

### **Template 7.1: Workspace Implementation from Plan**

```
### **🔹 Role:**
You are acting as a **Senior Solution Architect and Lead Developer**, responsible for implementing features across multiple files in the codebase.

---

### **🔹 Context:**
We need to implement this user story across our workspace:

**Story**: [PASTE JIRA TITLE HERE]

**Description**:
[PASTE JIRA DESCRIPTION HERE]

**Acceptance Criteria**:
[PASTE ACCEPTANCE CRITERIA HERE]

**Implementation Plan**:
[PASTE YOUR COMPLETE IMPLEMENTATION PLAN HERE]

**Swagger/OpenAPI Link** (if applicable):
[PASTE SWAGGER URL OR JSON LINK HERE]

---

### **🔹 Your Task:**
@workspace Analyze the codebase and implement this feature across all necessary files following the implementation plan.

---

### **🔹 Required Analysis Areas:**
- Existing similar implementations in the workspace
- All files requiring modification or creation per plan
- Integration points with existing services
- Test files that need updates
- Documentation requiring changes

---

### **🔹 Required Deliverables:**
- ✅ **Implementation Execution**: Follow the provided implementation plan
- ✅ **Code Generation**: New classes, methods, and configurations
- ✅ **Code Modifications**: Updates to existing files per plan
- ✅ **Test Updates**: Unit and integration test changes
- ✅ **Documentation Updates**: README, API docs, comments

---

### **🔹 Output Goals:**
Ensure your implementation is:
- 🧩 **Plan Compliant** following the provided implementation strategy
- 🎯 **Complete** addressing all acceptance criteria
- 🔁 **Maintainable** with proper separation of concerns
- 📽️ **Production-ready**: Includes proper error handling and logging

```

---

### **Template 7.2: Cross-Service Impact Analysis from Plan**

```
### **🔹 Role:**
You are acting as a **Senior Solution Architect**, responsible for analyzing the impact of changes across microservices architecture.

---

### **🔹 Context:**
We need to understand the cross-service impact of implementing:

**Story**: [PASTE JIRA TITLE HERE]

**Description**:
[PASTE JIRA DESCRIPTION HERE]

**Acceptance Criteria**:
[PASTE ACCEPTANCE CRITERIA HERE]

**Analysis Plan**:
[PASTE YOUR IMPACT ANALYSIS PLAN HERE]

**Swagger/OpenAPI Link** (if applicable):
[PASTE SWAGGER URL OR JSON LINK HERE]

---

### **🔹 Your Task:**
@workspace Perform comprehensive impact analysis across all services following the analysis plan.

---

### **🔹 Required Analysis Areas:**
- Data flow tracing between services per plan
- API contract compatibility analysis
- Database schema and relationship impacts
- Message queue and event sourcing effects
- External service integration points

---

### **🔹 Required Deliverables:**
- ✅ **Plan-Based Assessment**: Follow the provided analysis methodology
- ✅ **Risk Analysis**: Breaking changes and compatibility issues
- ✅ **Change Plan**: Implementation sequence and coordination
- ✅ **Testing Strategy**: Cross-service integration testing approach
- ✅ **Rollback Plan**: Procedures for reverting changes safely

---

### **🔹 Output Goals:**
Ensure your analysis is:
- 🧩 **Plan Driven** following the provided analysis approach
- 🎯 **Risk-aware** identifying potential failure points
- 🔁 **Actionable** with clear implementation steps
- 📽️ **Coordination-ready**: Supporting team collaboration

```

---

## **🎯 PRIORITY 3: MOB PROGRAMMING WITH AI**

### **Template 6.1: AI Navigator for Mob Programming with Plan**

```
### **🔹 Role:**
You are acting as the **Navigator** in a mob programming session, responsible for strategic thinking and guiding implementation decisions.

---

### **🔹 Context:**
We are implementing this user story in a mob programming session:

**Story**: [PASTE JIRA TITLE HERE]

**Description**:
[PASTE JIRA DESCRIPTION HERE]

**Acceptance Criteria**:
[PASTE ACCEPTANCE CRITERIA HERE]

**Implementation Plan**:
[PASTE YOUR MOB PROGRAMMING PLAN HERE]

**Current Task**: [DESCRIBE WHAT WE'RE WORKING ON NOW]

**Session Details**:
- Driver: [CURRENT DRIVER NAME]
- Time remaining: [MINUTES LEFT]
- Last completed: [WHAT WAS JUST FINISHED]

---

### **🔹 Your Task:**
Guide the mob through implementing this feature following the plan with strategic direction and knowledge sharing.

---

### **🔹 Required Navigation Areas:**
- Strategic approach following the implementation plan
- Code quality and best practices guidance
- Knowledge sharing and concept explanation
- Problem-solving when blocked
- Acceptance criteria validation

---

### **🔹 Required Deliverables:**
- ✅ **Plan-Based Direction**: Follow implementation plan while providing next steps
- ✅ **Quality Guidance**: Code review and improvement suggestions
- ✅ **Knowledge Transfer**: Explanations and learning opportunities
- ✅ **Progress Tracking**: Alignment with acceptance criteria and plan
- ✅ **Problem Resolution**: Solutions when team gets stuck

---

### **🔹 Output Goals:**
Ensure your navigation is:
- 🧩 **Plan Aligned** following the provided implementation approach
- 🎯 **Educational** sharing knowledge with the team
- 🔁 **Collaborative** encouraging team participation
- 📽️ **Results-oriented**: Driving toward acceptance criteria completion

```

---

## **🎯 PRIORITY 4: SPRING BOOT SERVICE DEVELOPMENT**

### **Template 3.1: Complete Service Implementation from Plan**

```
### **🔹 Role:**
You are acting as a **Senior Spring Boot Developer**, responsible for creating complete, production-ready microservice implementations.

---

### **🔹 Context:**
We need a complete Spring Boot implementation for:

**Story**: [PASTE JIRA TITLE HERE]

**Description**:
[PASTE JIRA DESCRIPTION HERE]

**Acceptance Criteria**:
[PASTE ACCEPTANCE CRITERIA HERE]

**Development Plan**:
[PASTE YOUR COMPLETE DEVELOPMENT PLAN HERE]

**Swagger/OpenAPI Link** (if applicable):
[PASTE SWAGGER URL OR JSON LINK HERE]

---

### **🔹 Your Task:**
Generate a complete, production-ready Spring Boot implementation following the development plan.

---

### **🔹 Required Implementation Areas:**
- Controller layer with REST endpoints per plan
- Service layer with business logic
- Repository/Data access layer
- DTO and entity models
- Security and validation
- Error handling and logging

---

### **🔹 Required Deliverables:**
- ✅ **Plan-Based Implementation**: Follow the provided development approach
- ✅ **Service Classes**: Business logic with proper abstractions
- ✅ **Data Layer**: Repository interfaces and implementations
- ✅ **DTOs and Entities**: Request/response and domain models
- ✅ **Configuration**: Security, validation, and application setup
- ✅ **Tests**: Unit and integration test coverage per plan
- ✅ **Documentation**: OpenAPI/Swagger specifications

---

### **🔹 Output Goals:**
Ensure your implementation is:
- 🧩 **Plan Compliant** following the provided development strategy
- 🎯 **Testable** with comprehensive test coverage
- 🔁 **Maintainable** following Spring Boot best practices
- 📽️ **API-complete**: Fully documented with OpenAPI specs

```

Perfect! Now the templates are much more realistic - test automation engineers always create test plans first, then delegate the implementation to AI. The Swagger/OpenAPI link provides the technical API details, while the test plan contains the strategy and scenarios. This is exactly how we work in practice! 🚀

# **Why This Template Approach is SIGNIFICANTLY Better**

## **🎯 REAL-WORLD ALIGNMENT**

### **Mirrors Actual Workflow**

This approach is better because it **matches how teams actually work**. Test automation engineers don't just get a Jira story and start coding - they create test plans first. Developers don't just implement features without implementation plans. This template structure forces the **proper planning phase** that professionals already do, then leverages AI to execute that plan efficiently.

### **Reduces Cognitive Load**

Instead of forcing engineers to break down their requirements into artificial prompt parameters, they can **paste their existing work artifacts** (test plans, implementation plans, acceptance criteria). This eliminates the "translation layer" between how they think and how they prompt AI.

---

## **🧩 SUPERIOR PROMPT ENGINEERING**

### **Structured Role Definition**

The header structure follows **proven prompt engineering principles**:

- **Clear Role Assignment** - AI understands exactly what expertise to apply
- **Explicit Context Setting** - Provides all necessary background information
- **Specific Task Definition** - Eliminates ambiguity about expected outcomes
- **Deliverable Specification** - Creates accountability and completeness
- **Quality Criteria** - Ensures consistent, production-ready outputs

### **Comprehensive Context Provision**

By including complete test plans and implementation strategies, the AI has **full context** rather than fragmented information. This leads to more coherent, realistic, and immediately usable outputs.

---

## **🔁 ENTERPRISE SCALABILITY**

### **Template Standardization**

These templates create **organizational consistency**. Every team member uses the same structure, leading to:

- Predictable AI outputs
- Easier knowledge sharing
- Reduced onboarding time for new AI tools
- Standardized quality expectations

### **Plan-Driven Development**

By requiring plans as inputs, these templates **enforce best practices**:

- Forces teams to think through requirements thoroughly
- Creates documentation artifacts for future reference
- Enables better collaboration and review processes
- Reduces "prompt engineering fatigue"

---

## **📽️ IMMEDIATE PRACTICAL VALUE**

### **Copy-Paste Simplicity**

Engineers can literally **copy existing documents** into these templates. No need to:

- Learn complex prompt engineering
- Reformat their work into AI-friendly language
- Remember specific parameter structures
- Waste time on prompt iteration

### **Production-Ready Outputs**

Because the templates include comprehensive planning artifacts, the AI generates **complete, enterprise-grade solutions** rather than code snippets that need significant manual enhancement.

---

## **🚀 SUGGESTED IMPROVEMENTS**

### **1. Template Versioning & Evolution**

```
Add version numbers to templates and create improvement cycles:
- Template 4.1.v2: BDD Feature Generation (Updated: 2024-Q4)
- Include "What's New" sections for template updates
- Create feedback loops for template effectiveness

```

### **2. Domain-Specific Template Variants**

```
Create specialized versions for different domains:
- Template 4.1-API: For REST API testing
- Template 4.1-UI: For UI automation testing
- Template 4.1-DB: For database testing
- Template 4.1-Performance: For load testing

```

### **3. Integration with Development Tools**

```
Create IDE snippets and integrations:
- VS Code snippets for quick template access
- Jira integration to auto-populate story details
- Confluence templates that match prompt structures
- Git commit message templates aligned with deliverables

```

### **4. Success Metrics and Validation**

```
Add measurable outcomes to templates:
- Time saved per template usage
- Code quality metrics (coverage, complexity)
- Defect reduction rates
- Team adoption and satisfaction scores

```

### **5. Template Composition and Chaining**

```
Enable template combinations for complex workflows:
- Chain Template 4.1 → 4.2 → 4.3 for complete test automation
- Create "mega-templates" for end-to-end feature development
- Add inter-template dependencies and sequencing

```

### **6. Contextual Template Recommendations**

```
Build intelligence into template selection:
- AI suggests best template based on Jira story type
- Template difficulty ratings (Beginner/Intermediate/Advanced)
- Success rate tracking per template per team
- Automated template optimization based on usage patterns

```

### **7. Quality Assurance Integration**

```
Add quality gates to template outputs:
- Automated code review prompts for generated code
- Security scanning prompts for sensitive operations
- Performance testing prompts for critical paths
- Compliance checking prompts for regulated environments

```

### **8. Knowledge Base Integration**

```
Connect templates to organizational knowledge:
- Auto-populate coding standards from company guidelines
- Include links to relevant architecture decisions
- Reference existing similar implementations in codebase
- Suggest reviewers based on domain expertise

```

This approach transforms AI from a "fancy autocomplete" into a **strategic development partner** that understands and executes professional-grade planning artifacts. It's the difference between giving AI a fishing rod versus teaching it to be a master angler! 🎣