# CREATE Framework Guide for QA Engineers

## Table of Contents
- [Overview](#overview)
- [What is the CREATE Framework?](#what-is-the-create-framework)
- [Framework Components](#framework-components)
- [Implementation Guidelines](#implementation-guidelines)
- [Practical Example](#practical-example)
- [Best Practices](#best-practices)
- [Common Pitfalls](#common-pitfalls)
- [Templates and Checklists](#templates-and-checklists)

---

## Overview

This guide provides QA engineers with a structured approach to crafting effective prompts for AI tools using the CREATE framework. Whether you're analyzing test automation suitability, generating test cases, or seeking technical guidance, the CREATE framework helps ensure your prompts yield high-quality, actionable responses.

**Target Audience:** QA Engineers, Test Automation Engineers, QA Leads, Test Architects

**Prerequisites:** Basic understanding of AI/LLM tools and testing concepts

---

## What is the CREATE Framework?

The CREATE framework is a prompt engineering methodology specifically optimized for Quality Engineering tasks. It provides a structured approach to crafting prompts that:

- Reduce AI "hallucinations" and irrelevant responses
- Focus on specific QA problems and contexts
- Generate actionable, technically sound recommendations
- Improve consistency across team members' AI interactions

### Why CREATE Works for QA

Unlike generic prompting approaches, CREATE addresses the unique challenges in Quality Engineering:
- **Technical Precision:** QA requires specific, accurate technical guidance
- **Context Sensitivity:** Testing decisions depend heavily on application context
- **Risk Assessment:** QA decisions must consider business impact and risk
- **Actionable Outcomes:** Results must translate into concrete testing actions

---

## Framework Components

### **C - Character**
Define the AI's role and expertise level to access relevant knowledge domains.

**Purpose:** Establishes the AI's persona and expertise context
**QA Application:** Specify testing specializations, experience level, industry focus

**Examples:**
```
✅ Good: "Act as a senior test automation architect with 8+ years in e-commerce testing"
❌ Poor: "Act as a tester"
```

### **R - Request**
Clearly state what you want the AI to accomplish.

**Purpose:** Defines the specific task or analysis required
**QA Application:** Test strategy decisions, automation assessments, risk analysis

**Examples:**
```
✅ Good: "Analyze the test automation feasibility for mobile payment features"
❌ Poor: "Help with testing"
```

### **E - Examples**
Provide concrete scenarios or reference cases to guide the AI's reasoning.

**Purpose:** Illustrates expected approach and quality standards
**QA Application:** Testing scenarios, similar applications, success/failure cases

**Examples:**
```
✅ Good: "Consider scenarios like: successful API automation (stable endpoints), 
         unsuccessful UI automation (frequently changing layouts)"
❌ Poor: No examples provided
```

### **A - Application**
Describe the specific context, system, or domain being analyzed.

**Purpose:** Provides essential context for informed recommendations
**QA Application:** System architecture, business domain, user base, technical stack

**Examples:**
```
✅ Good: "High-traffic banking application processing 100K+ daily transactions"
❌ Poor: "A web application"
```

### **T - Task**
Specify the exact work to be performed with clear scope and deliverables.

**Purpose:** Defines concrete actions and expected outputs
**QA Application:** Analysis scope, feature lists, specific testing areas

**Examples:**
```
✅ Good: "Evaluate automation suitability for these 6 checkout process features"
❌ Poor: "Look at the features"
```

### **E - Evaluation**
Define success criteria and quality standards for the response.

**Purpose:** Establishes how to measure response quality and completeness
**QA Application:** Coverage requirements, detail level, decision criteria

**Examples:**
```
✅ Good: "Include technical feasibility, ROI analysis, and implementation priority"
❌ Poor: No evaluation criteria specified
```

---

## Implementation Guidelines

### 1. **Start with Your QA Challenge**
Before writing the prompt, clearly identify:
- What testing decision you need to make
- What information you need to gather
- What level of detail is required
- Who will use the output

### 2. **Choose Relevant CREATE Elements**
Not every prompt needs all six elements. Select based on:
- **Simple queries:** Character + Request + Task
- **Complex analysis:** All six elements
- **Technical guidance:** Character + Request + Application + Examples

### 3. **Order Considerations**
While CREATE doesn't mandate order, consider this flow for QA:
1. **Character** - Establish expertise
2. **Application** - Provide context
3. **Request** - State the goal
4. **Task** - Define specific work
5. **Examples** - Guide approach
6. **Evaluation** - Set success criteria

### 4. **Iterative Refinement**
- Test your prompt with a simple case first
- Refine based on response quality
- Build a library of proven prompts for your team

---

## Practical Example

Here's a complete CREATE framework prompt for analyzing automation suitability:

```yaml
prompt: |
  # Bus Booking System Automation Analysis
  
  ## Character (C)
  Act as a senior QA automation expert and test architect with 10+ years of experience 
  in enterprise-level web application testing. You specialize in automation strategy 
  development, ROI analysis for test automation initiatives, and have extensive 
  experience with complex booking systems in the transportation industry.
  
  ## Request (R)
  Analyze the automation suitability of an online bus booking system's key features. 
  For each feature, determine whether it should be automated, manually tested, or 
  requires a hybrid approach. Provide detailed justifications based on technical 
  complexity, business impact, ROI potential, and maintenance overhead.
  
  ## Examples (E)
  Consider these scenarios when making assessments:
  - Successful Automation: Payment processing with stable APIs and high regression risk
  - Unsuitable Automation: Customer review moderation requiring human judgment
  - Hybrid Approach: Real-time seat selection (API testing + manual UI validation)
  
  ## Application (A)
  High-traffic online bus booking system for MegaTrans Corporation serving 50+ cities 
  with 10,000+ daily bookings, processing $2M+ daily transactions. System uses:
  - Frontend: React.js, TypeScript, Material-UI, PWA
  - Backend: Node.js, PostgreSQL, Redis, Elasticsearch  
  - Cloud: AWS EKS, RDS, CloudFront, ALB
  - Integrations: Stripe, PayPal, Twilio, SendGrid, Google Maps
  
  ## Task (T)
  Evaluate automation suitability for these 8 features:
  1. Real-time seat selection interface
  2. Multi-gateway payment processing
  3. Dynamic route search and filtering
  4. Customer review and rating system
  5. SMS/email notification system
  6. Mobile ticket generation with QR codes
  7. Customer support live chat
  8. Loyalty program management
  
  ## Evaluation (E)
  Successful analysis includes:
  - Clear automation suitability rating (High/Medium/Low/Not Suitable)
  - Technical feasibility assessment with specific challenges
  - Business impact and ROI analysis
  - Implementation priority ranking
  - Alternative testing strategies for non-automatable features
  - Maintenance complexity considerations

context:
  domain: "transportation_booking_systems"
  complexity: "enterprise_level"
  urgency: "strategic_planning"
  
expected_output:
  format: "structured_analysis"
  length: "comprehensive"
  technical_depth: "detailed"
```

---

## Best Practices

### ✅ **Do's**

1. **Be Specific with Character**
   - Include years of experience, specializations, industry focus
   - Match expertise level to complexity of your request

2. **Provide Rich Application Context**
   - Include technical stack details
   - Mention business scale and impact
   - Describe user base and usage patterns

3. **Use Concrete Examples**
   - Reference real scenarios from your experience
   - Include both positive and negative examples
   - Show different complexity levels

4. **Define Clear Success Criteria**
   - Specify required detail level
   - Include format preferences
   - Set quality expectations

5. **Test and Iterate**
   - Start with simple cases
   - Refine based on results
   - Build team prompt library

### ❌ **Don'ts**

1. **Avoid Vague Character Definitions**
   - Don't use generic roles like "tester" or "QA person"
   - Avoid undefined experience levels

2. **Skip Essential Context**
   - Don't omit technical stack information
   - Avoid missing business context and scale

3. **Forget Examples**
   - Don't assume AI understands your specific domain
   - Avoid only positive or only negative examples

4. **Leave Evaluation Open-Ended**
   - Don't skip success criteria definition
   - Avoid unclear output format expectations

---

## Common Pitfalls

### 1. **Over-Complexity**
**Problem:** Including unnecessary CREATE elements for simple requests
**Solution:** Use only relevant elements; simple queries need fewer components

### 2. **Under-Specification**
**Problem:** Too generic character or application descriptions
**Solution:** Be specific about expertise areas and system characteristics

### 3. **Missing Domain Context**
**Problem:** Assuming AI understands your specific QA challenges
**Solution:** Always include relevant technical and business context

### 4. **Inconsistent Team Usage**
**Problem:** Team members using different prompting approaches
**Solution:** Create and maintain shared prompt templates

### 5. **No Iteration**
**Problem:** Using initial prompts without refinement
**Solution:** Test, measure results, and continuously improve prompts

---

## Templates and Checklists

### Quick START Template
```yaml
character: "Act as a [expertise_level] [specialization] with [experience] in [domain]"
request: "Analyze/Evaluate/Recommend [specific_task] for [target_system]"
application: "[system_type] serving [scale] with [technical_stack]"
task: "Assess [specific_items/features/areas]"
evaluation: "Include [criteria_1], [criteria_2], [criteria_3]"
```

### Pre-Prompt Checklist
- [ ] **Character**: Specific expertise and experience defined?
- [ ] **Request**: Clear, actionable goal stated?
- [ ] **Examples**: Relevant scenarios provided?
- [ ] **Application**: Sufficient technical and business context?
- [ ] **Task**: Specific scope and deliverables defined?
- [ ] **Evaluation**: Success criteria and quality standards set?

### Post-Response Evaluation
- [ ] Response addresses all requested elements?
- [ ] Technical recommendations are specific and actionable?
- [ ] Business context appropriately considered?
- [ ] Output format matches expectations?
- [ ] Content quality meets professional standards?

---

## Conclusion

The CREATE framework provides QA teams with a structured, repeatable approach to AI-assisted testing decisions. By following this guide, you can:

- Generate more accurate and relevant AI responses
- Maintain consistency across team members
- Build a library of proven prompts for common QA scenarios
- Improve the quality of AI-assisted testing analysis

**Next Steps:**
1. Practice with the provided template
2. Adapt examples to your domain and systems
3. Share successful prompts with your team
4. Continuously refine based on results

---

**Document Version:** 1.0  
**Last Updated:** September 2025  
**Maintained by:** QA Engineering Team  
**Review Schedule:** Quarterly