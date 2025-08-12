## **🔗 Chain: Complete API Test Automation Workflow**

### **Scenario**: You have a Jira story and need complete test automation from planning to execution

---

## **STEP 1: Template 4.2 → Generate Test Data First**

```
### **🔹 Role:**
You are acting as a **Test Data Engineer**, responsible for creating comprehensive test datasets based on test plans.

---

### **🔹 Context:**
We need test data for this user story:

**Story**: Create User Registration API

**Description**:
Users should be able to register with email, password, and profile information

**Acceptance Criteria**:
- Email must be valid format and unique
- Password must meet complexity requirements
- Profile fields (name, phone) are required
- System returns appropriate error codes for validation failures

**Test Plan**:
1. Valid registration scenarios with different user types
2. Email validation (invalid formats, duplicates)
3. Password validation (too short, no special chars, etc.)
4. Missing required fields
5. Boundary testing for field lengths
6. Performance testing with bulk registrations

---

### **🔹 Your Task:**
Generate complete test data sets that support all testing scenarios outlined in the test plan.

---

### **🔹 Required Deliverables:**
- ✅ **Valid Data Sets**: Complete data for each test scenario in the plan
- ✅ **Invalid Data Sets**: Boundary violations and malformed inputs per plan
- ✅ **Edge Case Data**: Extreme values and unusual combinations from plan
- ✅ **JSON Fixtures**: REST Assured compatible test data
- ✅ **Performance Data**: Large datasets for load testing scenarios

---

### **🔹 Output Goals:**
Ensure your test data is:
- 🧩 **Test Plan Compliant** supporting all scenarios in the plan
- 🎯 **Realistic** using believable data patterns
- 🔁 **Reusable** across different test suites
- 📽️ **Framework-ready**: Compatible with testing tools and CI/CD

---

### **🔹 Chain Output:**
Save the generated test data as `user-registration-test-data.json` for use in the next template.

```

---

## **STEP 2: Template 4.1 → Generate BDD Feature Using Test Data**

```
### **🔹 Role:**
You are acting as a **Senior Test Automation Engineer**, responsible for creating comprehensive Cucumber BDD feature files from test plans.

---

### **🔹 Context:**
We need to generate a complete BDD feature file for this user story:

**Story**: Create User Registration API

**Description**:
Users should be able to register with email, password, and profile information

**Acceptance Criteria**:
- Email must be valid format and unique
- Password must meet complexity requirements
- Profile fields (name, phone) are required
- System returns appropriate error codes for validation failures

**Test Plan**:
1. Valid registration scenarios with different user types
2. Email validation (invalid formats, duplicates)
3. Password validation (too short, no special chars, etc.)
4. Missing required fields
5. Boundary testing for field lengths
6. Performance testing with bulk registrations

**Swagger/OpenAPI Link**:
http://localhost:8080/api/docs

---

### **🔹 Your Task:**
Create a complete Cucumber BDD feature file that covers all test scenarios from the test plan.

---

### **🔹 Required Deliverables:**
- ✅ **Feature Description**: Clear business value statement
- ✅ **Background Section**: Common setup steps for authentication/data
- ✅ **Happy Path Scenarios**: Positive test cases from test plan
- ✅ **Negative Test Scenarios**: Error cases and edge conditions from test plan
- ✅ **Scenario Outlines**: Data-driven test cases using the test data from Step 1
- ✅ **Tags**: Appropriate categorization (@smoke, @regression, @api, @integration)

---

### **🔹 Output Goals:**
Ensure your feature file is:
- 🧩 **Test Plan Aligned** covering all scenarios from the provided plan
- 🎯 **Data-Driven** using test data from `user-registration-test-data.json`
- 🔁 **Maintainable** with reusable step definitions
- 📽️ **Framework-ready**: Compatible with Serenity BDD and REST Assured

---

### **🔹 Chain Input:**
Use the test data generated in Step 1 (`user-registration-test-data.json`) for your scenario outlines and examples tables.

---

### **🔹 Chain Output:**
Save the feature file as `user-registration.feature` for implementation in Step 3.

```

---

## **STEP 3: Template 4.3 → Implement REST Assured Code**

```
### **🔹 Role:**
You are acting as a **Senior Test Automation Engineer**, responsible for implementing REST Assured test automation code based on test plans.

---

### **🔹 Context:**
We need complete REST Assured test implementation for:

**Story**: Create User Registration API

**Description**:
Users should be able to register with email, password, and profile information

**Acceptance Criteria**:
- Email must be valid format and unique
- Password must meet complexity requirements
- Profile fields (name, phone) are required
- System returns appropriate error codes for validation failures

**Test Plan**:
1. Valid registration scenarios with different user types
2. Email validation (invalid formats, duplicates)
3. Password validation (too short, no special chars, etc.)
4. Missing required fields
5. Boundary testing for field lengths
6. Performance testing with bulk registrations

**Swagger/OpenAPI Link**:
http://localhost:8080/api/docs

---

### **🔹 Your Task:**
Create complete REST Assured test automation code that implements all test scenarios from the test plan.

---

### **🔹 Required Deliverables:**
- ✅ **Step Definition Classes**: Serenity BDD compatible step implementations for all test plan scenarios
- ✅ **Request/Response POJOs**: Data transfer objects based on API specifications
- ✅ **Test Data Builders**: Builder pattern using test data from Step 1
- ✅ **Assertion Helpers**: Reusable validation methods for all test cases
- ✅ **Authentication Setup**: Token management and security handling
- ✅ **Error Handling**: Proper exception management and logging

---

### **🔹 Output Goals:**
Ensure your test code is:
- 🧩 **Feature File Driven** implementing every scenario from `user-registration.feature`
- 🎯 **Data Integrated** using `user-registration-test-data.json`
- 🔁 **Reusable** across similar test scenarios
- 📽️ **CI/CD Ready**: Compatible with automated test execution

---

### **🔹 Chain Inputs:**
- Use the BDD feature file from Step 2 (`user-registration.feature`)
- Use the test data from Step 1 (`user-registration-test-data.json`)
- Implement step definitions that match the Gherkin steps exactly

---

### **🔹 Chain Output:**
Generate complete test automation suite ready for execution and CI/CD integration.

```

---

## **🔗 CHAINING WORKFLOW SUMMARY**

### **Input**: Single Jira story + Test plan

### **Output**: Complete test automation suite

**Chain Flow**:

```
Jira Story + Test Plan
    ↓
[Template 4.2] → Test Data Generation
    ↓
[Template 4.1] → BDD Feature File (using test data)
    ↓
[Template 4.3] → REST Assured Implementation (using feature + data)
    ↓
Complete Test Automation Suite

```

### **🎯 Benefits of This Chain**:

1. **Consistency**: Each template builds on the previous output
2. **Efficiency**: No re-entering the same information
3. **Quality**: Test data drives feature scenarios drives implementation
4. **Traceability**: Clear lineage from requirements to executable tests
5. **Reusability**: Each output artifact can be version controlled and reused

### **🚀 Usage Instructions**:

1. Run Template 4.2 first, save the JSON output
2. Run Template 4.1, reference the JSON in your prompt
3. Run Template 4.3, reference both previous outputs
4. Result: Complete test automation in 15 minutes instead of 4+ hours!

This chaining approach transforms template usage from isolated tasks into **orchestrated workflows** that mirror real development processes! 🎯