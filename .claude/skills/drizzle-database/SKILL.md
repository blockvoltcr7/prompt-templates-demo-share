---
name: drizzle-database
description: Work with Drizzle ORM, PostgreSQL schema, database migrations, and Supabase. Use when working with database schema, migrations, SQL queries, pgvector, RLS policies, or database operations.
allowed-tools: Read, Grep, Glob, Bash(npm run db:*)
---

# Drizzle ORM Database Skill

## Overview
OS AI uses Drizzle ORM for type-safe database operations with PostgreSQL (Supabase), including advanced features like pgvector for embeddings.

## Database Architecture

### Core Tables

**Users & Authentication**
- `users` - Base user accounts (Supabase Auth sync)
- `user_profiles` - Extended user information (bio, preferences)
- `human_coaches` - Coach profiles and settings

**Documents & RAG**
- `documents` - Document metadata and GCS storage info
- `document_chunks` - Text chunks with pgvector embeddings (768-dim)
- `document_processing_jobs` - Async processing pipeline status

**Conversations & AI**
- `conversations` - Chat sessions between users and AI
- `messages` - Individual messages with role/content
- `ai_models` - Available AI models configuration
- `usage_events` - Token usage and billing tracking

**Products & Payments**
- `products` - Coach programs and offerings
- `price_tiers` - Stripe pricing tiers
- `subscriptions` - Active user subscriptions

**Future: Multi-Agent System**
- `accountability_states` - User behavioral state machine
- `daily_checkins` - Daily check-in records
- `weekly_reviews` - Weekly review sessions
- `semantic_memories` - Mem0 memory storage

## Code Locations

### Schema Definitions
```
apps/web/lib/drizzle/schema/
├── users.ts - User and coach tables
├── documents.ts - Document management
├── document_chunks.ts - Vector embeddings
├── conversations.ts - Chat sessions
├── messages.ts - Chat messages
├── ai_models.ts - AI model configs
├── products.ts - Programs and pricing
└── accountability_states.ts - (future) Agent states
```

### Migration Files
```
apps/web/drizzle/migrations/
├── 0000_*.sql - Initial schema
├── 0001_*.sql - Add documents table
├── ...
└── 0043_*.sql - Latest migration
```

### Drizzle Configuration
```typescript
// apps/web/drizzle.config.ts - Drizzle configuration
// apps/web/lib/drizzle/db.ts - Database client setup
```

## Common Tasks

### Task 1: Creating a New Migration

**Step 1**: Update schema file
```typescript
// apps/web/lib/drizzle/schema/your_table.ts
export const yourTable = pgTable('your_table', {
  id: uuid('id').defaultRandom().primaryKey(),
  coachId: uuid('coach_id').references(() => humanCoaches.id).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});
```

**Step 2**: Generate migration
```bash
npm run db:generate
# This creates a new migration file in drizzle/migrations/
```

**Step 3**: Review generated SQL
```bash
# Check the latest migration file
cat apps/web/drizzle/migrations/00XX_*.sql
```

**Step 4**: Apply migration
```bash
# Local development
npm run db:migrate

# Staging
npm run db:migrate:staging

# Production (use with caution!)
npm run db:migrate:prod
```

### Task 2: Rolling Back a Migration

```bash
# Rollback the last migration
npm run db:rollback

# Check status
npm run db:status
```

**Important**: Test rollback locally before applying to staging/prod!

### Task 3: Adding pgvector Support

**Step 1**: Install extension in migration
```sql
-- In migration file
CREATE EXTENSION IF NOT EXISTS vector;
```

**Step 2**: Add vector column
```typescript
import { pgTable, uuid, text, vector } from 'drizzle-orm/pg-core';

export const documentChunks = pgTable('document_chunks', {
  id: uuid('id').defaultRandom().primaryKey(),
  embedding: vector('embedding', { dimensions: 768 }),
  content: text('content').notNull(),
});
```

**Step 3**: Create HNSW index
```sql
-- In migration file
CREATE INDEX document_chunks_embedding_idx
ON document_chunks
USING hnsw (embedding vector_cosine_ops);
```

### Task 4: Adding RLS Policies

**Example: Coach-scoped documents**
```sql
-- Enable RLS
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- Policy: Coaches can only see their own documents
CREATE POLICY coach_documents_policy ON documents
FOR ALL
USING (coach_id = auth.uid());

-- Policy: Service role has full access
CREATE POLICY service_role_policy ON documents
FOR ALL
USING (auth.role() = 'service_role');
```

### Task 5: Seeding Initial Data

**Step 1**: Create seed script
```typescript
// apps/web/scripts/seed-data.ts
import { db } from '../lib/drizzle/db';
import { aiModels } from '../lib/drizzle/schema/ai_models';

await db.insert(aiModels).values([
  { name: 'GPT-4', provider: 'openai', isActive: true },
]);
```

**Step 2**: Run seed script
```bash
npm run db:seed
# Or specific seeds
npm run db:seed:coaches
npm run db:seed:free-models
```

## Drizzle Query Examples

### Basic CRUD Operations

**Insert**
```typescript
import { db } from '@/lib/drizzle/db';
import { documents } from '@/lib/drizzle/schema/documents';

const newDoc = await db.insert(documents).values({
  coachId: coachId,
  title: 'Program Guide',
  gcsUri: 'gs://bucket/file.pdf',
}).returning();
```

**Select**
```typescript
const docs = await db
  .select()
  .from(documents)
  .where(eq(documents.coachId, coachId));
```

**Update**
```typescript
await db
  .update(documents)
  .set({ status: 'processed' })
  .where(eq(documents.id, docId));
```

**Delete**
```typescript
await db
  .delete(documents)
  .where(eq(documents.id, docId));
```

### Advanced Queries

**Join with Relations**
```typescript
const chunks = await db
  .select({
    chunk: documentChunks,
    document: documents,
  })
  .from(documentChunks)
  .innerJoin(documents, eq(documentChunks.documentId, documents.id))
  .where(eq(documents.coachId, coachId));
```

**Vector Similarity Search**
```typescript
import { sql } from 'drizzle-orm';

const similarChunks = await db
  .select()
  .from(documentChunks)
  .where(sql`coach_id = ${coachId}`)
  .orderBy(sql`embedding <=> ${queryEmbedding}`)
  .limit(5);
```

**Transactions**
```typescript
await db.transaction(async (tx) => {
  const doc = await tx.insert(documents).values({...}).returning();
  await tx.insert(documentChunks).values({
    documentId: doc[0].id,
    content: 'chunk text',
  });
});
```

## Best Practices

### Schema Design
- **Use UUIDs**: For primary keys (better for distributed systems)
- **Add timestamps**: `createdAt` and `updatedAt` on all tables
- **Soft deletes**: Use `deletedAt` instead of hard deletes
- **Coach scoping**: Always include `coach_id` for multi-tenancy
- **Indexes**: Add indexes on foreign keys and frequently queried columns

### Migration Safety
- **Test locally first**: ALWAYS test migrations on local DB
- **Review SQL**: Check generated migration SQL before applying
- **Backup first**: Take database snapshot before production migrations
- **Rollback plan**: Test rollback before applying to production
- **Off-peak hours**: Run production migrations during low traffic

### Performance Optimization
- **Use indexes**: Especially for `WHERE` clauses and joins
- **Batch operations**: Use `db.insert().values([...])` for multiple rows
- **Limit results**: Always use `.limit()` for large tables
- **Select specific columns**: Avoid `SELECT *` when possible
- **Use transactions**: For multi-table operations requiring consistency

### Security
- **RLS policies**: Enable Row Level Security on all user-facing tables
- **Coach isolation**: Filter ALL queries by `coach_id`
- **Input validation**: Validate all user inputs before DB operations
- **Parameterized queries**: Drizzle handles this automatically
- **Service role**: Use sparingly, prefer user-scoped queries

## Common npm Scripts

```bash
# Development
npm run db:generate      # Generate migrations from schema changes
npm run db:migrate       # Apply migrations to local DB
npm run db:rollback      # Rollback last migration
npm run db:status        # Check migration status

# Seeding
npm run db:seed          # Run all seed scripts
npm run db:seed:coaches  # Seed training coaches
npm run db:seed:free-models  # Seed free AI models

# Environment-specific
npm run db:migrate:staging   # Apply to staging database
npm run db:migrate:prod      # Apply to production database

# Utilities
npm run db:push          # Push schema without migrations (dev only)
npm run db:studio        # Open Drizzle Studio GUI
```

## Troubleshooting

### Issue: Migration fails with constraint error
**Solution**: Check foreign key references, ensure parent records exist, review constraint logic

### Issue: "relation does not exist"
**Solution**: Run `npm run db:migrate`, check migration status, verify table name spelling

### Issue: Slow queries
**Solution**: Use `EXPLAIN ANALYZE` to profile, add indexes, optimize joins, reduce result size

### Issue: pgvector errors
**Solution**: Ensure vector extension is installed, check dimensions match (768), verify HNSW index exists

### Issue: RLS blocking queries
**Solution**: Check RLS policies, verify `coach_id` filter, use service role for admin operations

## Reference Documentation

- Drizzle ORM Docs: https://orm.drizzle.team/
- PostgreSQL Docs: https://www.postgresql.org/docs/
- Supabase Docs: https://supabase.com/docs
- pgvector: https://github.com/pgvector/pgvector

## Database Schema Diagram

See `ai_docs/diagrams/` for visual database schema representations.

## Security Considerations

- **Multi-tenancy**: ALWAYS filter by `coach_id` in queries
- **RLS enforcement**: Enable on all tables with user data
- **Audit logging**: Track all data modifications
- **Encryption**: Sensitive fields encrypted at rest (Supabase default)
- **Connection pooling**: Use Supabase connection pooler for scalability
