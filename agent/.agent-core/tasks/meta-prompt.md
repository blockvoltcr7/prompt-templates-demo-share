# Meta-Prompt Creation Task
# Purpose: Create effective prompts for AI agents and automation tools

## Task Overview
This task guides the creation of effective, well-structured prompts for AI agents, automation tools, and other AI-powered systems to ensure consistent and high-quality outputs.

## Prerequisites
- Understanding of AI prompt engineering principles
- Knowledge of target AI system capabilities
- Clear understanding of desired outcomes
- Access to example prompts and templates
- Understanding of the specific domain or use case

## Input Requirements
- Target AI system specifications
- Use case requirements and constraints
- Expected input/output formats
- Quality criteria and success metrics
- Domain expertise and context
- Example scenarios and test cases

## Meta-Prompt Creation Process

### Step 1: Requirements Analysis
**Objective:** Define clear requirements for the prompt and expected outcomes

**Requirements Gathering:**
1. **Use Case Definition:**
   - Identify specific problem to solve
   - Define target user persona
   - Understand usage context and frequency
   - Determine success criteria
   - Identify constraints and limitations

2. **AI System Analysis:**
   - Research target AI capabilities
   - Understand token limits and constraints
   - Identify optimal input/output formats
   - Review best practices for the platform
   - Understand model strengths and weaknesses

3. **Output Specification:**
   - Define expected output format
   - Specify quality requirements
   - Identify edge cases and error conditions
   - Define validation criteria
   - Set performance expectations

**Deliverables:**
- Requirements specification document
- Success criteria definition
- Constraint analysis summary

### Step 2: Prompt Structure Design
**Objective:** Design optimal prompt structure using proven patterns

**Prompt Architecture:**
```
1. Context Setting
   - Domain context and background
   - Role definition for AI agent
   - Situational awareness information

2. Task Definition
   - Clear, specific task description
   - Expected behavior specification
   - Success criteria and constraints

3. Input/Output Specification
   - Input format and examples
   - Output format and structure
   - Data type and validation rules

4. Guidelines and Constraints
   - Behavioral guidelines
   - Quality standards
   - Ethical considerations
   - Performance constraints

5. Examples and Demonstrations
   - Positive examples (what to do)
   - Negative examples (what not to do)
   - Edge case handling examples
```

**Template Reference:** Use `meta-prompt-template.md` for systematic structure

### Step 3: Context Engineering
**Objective:** Craft effective context and role definitions

**Context Design Principles:**
1. **Role Definition:**
   ```
   You are a [SPECIFIC_ROLE] with expertise in [DOMAIN_AREAS].
   Your responsibilities include [KEY_RESPONSIBILITIES].
   You have [RELEVANT_EXPERIENCE] and follow [STANDARDS/METHODOLOGIES].
   ```

2. **Domain Context:**
   - Provide relevant background information
   - Define key terms and concepts
   - Establish domain constraints
   - Set expectations for expertise level
   - Include relevant standards or frameworks

3. **Situational Context:**
   - Define current situation or problem
   - Provide relevant historical context
   - Identify stakeholders and their needs
   - Establish urgency and priority
   - Define success criteria

**Context Optimization:**
- Use specific, concrete details
- Avoid ambiguous language
- Include relevant constraints
- Balance detail with conciseness
- Test with various scenarios

### Step 4: Task Specification and Instructions
**Objective:** Create clear, actionable task definitions

**Task Definition Components:**
1. **Primary Task:**
   ```
   Your primary task is to [SPECIFIC_ACTION] by [METHOD/APPROACH].
   You must [REQUIRED_ACTIONS] while ensuring [QUALITY_CRITERIA].
   ```

2. **Sub-tasks and Steps:**
   - Break complex tasks into steps
   - Define sequence and dependencies
   - Specify decision points
   - Include validation steps
   - Define completion criteria

3. **Behavioral Guidelines:**
   - Communication style requirements
   - Quality standards and expectations
   - Error handling approaches
   - Escalation procedures
   - Continuous improvement expectations

**Instruction Optimization:**
- Use imperative voice for clarity
- Provide specific, actionable steps
- Include decision-making criteria
- Define quality checkpoints
- Allow for iterative improvement

### Step 5: Input/Output Format Design
**Objective:** Define clear data formats and structures

**Input Format Specification:**
```
Input Format:
- [DATA_TYPE_1]: [DESCRIPTION] - [FORMAT] - [VALIDATION_RULES]
- [DATA_TYPE_2]: [DESCRIPTION] - [FORMAT] - [VALIDATION_RULES]
- [DATA_TYPE_3]: [DESCRIPTION] - [FORMAT] - [VALIDATION_RULES]

Input Example:
[CONCRETE_EXAMPLE_OF_EXPECTED_INPUT]
```

**Output Format Specification:**
```
Output Format:
- [OUTPUT_SECTION_1]: [DESCRIPTION] - [FORMAT]
- [OUTPUT_SECTION_2]: [DESCRIPTION] - [FORMAT]
- [OUTPUT_SECTION_3]: [DESCRIPTION] - [FORMAT]

Output Example:
[CONCRETE_EXAMPLE_OF_EXPECTED_OUTPUT]
```

**Format Best Practices:**
- Use structured formats (JSON, YAML, markdown)
- Include validation criteria
- Provide clear examples
- Handle edge cases explicitly
- Define error response formats

### Step 6: Example Creation and Testing
**Objective:** Create comprehensive examples and test scenarios

**Example Types:**
1. **Positive Examples:**
   - Ideal input/output pairs
   - Common use case scenarios
   - Best practice demonstrations
   - Success story illustrations
   - Quality standard examples

2. **Edge Case Examples:**
   - Boundary condition handling
   - Error scenario responses
   - Unusual input handling
   - Constraint violation responses
   - Fallback behavior demonstrations

3. **Negative Examples:**
   - What not to do illustrations
   - Poor quality output examples
   - Common mistake demonstrations
   - Inappropriate response examples
   - Constraint violation examples

**Testing Strategy:**
- Create diverse test scenarios
- Include both simple and complex cases
- Test with various input types
- Validate output quality consistently
- Measure response time and efficiency

### Step 7: Quality Assurance and Optimization
**Objective:** Ensure prompt effectiveness and reliability

**Quality Assessment Criteria:**
1. **Clarity and Precision:**
   - Instructions are unambiguous
   - Technical terms are defined
   - Examples illustrate expectations
   - Success criteria are measurable

2. **Completeness:**
   - All necessary context provided
   - Input/output formats specified
   - Constraints clearly stated
   - Edge cases addressed

3. **Effectiveness:**
   - Produces consistent results
   - Meets quality requirements
   - Response time acceptable
   - Handles various input types

**Optimization Process:**
- A/B test different prompt versions
- Measure output quality metrics
- Gather user feedback
- Iterate based on performance data
- Refine based on edge case findings

### Step 8: Documentation and Implementation
**Objective:** Create comprehensive documentation and implementation guide

**Documentation Components:**
1. **Prompt Documentation:** Using `meta-prompt-template.md`
   - Complete prompt specification
   - Usage instructions
   - Quality criteria
   - Testing results
   - Version history

2. **Implementation Guide:**
   - Integration instructions
   - Configuration requirements
   - Deployment procedures
   - Monitoring and alerting setup
   - Troubleshooting guide

3. **User Guide:**
   - How to use the prompt effectively
   - Common patterns and examples
   - Troubleshooting common issues
   - Best practices for users
   - FAQ and support information

**Implementation Considerations:**
- Version control and change management
- A/B testing framework setup
- Performance monitoring
- Quality metrics tracking
- User feedback collection

## Deliverables

### Primary Deliverables
1. **Meta-Prompt Document:** Using `meta-prompt-template.md`
2. **Test Suite:** Comprehensive test cases and validation
3. **Implementation Guide:** Deployment and integration instructions
4. **Quality Metrics Dashboard:** Performance measurement system
5. **User Documentation:** Usage guide and best practices

### Supporting Deliverables
1. **Requirements Specification:** Detailed requirements analysis
2. **Design Rationale:** Prompt design decisions and justification
3. **Testing Results:** Quality validation and performance metrics
4. **Optimization Report:** Improvement recommendations and roadmap
5. **Training Materials:** User education and onboarding resources

## Tool Integration
- Use `codebase` to understand integration requirements
- Use `search` to find existing prompt patterns
- Use `runTests` to validate prompt effectiveness
- Use `problems` to identify integration issues
- Use available AI tools to test prompt performance

## Quality Gates
- [ ] Requirements clearly defined and approved
- [ ] Prompt structure follows best practices
- [ ] Context and role definitions are effective
- [ ] Task specifications are clear and actionable
- [ ] Input/output formats are well-defined
- [ ] Examples comprehensively cover use cases
- [ ] Quality assessment shows positive results
- [ ] Documentation is complete and accurate
- [ ] Testing validates prompt effectiveness
- [ ] Implementation guide enables successful deployment

## Success Metrics
- Prompt produces consistent, high-quality outputs
- User satisfaction scores meet targets
- Response time within acceptable limits
- Error rate below defined threshold
- Adoption rate meets expectations
- Maintenance effort minimized
- Quality metrics show continuous improvement

## Next Steps After Meta-Prompt Creation
1. Deploy prompt to target AI system
2. Monitor performance and quality metrics
3. Collect user feedback and usage data
4. Iterate and improve based on findings
5. Scale to additional use cases
6. Share best practices with team
7. Establish continuous improvement process
8. Plan next generation enhancements