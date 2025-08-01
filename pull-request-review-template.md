# Pull Request Review Prompt Template

## Context
You are reviewing a pull request for the following user story/task:

**[USER_STORY_ID]**: [USER_STORY_TITLE]

### Requirements/Acceptance Criteria:
```
[USER_STORY_DESCRIPTION]
[ACCEPTANCE_CRITERIA]
[TECHNICAL_REQUIREMENTS]
```

### Pull Request Information:
- **PR Title**: [PR_TITLE]
- **PR Number**: [PR_NUMBER]
- **Author**: [PR_AUTHOR]
- **Target Branch**: [TARGET_BRANCH]

## Modified Files
The following files have been changed in this pull request:

1. [FILE_PATH_1] - [LINES_ADDED] additions, [LINES_REMOVED] deletions
2. [FILE_PATH_2] - [LINES_ADDED] additions, [LINES_REMOVED] deletions
3. [FILE_PATH_3] - [LINES_ADDED] additions, [LINES_REMOVED] deletions
[... continue for all files]

## Code Changes
```
[INSERT_DIFF_OR_CODE_CHANGES_HERE]
```

## Review Request
Please perform a comprehensive review of this pull request and provide:

### 1. Alignment Check
- Does the implementation satisfy all acceptance criteria from the user story?
- Are there any missing requirements or functionality?
- Does the code follow the intended technical approach?

### 2. Code Quality Assessment
- Are there any code smells or anti-patterns?
- Is the code maintainable and readable?
- Are naming conventions followed consistently?
- Is there appropriate error handling?

### 3. Risk Analysis
- **Security Risks**: Identify any potential security vulnerabilities (e.g., SQL injection, XSS, authentication issues)
- **Performance Risks**: Flag any performance concerns (e.g., N+1 queries, inefficient algorithms, memory leaks)
- **Breaking Changes**: Identify any changes that might break existing functionality
- **Data Integrity**: Check for potential data corruption or loss scenarios

### 4. Best Practices Review
- Are SOLID principles followed?
- Is there adequate test coverage?
- Are there any missing edge cases?
- Is the code DRY (Don't Repeat Yourself)?

### 5. Specific Concerns
- Check for hardcoded values that should be configurable
- Verify proper logging and monitoring
- Ensure proper documentation/comments where needed
- Check for proper database transaction handling (if applicable)

### 6. Suggestions for Improvement
Provide specific, actionable suggestions to improve the code, including:
- Code refactoring opportunities
- Performance optimizations
- Better design patterns that could be applied
- Additional tests that should be added

### 7. Priority Issues
Categorize findings as:
- **🔴 Blockers**: Must be fixed before merging
- **🟡 Important**: Should be addressed but not blocking
- **🟢 Nice-to-have**: Suggestions for future improvements

## Additional Context (if applicable)
- Related PRs: [RELATED_PR_NUMBERS]
- Dependencies: [EXTERNAL_DEPENDENCIES]
- Database changes: [YES/NO - DETAILS]
- API changes: [YES/NO - DETAILS]

---

## Example Usage:

```
You are reviewing a pull request for the following user story/task:

**JIRA-1234**: Implement user authentication with OAuth2

### Requirements/Acceptance Criteria:
```
As a user, I want to log in using my Google account
So that I don't need to create another password

Technical Requirements:
- Implement OAuth2 flow with Google
- Store user tokens securely
- Handle token refresh automatically
- Add logout functionality
```

### Pull Request Information:
- **PR Title**: feat: Add Google OAuth2 authentication
- **PR Number**: #456
- **Author**: john.doe
- **Target Branch**: main

## Modified Files
The following files have been changed in this pull request:

1. src/auth/oauth.service.ts - 150 additions, 0 deletions
2. src/auth/auth.controller.ts - 45 additions, 10 deletions
3. src/config/oauth.config.ts - 25 additions, 0 deletions
4. src/models/user.model.ts - 15 additions, 5 deletions
5. tests/auth/oauth.test.ts - 200 additions, 0 deletions

[Continue with actual code changes...]
```
