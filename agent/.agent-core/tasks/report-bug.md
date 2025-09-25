# Bug Report Creation Task
# Purpose: Create comprehensive, standardized bug reports for effective issue tracking and resolution

## Task Overview
This task guides the systematic creation of detailed bug reports that provide development teams with all necessary information for efficient defect resolution and quality improvement.

## Prerequisites
- Access to the application and testing environment
- Understanding of expected vs actual behavior
- Ability to reproduce the issue consistently
- Access to bug tracking system (JIRA, Azure DevOps, etc.)
- Knowledge of system architecture and test data

## Input Requirements
- Bug manifestation details (what went wrong)
- Steps that led to the issue discovery
- Environment and system configuration
- Test data and user context
- Expected behavior specification
- Business impact assessment

## Bug Report Creation Process

### Step 1: Issue Investigation and Reproduction
**Objective:** Thoroughly investigate and consistently reproduce the bug

**Investigation Activities:**
1. **Bug Reproduction:**
   - Reproduce the issue multiple times
   - Test across different environments
   - Verify with different user accounts/data
   - Test on different browsers/devices (if applicable)
   - Document exact conditions when bug occurs

2. **Impact Assessment:**
   - Identify affected user workflows
   - Assess business impact severity
   - Determine urgency level
   - Identify workaround possibilities
   - Evaluate scope of affected users

3. **Root Cause Hypothesis:**
   - Form initial hypothesis about cause
   - Identify likely system components involved
   - Review recent changes or deployments
   - Check for similar historical issues
   - Gather relevant system logs

**Tools to Use:**
- Use `problems` tool to identify compilation/runtime errors
- Use `testFailure` to understand test-related issues
- Use `search` to find similar issues in codebase
- Use browser developer tools for web applications
- Use application logs and monitoring tools

### Step 2: Information Gathering and Documentation
**Objective:** Collect comprehensive information for detailed bug report

**Information Collection:**
1. **Environment Details:**
   - Application version and build number
   - Operating system and version
   - Browser type and version (for web apps)
   - Device information (mobile apps)
   - Network configuration details
   - Database version and configuration

2. **User Context:**
   - User role and permissions
   - Account type and configuration
   - Historical user actions
   - Data set being used
   - Specific feature area usage

3. **System State:**
   - System load and performance
   - Concurrent user activity
   - Database state and data integrity
   - Integration service availability
   - Cache and session state

**Evidence Collection:**
- Screenshots of error conditions
- Screen recordings of reproduction steps
- Console logs and error messages
- Network traffic captures
- Database query results
- System performance metrics

### Step 3: Bug Report Creation Using Template
**Objective:** Create detailed bug report using standardized template

**Template Reference:** Use `bug-report-template.md` for complete structure

**Key Sections to Complete:**

1. **Bug Summary Section:**
   ```markdown
   Title: [Clear, concise description of the bug]
   Description: [Detailed description of what the bug is and its impact]
   Severity: [Critical/High/Medium/Low]
   Priority: [P1/P2/P3/P4]
   ```

2. **Environment Details:**
   - Application Version: [VERSION]
   - Operating System: [OS_VERSION]
   - Browser/Client: [BROWSER_VERSION]
   - Device: [DEVICE_TYPE]
   - Test Environment: [Dev/Stage/Prod]

3. **Reproduction Steps:**
   ```markdown
   Steps to Reproduce:
   1. [Specific step 1]
   2. [Specific step 2]
   3. [Specific step 3]
   4. [Specific step 4]
   ```

4. **Expected vs Actual Results:**
   ```markdown
   Expected Result: [What should happen]
   Actual Result: [What actually happens]
   ```

### Step 4: Technical Analysis and Classification
**Objective:** Provide technical analysis to help development team

**Technical Classification:**
1. **Bug Category:**
   - Functional defect
   - Performance issue
   - Security vulnerability
   - Usability problem
   - Data integrity issue
   - Integration failure

2. **Severity Assessment:**
   - **Critical:** System crash, data loss, security breach
   - **High:** Major functionality broken, significant business impact
   - **Medium:** Minor functionality affected, workaround available
   - **Low:** Cosmetic or minor inconvenience

3. **Priority Determination:**
   - **P1:** Must fix before release
   - **P2:** Should fix in current release
   - **P3:** Fix in future release
   - **P4:** Fix when resources available

**Technical Analysis:**
- Identify likely affected code modules
- Assess potential database impact
- Review integration touchpoints
- Evaluate security implications
- Consider performance ramifications

### Step 5: Business Impact and Risk Assessment
**Objective:** Assess business implications and risk factors

**Business Impact Analysis:**
1. **User Impact Assessment:**
   - Number of affected users
   - User workflow disruption level
   - Customer satisfaction impact
   - Revenue or business process impact
   - Regulatory or compliance implications

2. **Risk Evaluation:**
   - Data corruption or loss risk
   - Security vulnerability exposure
   - Performance degradation risk
   - System stability impact
   - Customer trust and reputation risk

3. **Workaround Analysis:**
   - Available workaround options
   - Workaround complexity and usability
   - Business process adjustments needed
   - Temporary solution viability
   - Communication requirements for users

### Step 6: Quality Assurance and Validation Information
**Objective:** Provide QA perspective and testing guidance

**QA Analysis:**
1. **Test Coverage Assessment:**
   - Was this scenario covered in test cases?
   - Why wasn't this caught during testing?
   - What test improvements are needed?
   - Should this be automated in future?
   - What regression tests are required?

2. **Verification Criteria:**
   ```markdown
   Definition of Done for Fix:
   - [ ] Bug is fixed in code
   - [ ] Unit tests pass
   - [ ] Integration tests pass
   - [ ] Manual verification completed
   - [ ] No new regressions introduced
   - [ ] Performance impact assessed
   ```

3. **Test Strategy for Fix:**
   - Specific test cases to verify fix
   - Regression test requirements
   - Performance testing needs
   - Security testing requirements
   - User acceptance testing approach

### Step 7: Communication and Stakeholder Management
**Objective:** Ensure appropriate communication and escalation

**Communication Strategy:**
1. **Stakeholder Notification:**
   - Identify stakeholders to notify
   - Determine communication urgency
   - Prepare executive summary for management
   - Plan user communication if needed
   - Set up regular status updates

2. **Escalation Path:**
   - Define escalation triggers
   - Identify escalation contacts
   - Prepare escalation documentation
   - Set response time expectations
   - Plan for customer communication

3. **Progress Tracking:**
   - Set up progress monitoring
   - Define status update frequency
   - Establish completion criteria
   - Plan verification activities
   - Schedule post-resolution review

### Step 8: Follow-up and Continuous Improvement
**Objective:** Ensure proper resolution and process improvement

**Follow-up Activities:**
1. **Resolution Verification:**
   - Test the implemented fix thoroughly
   - Verify no regressions introduced
   - Validate performance impact
   - Confirm business requirements met
   - Obtain stakeholder sign-off

2. **Process Improvement:**
   - Analyze why bug wasn't caught earlier
   - Identify test coverage gaps
   - Review development process issues
   - Plan preventive measures
   - Update testing procedures

3. **Knowledge Sharing:**
   - Document lessons learned
   - Share findings with team
   - Update test automation
   - Improve bug reporting process
   - Train team on prevention

## Deliverables

### Primary Deliverables
1. **Comprehensive Bug Report:** Using `bug-report-template.md`
2. **Supporting Evidence:** Screenshots, logs, and recordings
3. **Technical Analysis:** Root cause hypothesis and impact assessment
4. **Verification Plan:** Testing strategy for fix validation
5. **Communication Plan:** Stakeholder notification and update strategy

### Supporting Deliverables
1. **Reproduction Guide:** Detailed steps for developers
2. **Impact Assessment:** Business and technical impact analysis
3. **Workaround Documentation:** Temporary solution guidance
4. **Test Improvement Plan:** Coverage gap analysis and recommendations
5. **Lessons Learned:** Process improvement recommendations

## Tool Integration
- Use `problems` to identify related issues
- Use `testFailure` to understand test context
- Use `search` to find similar bugs
- Use `runTests` to validate reproduction steps
- Use bug tracking system APIs for automated reporting

## Quality Gates
- [ ] Bug successfully reproduced
- [ ] All required information collected
- [ ] Template sections completed accurately
- [ ] Evidence attached and documented
- [ ] Business impact assessed
- [ ] Technical analysis completed
- [ ] Stakeholders identified and notified
- [ ] Verification criteria defined
- [ ] Communication plan established
- [ ] Process improvement opportunities identified

## Success Metrics
- Bug report contains all necessary information for development
- Developer can reproduce issue from provided steps
- Fix time reduced due to comprehensive information
- No back-and-forth requests for additional details
- Stakeholder satisfaction with communication
- Process improvements implemented
- Defect resolution time meets SLA targets

## Next Steps After Bug Report Creation
1. Monitor bug progress and provide updates
2. Respond to developer questions promptly
3. Verify fix when implemented
4. Conduct regression testing
5. Update test automation as needed
6. Document lessons learned
7. Share knowledge with team
8. Plan process improvements