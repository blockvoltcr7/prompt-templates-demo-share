## **🎯 Template Purpose**

Generate precise SQL queries for test data extraction based on database schema analysis and specific business criteria.

---

## **📋 CORE TEMPLATE**

```
### **🔹 Role:**
You are acting as a **Senior Database Analyst and Test Data Engineer**, responsible for creating optimized SQL queries to extract specific test data from production databases based on business requirements and schema analysis.

---

### **🔹 Context:**
We need to extract test data from our database for automated testing scenarios.

**Database Schema**:
[PASTE YOUR COMPLETE DATABASE SCHEMA HERE - Tables, columns, relationships, constraints]

**Business Requirements**:
[PASTE SPECIFIC TEST DATA REQUIREMENTS HERE]

**Example**: "Find accounts that have over-concentrated securities where the over_concentration_flag = 'RED' and account balance > $100,000"

**Additional Constraints**:
[PASTE ANY ADDITIONAL FILTERING CRITERIA, DATA PRIVACY REQUIREMENTS, OR BUSINESS RULES]

---

### **🔹 Your Task:**
Analyze the database schema and generate optimized SQL queries that return the exact test data needed for the specified business scenarios.

---

### **🔹 Required Analysis:**

**Schema Understanding**:
- ✅ **Table Relationships**: Identify primary/foreign key relationships
- ✅ **Column Analysis**: Understand data types, constraints, and business meaning
- ✅ **Join Requirements**: Determine necessary table joins for complete data
- ✅ **Index Considerations**: Optimize queries for performance

**Business Logic Translation**:
- ✅ **Requirement Mapping**: Map business terms to database columns
- ✅ **Condition Logic**: Translate business rules into SQL WHERE clauses
- ✅ **Data Completeness**: Ensure query returns all necessary fields for testing
- ✅ **Edge Case Handling**: Include boundary conditions and edge cases

---

### **🔹 Required Deliverables:**

**Primary SQL Query**:
- ✅ **Main Query**: Optimized SQL that returns requested test data
- ✅ **Column Selection**: All relevant columns for test scenario validation
- ✅ **Proper Joins**: Correct table relationships and join conditions
- ✅ **Filter Conditions**: Accurate WHERE clauses matching business requirements

### **🔹 Required Deliverables:**
- ✅ **Primary SQL Query**: Optimized SQL that returns requested test data
- ✅ **Column Selection**: All relevant columns for test scenario validation
- ✅ **Proper Joins**: Correct table relationships and join conditions
- ✅ **Filter Conditions**: Accurate WHERE clauses matching business requirements
- ✅ **Query Documentation**: Comments explaining business logic and usage

**Documentation**:
- ✅ **Query Explanation**: Comments explaining business logic and joins
- ✅ **Expected Results**: Description of what data the query should return
- ✅ **Performance Notes**: Index usage and optimization considerations
- ✅ **Data Usage Guidelines**: How to use extracted data in tests

---

### **🔹 SQL Query Requirements:**

**Query Structure**:
```sql
-- Business Requirement: [Describe what this query finds]
-- Expected Result Count: [Approximate number of records]
-- Performance Considerations: [Index usage, join optimization]

SELECT
    [list all relevant columns for testing]
FROM
    [primary table]
[JOIN clauses with proper relationships]
WHERE
    [business condition translations]
    AND [additional filtering criteria]
ORDER BY
    [logical ordering for test data consistency]
LIMIT [if needed for performance/test data volume];

```

**Query Optimization**:

- ✅ **Efficient Joins**: Use appropriate join types (INNER, LEFT, etc.)
- ✅ **Index Usage**: Leverage existing indexes in WHERE clauses
- ✅ **Performance**: Consider query execution time for large datasets
- ✅ **Readability**: Clear formatting and meaningful aliases

---

### **🔹 Output Goals:**

Ensure your SQL queries are:

- 🧩 **Schema Compliant**: Correctly reference tables, columns, and relationships
- 🎯 **Business Accurate**: Precisely match stated business requirements
- 🔁 **Reusable**: Parameterizable for different test scenarios
- 📽️ **Production Safe**: Optimized for performance on production databases
- 🛡️ **Data Secure**: Respect data privacy and access constraints

---

### **🔹 Query Validation Checklist:**

**Accuracy Verification**:

- [ ]  All table names and column names are correct
- [ ]  Join conditions properly link related tables
- [ ]  WHERE conditions accurately translate business requirements
- [ ]  Data types and formats match schema specifications

**Performance Verification**:

- [ ]  Query uses available indexes effectively
- [ ]  JOIN order is optimized for performance
- [ ]  LIMIT clauses prevent excessive data retrieval
- [ ]  Complex conditions are properly structured

**Completeness Verification**:

- [ ]  All necessary columns for testing are included
- [ ]  Edge cases and boundary conditions are addressed
- [ ]  Query variations cover positive, negative, and boundary scenarios
- [ ]  Documentation explains query purpose and usage

---

### **🔹 Example Output Format:**

**Main Test Data Query**:

```sql
-- Find accounts with over-concentrated RED securities
-- Business Rule: over_concentration_flag = 'RED' AND account_balance > 100000
-- Expected Results: ~50-100 test accounts
-- Performance: Uses idx_account_balance, idx_security_concentration

SELECT
    a.account_id,
    a.account_number,
    a.account_balance,
    a.account_type,
    s.security_id,
    s.security_symbol,
    s.concentration_percentage,
    s.over_concentration_flag,
    c.client_id,
    c.client_name
FROM accounts a
INNER JOIN securities s ON a.account_id = s.account_id
INNER JOIN clients c ON a.client_id = c.client_id
WHERE s.over_concentration_flag = 'RED'
    AND a.account_balance > 100000
    AND a.account_status = 'ACTIVE'
ORDER BY a.account_balance DESC, s.concentration_percentage DESC
FETCH 100 ROWS ONLY;

```

**Boundary Case Query**:

```sql
-- Find accounts at exactly the concentration threshold
-- Business Rule: Testing edge case at concentration boundary
SELECT [same columns as above]
FROM [same tables and joins]
WHERE s.concentration_percentage = 25.0  -- Assuming 25% is threshold
    AND a.account_balance BETWEEN 99000 AND 101000;

```

```

---

## **🎯 Template Advantages**

### **🔍 Schema-Driven Approach**
- **Complete Context**: AI has full database structure understanding
- **Relationship Mapping**: Automatic identification of necessary joins
- **Column Validation**: Ensures query references valid schema elements
- **Constraint Awareness**: Respects database constraints and data types

### **💼 Business Logic Translation**
- **Requirement Clarity**: Clear mapping from business needs to SQL logic
- **Edge Case Coverage**: Systematic approach to boundary and negative testing
- **Documentation**: Self-documenting queries with business context
- **Reusability**: Parameterizable queries for multiple test scenarios

### **⚡ Performance Optimization**
- **Index Awareness**: Leverages existing database indexes
- **Query Efficiency**: Optimized joins and filtering conditions
- **Production Safe**: Designed for execution on production databases
- **Volume Control**: Appropriate limits and performance considerations

### **🧪 Test Data Excellence**
- **Comprehensive Coverage**: Positive, negative, and boundary test cases
- **Data Completeness**: All necessary fields for test validation
- **Realistic Data**: Extracts actual production data patterns
- **Scenario Specific**: Targeted data for specific test requirements

---

## **🚀 Business Value**

### **⏱️ Time Savings**
- **70% Faster**: Query generation vs. manual schema analysis
- **Immediate Results**: No trial-and-error query development
- **Reusable Patterns**: Once generated, queries serve multiple test cycles
- **Documentation**: Self-explaining queries reduce knowledge transfer time

### **🎯 Accuracy Improvement**
- **Schema Validation**: AI prevents column/table reference errors
- **Business Logic**: Accurate translation of requirements to SQL
- **Complete Data**: Ensures all necessary test data fields are captured
- **Edge Case Coverage**: Systematic approach to comprehensive test data

### **🔧 Maintenance Reduction**
- **Self-Documenting**: Queries include business context and explanations
- **Performance Optimized**: Efficient queries reduce database load
- **Standardized Format**: Consistent query structure across team
- **Version Control Friendly**: Clear, formatted SQL suitable for code repositories

This template transforms the complex task of test data extraction from a time-consuming manual process into a systematic, AI-powered workflow that delivers production-ready SQL queries in minutes instead of hours!

```