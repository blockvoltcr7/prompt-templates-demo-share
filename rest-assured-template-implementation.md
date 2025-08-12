## **🎯 Template A: Existing Service Enhancement**

```
### **🔹 Role:**
You are acting as a **Senior Test Automation Engineer**, responsible for enhancing an existing service in our REST Assured test automation framework.

---

### **🔹 Context:**
We need to add new functionality to an existing service:

**Story**: [PASTE JIRA TITLE HERE]

**Description**:
[PASTE JIRA DESCRIPTION HERE]

**Acceptance Criteria**:
[PASTE ACCEPTANCE CRITERIA HERE]

**Service Name**: [EXISTING_SERVICE_NAME]

**Swagger/OpenAPI Link**:
[PASTE SWAGGER URL OR JSON LINK HERE]

**Existing Service Structure**:
[PASTE CURRENT SERVICE CLASS METHODS AND MODEL OBJECTS]

---

### **🔹 Your Task:**
Add new REST Assured methods and model objects to the existing service following current patterns.

---

### **🔹 Required Deliverables:**
- ✅ **New Service Methods**: Additional REST Assured API methods in existing service class
- ✅ **Updated Model Objects**: New request/response POJOs as needed
- ✅ **Enhanced Service Steps**: Additional `@Step` annotated methods for new functionality
- ✅ **Integration**: Use existing REST Assured utility functions

---

### **🔹 Output Goals:**
- 🧩 **Pattern Consistent**: Follow existing service class patterns
- 🎯 **Framework Compatible**: Use established REST Assured utilities
- 🔁 **Maintainable**: Clear method naming and structure
- 📽️ **Integration Ready**: Compatible with current test execution

```

---

## **🎯 Template B: New Service Integration**

```
### **🔹 Role:**
You are acting as a **Senior Test Automation Engineer**, responsible for integrating a new service into our existing REST Assured test automation framework.

---

### **🔹 Context:**
We need to create complete service integration for a new API:

**Story**: [PASTE JIRA TITLE HERE]

**Description**:
[PASTE JIRA DESCRIPTION HERE]

**Acceptance Criteria**:
[PASTE ACCEPTANCE CRITERIA HERE]

**New Service Name**: [NEW_SERVICE_NAME]

**Swagger/OpenAPI Link**:
[PASTE SWAGGER URL OR JSON LINK HERE]

**Framework Structure**:
- **Base Package**: [BASE_PACKAGE]
- **Existing Services**: [LIST_EXISTING_SERVICES]
- **REST Assured Utilities**: [LOCATION_OF_REST_ASSURED_UTILS]

**Service Requirements**:
[PASTE API ENDPOINTS AND METHODS NEEDED]

---

### **🔹 Your Task:**
Create complete new service integration following existing framework patterns.

---

### **🔹 Required Framework Structure:**

**Service Class** (`services/[service_name]/[ServiceName].java`):
- ✅ **API Methods**: GET, POST, PUT, DELETE methods using REST Assured
- ✅ **REST Assured Integration**: Wrap existing utility functions
- ✅ **Parameter Handling**: Endpoint URLs, request bodies, query parameters
- ✅ **Response Handling**: Return Response objects consistently

**Model Objects** (`models/[service_name]/`):
- ✅ **Request POJOs**: Objects for API request bodies
- ✅ **Response POJOs**: Objects for API response mapping
- ✅ **Jackson Annotations**: Proper JSON mapping

**Service Steps** (`steps/[ServiceName]Steps.java`):
- ✅ **Business Logic Methods**: Reusable service operations
- ✅ **Serenity Integration**: Methods annotated with `@Step`
- ✅ **Service Calls**: Use service class methods
- ✅ **Response Validation**: Common assertion patterns

---

### **🔹 Required Deliverables:**
- ✅ **Complete Service Class**: [ServiceName].java with all API methods
- ✅ **Model Objects**: Request/response POJOs with proper annotations
- ✅ **Service Steps Class**: [ServiceName]Steps.java with reusable `@Step` methods
- ✅ **Integration Documentation**: How to use the new service in tests

---

### **🔹 Service Class Pattern:**
```java
public class [ServiceName] {
    public Response createResource(CreateRequest request) {
        return RestAssuredUtils.post(ENDPOINT, request);
    }

    public Response getResourceById(String id) {
        return RestAssuredUtils.get(ENDPOINT + "/" + id);
    }

    public Response updateResource(String id, UpdateRequest request) {
        return RestAssuredUtils.put(ENDPOINT + "/" + id, request);
    }

    public Response deleteResource(String id) {
        return RestAssuredUtils.delete(ENDPOINT + "/" + id);
    }
}

```

---

### **🔹 Service Steps Pattern:**

```java
public class [ServiceName]Steps {
    @Step("Create new resource with valid data")
    public Response createValidResource(CreateRequest request) {
        return new [ServiceName]().createResource(request);
    }

    @Step("Verify resource creation was successful")
    public void verifyResourceCreated(Response response) {
        assertThat(response.statusCode()).isEqualTo(201);
    }
}

```

---

### **🔹 Output Goals:**

- 🧩 **Framework Compliant**: Follow existing service patterns
- 🎯 **Complete Integration**: All necessary components created
- 🔁 **Reusable**: Service methods and steps usable across tests
- 📽️ **Production Ready**: Compatible with CI/CD and test execution

```

---

## **🚀 KEY DIFFERENCES**

### **Template A: Existing Service**
- **Focus**: Adding functionality to existing codebase
- **Scope**: New methods, models, and steps only
- **Context**: Requires existing service structure information
- **Goal**: Seamless enhancement without breaking existing functionality

### **Template B: New Service**
- **Focus**: Complete service integration from scratch
- **Scope**: Full service class, models, and service steps creation
- **Context**: Requires framework structure and patterns
- **Goal**: Complete new service ready for test development

### **What's NOT Included (Correctly Excluded)**
- ❌ **Step Definitions**: These come from feature files, not service implementation
- ❌ **Cucumber Integration**: Separate BDD analysis and design phase
- ❌ **Feature File Creation**: Different responsibility entirely
- ❌ **Test Scenario Design**: That's test planning, not service implementation

Both templates focus purely on the **service layer implementation** - the foundation that step definitions will later use when connecting Gherkin scenarios to actual API interactions.

```