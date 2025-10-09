# CREATE Framework Guide for Product Managers

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

This guide provides product managers with a structured approach to planning and scoping new projects using the CREATE framework. By leveraging this framework, product managers can effectively define project goals, engage stakeholders, and prioritize features to ensure successful project outcomes.

**Target Audience:** Product Managers, Product Owners, Project Managers

**Prerequisites:** Basic understanding of project management concepts and methodologies

---

## What is the CREATE Framework?

The CREATE framework is a prompt engineering methodology tailored for project planning and scoping. It provides a structured approach to crafting prompts that:

- Clarify project objectives and requirements
- Enhance stakeholder engagement and communication
- Prioritize features based on business value and feasibility
- Improve consistency in project planning across teams

### Why CREATE Works for Product Management

Unlike generic planning approaches, CREATE addresses the unique challenges in product management:
- **Goal Alignment:** Ensures project goals align with business objectives
- **Stakeholder Involvement:** Facilitates effective communication with stakeholders
- **Feature Prioritization:** Helps evaluate and rank features based on impact
- **Actionable Planning:** Translates project goals into concrete deliverables

---

## Framework Components

### **C - Character**
Define the AI's role and expertise level relevant to project management.

**Purpose:** Establishes the AI's persona and expertise context
**PM Application:** Specify product management experience, industry focus, and project types

**Examples:**
```
✅ Good: "Act as a senior product manager with 10+ years in SaaS product development"
❌ Poor: "Act as a product manager"
```

### **R - Request**
Clearly state what you want the AI to accomplish.

**Purpose:** Defines the specific task or analysis required
**PM Application:** Project scoping, feature prioritization, stakeholder analysis

**Examples:**
```
✅ Good: "Define the project scope for a new customer feedback tool"
❌ Poor: "Help with the project"
```

### **E - Examples**
Provide concrete scenarios or reference cases to guide the AI's reasoning.

**Purpose:** Illustrates expected approach and quality standards
**PM Application:** Similar projects, successful feature implementations, stakeholder feedback

**Examples:**
```
✅ Good: "Consider scenarios like: successful launch of a user onboarding feature, 
         challenges faced in integrating third-party APIs"
❌ Poor: No examples provided
```

### **A - Application**
Describe the specific context, system, or domain being analyzed.

**Purpose:** Provides essential context for informed recommendations
**PM Application:** Project type, target audience, market conditions

**Examples:**
```
✅ Good: "Developing a mobile application for remote team collaboration in the tech industry"
❌ Poor: "A mobile application"
```

### **T - Task**
Specify the exact work to be performed with clear scope and deliverables.

**Purpose:** Defines concrete actions and expected outputs
**PM Application:** Requirement gathering, feature lists, project timelines

**Examples:**
```
✅ Good: "Outline the key deliverables and timelines for the project"
❌ Poor: "Look at the project"
```

### **E - Evaluation**
Define success criteria and quality standards for the response.

**Purpose:** Establishes how to measure response quality and completeness
**PM Application:** Coverage requirements, detail level, stakeholder satisfaction

**Examples:**
```
✅ Good: "Include project objectives, key milestones, and stakeholder engagement strategies"
❌ Poor: No evaluation criteria specified
```

---

## Implementation Guidelines

### 1. **Start with Your Project Challenge**
Before writing the prompt, clearly identify:
- What project goals you need to define
- What information you need to gather
- What level of detail is required
- Who will use the output

### 2. **Choose Relevant CREATE Elements**
Not every prompt needs all six elements. Select based on:
- **Simple queries:** Character + Request + Task
- **Complex analysis:** All six elements
- **Stakeholder engagement:** Character + Request + Application + Examples

### 3. **Order Considerations**
While CREATE doesn't mandate order, consider this flow for PM:
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

Here's a complete CREATE framework prompt for scoping a new project:

```yaml
prompt: |
  # Customer Feedback Tool Project Scoping
  
  ## Character (C)
  Act as a senior product manager with 10+ years of experience in SaaS product development. 
  You specialize in user experience design, stakeholder engagement, and project scoping.
  
  ## Request (R)
  Define the project scope for a new customer feedback tool aimed at improving user satisfaction. 
  Outline the key deliverables, timelines, and stakeholder engagement strategies.
  
  ## Examples (E)
  Consider these scenarios when defining the scope:
  - Successful implementation of a feedback loop in a previous product
  - Challenges faced in gathering user insights from diverse demographics
  
  ## Application (A)
  Developing a mobile application for remote team collaboration in the tech industry, targeting 
  small to medium-sized businesses with a focus on user engagement and retention.
  
  ## Task (T)
  Outline the key deliverables and timelines for the project, including:
  1. User research and requirement gathering
  2. Prototype development
  3. User testing and feedback collection
  4. Final product launch
  
  ## Evaluation (E)
  Successful scope definition includes:
  - Clear project objectives
  - Key milestones and timelines
  - Stakeholder engagement strategies
  - Risk assessment and mitigation plans

context:
  domain: "customer_feedback_tools"
  complexity: "medium"
  urgency: "high"
  
expected_output:
  format: "project_scope_document"
  length: "detailed"
  technical_depth: "moderate"
```

---

## Best Practices

### ✅ **Do's**

1. **Be Specific with Character**
   - Include years of experience, specializations, industry focus
   - Match expertise level to complexity of your request

2. **Provide Rich Application Context**
   - Include market conditions and target audience details
   - Mention business scale and impact

3. **Use Concrete Examples**
   - Reference real scenarios from your experience
   - Include both successful and challenging examples

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
   - Don't use generic roles like "product manager"
   - Avoid undefined experience levels

2. **Skip Essential Context**
   - Don't omit market and audience information
   - Avoid missing project scope details

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
**Solution:** Be specific about expertise areas and project characteristics

### 3. **Missing Domain Context**
**Problem:** Assuming AI understands your specific project challenges
**Solution:** Always include relevant market and business context

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
request: "Define [specific_task] for [project_name]"
application: "[project_type] targeting [audience] with [market_conditions]"
task: "Outline [specific_deliverables]"
evaluation: "Include [criteria_1], [criteria_2], [criteria_3]"
```

### Pre-Prompt Checklist
- [ ] **Character**: Specific expertise and experience defined?
- [ ] **Request**: Clear, actionable goal stated?
- [ ] **Examples**: Relevant scenarios provided?
- [ ] **Application**: Sufficient market and audience context?
- [ ] **Task**: Specific scope and deliverables defined?
- [ ] **Evaluation**: Success criteria and quality standards set?

### Post-Response Evaluation
- [ ] Response addresses all requested elements?
- [ ] Recommendations are specific and actionable?
- [ ] Business context appropriately considered?
- [ ] Output format matches expectations?
- [ ] Content quality meets professional standards?

---

## Conclusion

The CREATE framework provides product managers with a structured, repeatable approach to project planning and scoping. By following this guide, you can:

- Generate more accurate and relevant project scopes
- Maintain consistency across team members
- Build a library of proven prompts for common project scenarios
- Improve the quality of project planning and stakeholder engagement

**Next Steps:**
1. Practice with the provided template
2. Adapt examples to your domain and projects
3. Share successful prompts with your team
4. Continuously refine based on results

---

**Document Version:** 1.0  
**Last Updated:** September 2025  
**Maintained by:** Product Management Team  
**Review Schedule:** Quarterly