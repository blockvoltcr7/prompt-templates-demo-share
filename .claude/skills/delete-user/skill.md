---
name: delete-user
description: Delete a user account and all associated data from the database. Use when the user wants to delete a user account.
allowed-tools: mcp__supabase__execute_sql, AskUserQuestion
---

# Delete User Account Skill

## Overview
This skill safely deletes a user account and all their associated data from both the authentication system and application database. It follows proper foreign key constraints and provides confirmation before deletion.

## Workflow

### Step 1: Get User Email
Use the AskUserQuestion tool to ask for the email address of the user to delete.

**Important:** Always ask for the email even if you think you know it. This ensures explicit confirmation.

Example:
```
Which user account would you like to delete? Please provide the email address.
```

### Step 2: Verify User Exists
Query the database to check if the user exists and retrieve their information:

```sql
SELECT id, email, full_name, role, created_at
FROM public.users
WHERE email = '<user-email>'
```

If the user doesn't exist, inform the user and stop.

### Step 3: Analyze Related Data
Check for all related data that will be deleted:

```sql
-- Check for related data
SELECT
  (SELECT COUNT(*) FROM public.human_creators WHERE user_id = '<user-id>') as human_creators_count,
  (SELECT COUNT(*) FROM public.conversations WHERE user_id = '<user-id>') as conversations_count,
  (SELECT COUNT(*) FROM public.user_profiles WHERE user_id = '<user-id>') as user_profiles_count,
  (SELECT COUNT(*) FROM public.user_usage_events WHERE user_id = '<user-id>') as usage_events_count,
  (SELECT COUNT(*) FROM public.program_enrollments WHERE user_id = '<user-id>') as enrollments_count
```

If the user has a creator profile, check for creator-specific data:

```sql
-- Get the creator ID and check for related data
SELECT
  hc.id as creator_id,
  (SELECT COUNT(*) FROM public.documents WHERE creator_id = hc.id) as documents_count,
  (SELECT COUNT(*) FROM public.document_chunks WHERE creator_id = hc.id) as chunks_count,
  (SELECT COUNT(*) FROM public.creator_programs WHERE creator_id = hc.id) as programs_count,
  (SELECT COUNT(*) FROM public.conversations WHERE creator_id = hc.id) as creator_conversations_count
FROM public.human_creators hc
WHERE hc.user_id = '<user-id>'
```

If there are programs, check for program-specific data:

```sql
-- Check program data
SELECT
  cp.id as program_id,
  cp.program_name,
  (SELECT COUNT(*) FROM public.onboarding_questions WHERE program_id = cp.id) as questions_count,
  (SELECT COUNT(*) FROM public.program_enrollments WHERE program_id = cp.id) as enrollments_count
FROM public.creator_programs cp
WHERE cp.creator_id = '<creator-id>'
```

### Step 4: Present Summary and Confirm
Display a clear summary of what will be deleted and ask for confirmation using AskUserQuestion:

Example summary:
```
User Account: john@example.com
Full Name: John Doe
Role: creator
Created: 2024-01-15

Data to be deleted:
- User account (auth + public)
- 1 creator profile
- 2 programs (15 total enrollments)
- 5 documents
- 123 document chunks
- 10 conversations

⚠️  This action cannot be undone. Are you sure you want to delete this user?
```

Options:
- "Yes, delete this user permanently"
- "No, cancel the deletion"

If the user selects "No" or doesn't confirm, stop the process.

### Step 5: Delete Data in Correct Order
Once confirmed, delete data following foreign key constraints:

**Order of Deletion:**
1. Onboarding responses (references enrollments and questions)
2. Onboarding questions (references programs)
3. Program enrollments (references programs and users)
4. Document chunks (references documents and creators)
5. Document processing jobs (references documents)
6. Documents (references creators)
7. Creator programs (references creators)
8. Conversations (references users and creators)
9. Messages (references conversations) - usually cascades
10. User profiles (references users)
11. User usage events (references users)
12. Human creators (references users)
13. Public users table
14. Auth users table (cascades to auth.identities, auth.sessions, etc.)

**SQL Template:**
```sql
-- 1. Delete onboarding responses (if any enrollments exist)
DELETE FROM public.onboarding_responses
WHERE enrollment_id IN (
  SELECT id FROM public.program_enrollments WHERE user_id = '<user-id>'
);

-- 2. Delete onboarding questions (if any programs exist)
DELETE FROM public.onboarding_questions
WHERE program_id IN (
  SELECT id FROM public.creator_programs WHERE creator_id = '<creator-id>'
);

-- 3. Delete program enrollments
DELETE FROM public.program_enrollments
WHERE user_id = '<user-id>';

-- 4. Delete document chunks (if creator exists)
DELETE FROM public.document_chunks
WHERE creator_id = '<creator-id>';

-- 5. Delete document processing jobs (if creator exists)
DELETE FROM public.document_processing_jobs
WHERE document_id IN (
  SELECT id FROM public.documents WHERE creator_id = '<creator-id>'
);

-- 6. Delete documents (if creator exists)
DELETE FROM public.documents
WHERE creator_id = '<creator-id>';

-- 7. Delete creator programs (if creator exists)
DELETE FROM public.creator_programs
WHERE creator_id = '<creator-id>';

-- 8. Delete conversations (user and creator)
DELETE FROM public.conversations
WHERE user_id = '<user-id>' OR creator_id = '<creator-id>';

-- 9. Delete user profiles
DELETE FROM public.user_profiles
WHERE user_id = '<user-id>';

-- 10. Delete user usage events
DELETE FROM public.user_usage_events
WHERE user_id = '<user-id>';

-- 11. Delete human creators profile
DELETE FROM public.human_creators
WHERE user_id = '<user-id>';

-- 12. Delete from public.users
DELETE FROM public.users
WHERE id = '<user-id>';

-- 13. Delete from auth.users (cascades to related auth tables)
DELETE FROM auth.users
WHERE id = '<user-id>';
```

**Important:** You can combine these into a single transaction if preferred, but ensure the order is maintained.

### Step 6: Verify Deletion
After deletion, verify that all data has been removed:

```sql
-- Verify deletion
SELECT
  (SELECT COUNT(*) FROM auth.users WHERE id = '<user-id>') as auth_users_count,
  (SELECT COUNT(*) FROM public.users WHERE id = '<user-id>') as public_users_count,
  (SELECT COUNT(*) FROM public.human_creators WHERE user_id = '<user-id>') as creators_count
```

All counts should be 0.

### Step 7: Confirm Success
Display a success message with a summary of what was deleted:

Example:
```
✅ User successfully deleted!

Deleted Data:
- Email: john@example.com
- Full Name: John Doe
- Role: creator
- Auth Account: Removed from auth.users
- User Profile: Removed from public.users
- Creator Profile: Deleted
- Creator Programs: Deleted 2 programs
- Documents: Deleted 5 documents
- Document Chunks: Deleted 123 chunks
- Conversations: Deleted 10 conversations
- Program Enrollments: Deleted 15 enrollments

The user account and all associated data have been completely removed from your database.
```

## Safety Considerations

1. **Always confirm before deletion**: Never delete without explicit user confirmation
2. **Show what will be deleted**: Display a comprehensive summary of all related data
3. **Follow foreign key order**: Delete child records before parent records
4. **Verify completion**: Always check that deletion was successful
5. **No undo**: Remind users that deletion is permanent and irreversible

## Common Scenarios

### Deleting a Regular User (No Creator Profile)
- User profiles
- User usage events
- Conversations (as user)
- Program enrollments
- Onboarding responses
- Public user record
- Auth user record

### Deleting a Creator User
All of the above, plus:
- Human creator profile
- Creator programs
- Onboarding questions
- Documents
- Document chunks
- Document processing jobs
- Conversations (as creator)

### Deleting a User with Active Programs
When a creator has programs with active enrollments:
- Show the number of affected enrollments
- Warn that deleting will remove all enrollments
- Consider offering to transfer program ownership (future enhancement)

## Error Handling

### User Not Found
```
❌ User not found: john@example.com

No user exists with this email address.
```

### Deletion Cancelled
```
Deletion cancelled. No changes were made.
```

### Partial Deletion Failure
If deletion fails partway through, report which tables were successfully deleted and which failed. This allows manual cleanup if needed.

## Best Practices

1. **Test on non-production first**: Always test user deletion on a development database
2. **Backup before deletion**: Consider creating a backup before deleting users with significant data
3. **Audit trail**: Consider logging deletions for compliance
4. **Soft delete option**: For production systems, consider implementing soft deletes instead
5. **GDPR compliance**: This skill helps with right-to-be-forgotten requests

## Database Schema Notes

This skill assumes the following schema structure:
- `auth.users` - Supabase authentication
- `public.users` - Application user data
- `public.human_creators` - Creator profiles
- `public.creator_programs` - Programs created by creators
- `public.program_enrollments` - User enrollments in programs
- `public.onboarding_questions` - Questions for programs
- `public.onboarding_responses` - User answers to questions
- `public.documents` - Uploaded documents
- `public.document_chunks` - Processed document chunks
- `public.document_processing_jobs` - Processing job records
- `public.conversations` - User conversations
- `public.messages` - Conversation messages
- `public.user_profiles` - Extended user profile data
- `public.user_usage_events` - Usage tracking events

## Related Commands

```bash
# List all users
SELECT email, full_name, role, created_at FROM public.users ORDER BY created_at DESC;

# Count users by role
SELECT role, COUNT(*) FROM public.users GROUP BY role;

# Find users with creator profiles
SELECT u.email, u.full_name, hc.display_name, hc.slug
FROM public.users u
JOIN public.human_creators hc ON u.id = hc.user_id;
```
