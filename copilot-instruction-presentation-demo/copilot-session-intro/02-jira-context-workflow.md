# JIRA-to-Copilot Context Workflow

**Problem:** Copilot needs context to give good suggestions, but it can't access JIRA, read Word docs, or parse PDFs directly.

**Solution:** Manual context engineering - bring JIRA content into your codebase where Copilot can see it.

---

## Folder Structure

```
your-project/
├── src/
├── AI-docs/                          # All AI context lives here
│   └── jira/                         # JIRA tasks
│       ├── IMS-345789/               # Ticket ID as folder name
│       │   ├── task.md               # Title, description, AC
│       │   ├── attachment-1.png      # Screenshot of Word doc page 1
│       │   ├── attachment-2.png      # Screenshot of Word doc page 2
│       │   └── api-spec-screenshot.png
│       └── IMS-345790/
│           ├── task.md
│           └── mockup.png
```

---

## Workflow Steps

### Step 1: Create Task Folder
```bash
mkdir -p AI-docs/jira/IMS-345789
```

### Step 2: Create task.md

```markdown
# IMS-345789: User Password Reset via Email

## Status
In Progress

## Description
As a user, I want to reset my password via email so that I can regain
access if I forget my credentials.

## Acceptance Criteria
- [ ] User can request password reset from login page
- [ ] System sends email with reset link within 30 seconds
- [ ] Reset link expires after 24 hours
- [ ] New password must meet complexity requirements (8+ chars, 1 upper, 1 number)
- [ ] Old password is invalidated immediately upon reset
- [ ] User receives confirmation email after successful reset

## Technical Notes
- API endpoint: POST /api/v1/auth/password-reset
- Email service: SendGrid integration
- Token storage: Redis with 24h TTL

## Test Considerations
- Happy path: valid email, valid token, valid new password
- Edge cases: expired token, invalid email format, password reuse
- Integration: email delivery, database update, token invalidation

## Attachments
See screenshots in this folder:
- attachment-1.png: Requirements document page 1
- attachment-2.png: Requirements document page 2
```

### Step 3: Handle Word/PDF Attachments

**Copilot limitation:** Cannot read .docx or .pdf files

**Workaround:**
1. Open the Word/PDF document
2. convert word/pdf pages by copy pasting text into new markdown file or tak e screenshots of relevant sections
3. Save as markdown text and screenshots in the ticket folder
4. Reference them in your Copilot Chat

**Pro tip:** For long documents, screenshot only the relevant sections. Name files descriptively:
- `requirements-page-1.md`
- `api-contract-table.jpeg`
- `validation-rules-mapping.jpeg`
- `markdown-summary.md`

### Step 4: Use Context in Copilot

Now Copilot can see everything:

```
@workspace Based on the JIRA task in AI-docs/jira/IMS-345789/task.md,
generate Serenity BDD test scenarios for the password reset feature.
Include the edge cases mentioned in the acceptance criteria.
```

Or reference images:
```
Look at AI-docs/jira/IMS-345789/requirements-screenshot.png
and generate the validation logic described in the table.
```

---

## Template: task.md

```markdown
# [TICKET-ID]: [Title]

## Status
[To Do | In Progress | In Review | Done]

## Description
[Copy from JIRA description field]

## Acceptance Criteria
- [ ] [AC 1]
- [ ] [AC 2]
- [ ] [AC 3]

## Technical Notes
[Any technical details, API specs, database changes]

## Test Considerations
[Initial thoughts on test scenarios]

## Attachments
[List screenshots/images in this folder]

## Questions/Blockers
[Any clarifications needed]
```

---

## Benefits

1. **Persistent context** - Task details live with your code
2. **Team sharing** - Others can see your AI context (commit to branch)
3. **Copilot visibility** - @workspace can reference these files
4. **Audit trail** - Know what context was used for AI-assisted code
5. **No MCP required** - Works with standard Copilot

---

## Tips

- **Keep task.md updated** as you learn more during development
- **Add test results** to the folder as you progress
- **Screenshot selectively** - only what Copilot needs to understand
- **Use consistent naming** so @workspace searches work well
- **Clean up** after ticket is done (or archive to a `completed/` folder)
