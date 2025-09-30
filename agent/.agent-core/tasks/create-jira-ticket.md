# JIRA Ticket Creation Task
# Purpose: Create comprehensive, well-structured JIRA tickets for effective project management and tracking

## Task Overview
This task guides the creation of detailed, actionable JIRA tickets that provide development teams with clear requirements, acceptance criteria, and success metrics for efficient story delivery.

## Prerequisites
- Access to JIRA system and appropriate project
- Understanding of Agile/Scrum methodology
- Knowledge of business requirements and user needs
- Understanding of technical architecture and constraints
- Familiarity with team's Definition of Done

## Input Requirements
- Business requirement or user need
- Stakeholder expectations and priorities
- Technical constraints and dependencies
- Acceptance criteria and success metrics
- Timeline and resource considerations
- Risk assessment and mitigation needs

## JIRA Ticket Creation Process

### Step 1: Requirement Analysis and Preparation
**Objective:** Thoroughly understand and analyze the requirement before ticket creation

**Analysis Activities:**
1. **Requirement Understanding:**
   - Clarify business need and value proposition
   - Identify target users and personas
   - Understand current state and desired future state
   - Analyze business rules and constraints
   - Identify success metrics and KPIs

2. **Technical Analysis:**
   - Review system architecture and affected components
   - Identify technical dependencies and constraints
   - Assess integration requirements
   - Evaluate performance and scalability needs
   - Consider security and compliance requirements

3. **Stakeholder Engagement:**
   - Interview business stakeholders
   - Consult with technical team members
   - Engage with UX/UI designers if needed
   - Review with product owner/manager
   - Validate understanding with end users

**Tools to Use:**
- Use `codebase` to understand technical implementation
- Use `search` to find similar existing tickets
- Use `usages` to understand component dependencies
- Review existing documentation and requirements

### Step 2: Ticket Structure and Information Organization
**Objective:** Organize information using JIRA ticket template structure

**Template Reference:** Use `jira-ticket-template.md` for comprehensive structure

**Key Information Organization:**
1. **Ticket Metadata:**
   ```
   Project: [PROJECT_KEY]
   Issue Type: [Story/Bug/Task/Epic/Subtask]
   Priority: [Highest/High/Medium/Low/Lowest]
   Labels: [LABEL1, LABEL2, LABEL3]
   Epic Link: [EPIC-123]
   Sprint: [Sprint name/number]
   ```

2. **Summary and Description:**
   - Craft concise, descriptive summary
   - Provide comprehensive background context
   - Define clear problem statement
   - Propose high-level solution approach
   - Include business value justification

3. **Component and System Information:**
   - Identify affected system components
   - List involved APIs and services
   - Document database impacts
   - Note infrastructure requirements
   - Include third-party integrations

### Step 3: Acceptance Criteria Development
**Objective:** Create clear, testable acceptance criteria using BDD format

**BDD Acceptance Criteria Format:**
```gherkin
Given [precondition/context]
When [action/trigger]
Then [expected result/outcome]

Example:
Given I am a logged-in user with admin privileges
When I navigate to the user management page
Then I should see a list of all active users with their roles
And I should have options to edit or deactivate users
And the list should be sortable by name, role, and last login
```

**Acceptance Criteria Best Practices:**
1. **Specific and Measurable:**
   - Use concrete, observable criteria
   - Include quantifiable metrics where applicable
   - Specify exact expected behaviors
   - Define clear success/failure conditions

2. **Complete Coverage:**
   - Cover all main functionality scenarios
   - Include edge cases and error conditions
   - Address non-functional requirements
   - Consider accessibility and usability aspects
   - Include data validation requirements

3. **Testable Format:**
   - Write criteria that can be automated
   - Include test data requirements
   - Specify environmental conditions
   - Define setup and teardown needs

### Step 4: Technical Details and Dependencies
**Objective:** Provide comprehensive technical information for development

**Technical Specification:**
1. **Architecture Considerations:**
   - System component interactions
   - Data flow and processing requirements
   - API design and integration points
   - Database schema changes needed
   - Performance and scalability requirements

2. **Implementation Guidance:**
   ```markdown
   Components Affected:
   - [Component 1]: [Description of changes]
   - [Component 2]: [Description of changes]
   
   APIs/Services Involved:
   - [API/Service 1]: [Usage details]
   - [API/Service 2]: [Usage details]
   
   Database Changes:
   - [ ] Schema changes required
   - [ ] Data migration needed
   - [ ] New tables/indexes required
   ```

3. **Dependency Management:**
   ```markdown
   Blocks:
   - [TICKET-123] - Description of blocking relationship
   
   Blocked By:
   - [TICKET-456] - Description of dependency
   
   Related To:
   - [TICKET-789] - Description of relationship
   ```

### Step 5: Test Strategy and Quality Assurance
**Objective:** Define comprehensive testing approach and quality criteria

**Test Strategy Development:**
1. **Test Types and Coverage:**
   ```markdown
   Test Cases Required:
   1. [Happy path scenario 1]
   2. [Happy path scenario 2]
   3. [Error handling scenario 1]
   4. [Edge case scenario 1]
   5. [Performance scenario 1]
   
   Automation Requirements:
   - [ ] Unit tests required
   - [ ] Integration tests required
   - [ ] API tests required
   - [ ] UI tests required
   - [ ] Performance tests required
   ```

2. **Quality Gates and Definition of Done:**
   ```markdown
   Definition of Done:
   - [ ] Requirements are clearly understood
   - [ ] Technical approach reviewed and approved
   - [ ] Code written and peer reviewed
   - [ ] Unit tests written and passing
   - [ ] Integration tests written and passing
   - [ ] Manual testing completed
   - [ ] Documentation updated
   - [ ] Code deployed to staging
   - [ ] QA testing completed
   - [ ] Product Owner acceptance received
   ```

3. **Test Data Requirements:**
   - Identify required test data sets
   - Specify data creation procedures
   - Document data privacy requirements
   - Plan data cleanup procedures

### Step 6: Risk Assessment and Mitigation
**Objective:** Identify and plan for potential risks and challenges

**Risk Analysis:**
1. **Technical Risks:**
   ```markdown
   High Risk Areas:
   - [Risk 1]: [Description] - Mitigation: [Strategy]
   - [Risk 2]: [Description] - Mitigation: [Strategy]
   
   Technical Risks:
   - [Tech risk 1]: [Mitigation approach]
   - [Tech risk 2]: [Mitigation approach]
   ```

2. **Business Risks:**
   - User adoption challenges
   - Performance impact concerns
   - Integration complexity issues
   - Timeline and resource constraints
   - Compliance and regulatory risks

3. **Mitigation Strategies:**
   - Risk prevention measures
   - Contingency planning approaches
   - Monitoring and early warning systems
   - Escalation procedures and contacts
   - Rollback and recovery plans

### Step 7: Estimation and Planning
**Objective:** Provide accurate estimates and planning information

**Effort Estimation:**
1. **Story Pointing:**
   - Use team's established story point scale
   - Consider complexity, effort, and uncertainty
   - Include testing and documentation effort
   - Account for integration and deployment time
   - Factor in risk and dependency impacts

2. **Time Estimation:**
   ```markdown
   Effort Estimation:
   - Development: [X hours/days]
   - Testing: [X hours/days]
   - Documentation: [X hours/days]
   - Review and rework: [X hours/days]
   Total: [Total estimate]
   ```

3. **Resource Planning:**
   - Required skill sets and expertise
   - Team member assignments
   - External dependency coordination
   - Infrastructure and tool needs
   - Timeline constraints and milestones

### Step 8: Communication and Collaboration Planning
**Objective:** Establish clear communication and collaboration approach

**Communication Strategy:**
1. **Stakeholder Management:**
   ```markdown
   Stakeholders:
   - [Business Owner]: [Notification requirements]
   - [Technical Lead]: [Review and approval needs]
   - [End Users]: [Feedback and acceptance criteria]
   
   Communication Plan:
   - Daily standups: Progress updates
   - Sprint reviews: Demo and feedback
   - Ad-hoc: Blockers and issues
   ```

2. **Collaboration Approach:**
   - Cross-team coordination needs
   - Review and approval workflows
   - Knowledge sharing requirements
   - Documentation and handoff procedures

## Deliverables

### Primary Deliverables
1. **Complete JIRA Ticket:** Using `jira-ticket-template.md` structure
2. **Acceptance Criteria:** Comprehensive BDD-format criteria
3. **Technical Specifications:** Detailed implementation guidance
4. **Test Strategy:** Complete testing approach and requirements
5. **Risk Assessment:** Risk analysis and mitigation plans

### Supporting Deliverables
1. **Requirements Analysis:** Detailed requirement understanding
2. **Dependency Map:** Visual representation of dependencies
3. **Wireframes/Mockups:** UI/UX design materials (if applicable)
4. **API Documentation:** Interface specifications (if applicable)
5. **Data Models:** Database design and changes (if applicable)

## Tool Integration
- Use `codebase` to understand technical implementation needs
- Use `search` to find similar tickets and patterns
- Use `usages` to understand component dependencies
- Use JIRA APIs for automated ticket creation
- Use project management tools for planning integration

## Quality Gates
- [ ] Business requirement clearly understood and documented
- [ ] Acceptance criteria written in testable BDD format
- [ ] Technical details comprehensive and accurate
- [ ] Dependencies identified and managed
- [ ] Risk assessment completed with mitigation plans
- [ ] Test strategy defined and comprehensive
- [ ] Effort estimation completed and validated
- [ ] Stakeholder review and approval obtained
- [ ] Communication plan established
- [ ] Definition of Done aligned with team standards

## Success Metrics
- Development team can start work without clarification requests
- Acceptance criteria are clear and testable
- All dependencies are identified and managed
- Risk mitigation plans are effective
- Story completion time meets estimates
- Quality gates are passed on first attempt
- Stakeholder satisfaction with delivery
- No scope creep or requirement changes during development

## Next Steps After JIRA Ticket Creation
1. Add ticket to appropriate sprint/backlog
2. Assign to development team member
3. Monitor progress and provide clarifications
4. Participate in daily standups and reviews
5. Validate acceptance criteria during development
6. Conduct acceptance testing when ready
7. Gather feedback for process improvement
8. Plan follow-up stories or enhancements