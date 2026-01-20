---
name: rag-document-processing
description: Work with RAG document processing pipeline, embeddings, vector search, and pgvector. Use when working with documents, embeddings, chunking, similarity search, HNSW indexes, or the document processing pipeline.
---

# RAG Document Processing Skill

## Overview
OS AI uses a sophisticated RAG (Retrieval Augmented Generation) pipeline for processing coach documents and enabling AI-powered Q&A.

## Architecture

### Document Processing Pipeline
```
1. Coach uploads file → Signed GCS URL
2. File uploaded to GCS bucket (os-ai-coach-documents)
3. EventArc triggers Cloud Function
4. Docling extracts text/content (Python)
5. Text chunked with context overlap
6. Embeddings generated (text-embedding-004, 768-dim)
7. Chunks stored in PostgreSQL with vectors
8. HNSW index enables fast similarity search (<50ms)
```

### Key Components

**Database Tables**:
- `documents` - Document metadata and GCS storage info
- `document_chunks` - Text chunks with vector embeddings (pgvector)
- `document_processing_jobs` - Processing pipeline status tracking

**Embedding Strategy**:
- **Text**: Google `text-embedding-004` (768 dimensions)
- **Images/Video/Audio**: Multimodal embeddings
- **Scope**: Coach-isolated (multi-tenancy via RLS)

**Vector Search**:
- PostgreSQL with pgvector extension
- HNSW indexes for fast similarity search
- Configurable similarity thresholds
- Coach-scoped queries (multi-tenancy)

## Code Locations

### Database Schema
```typescript
// apps/web/lib/drizzle/schema/documents.ts
// apps/web/lib/drizzle/schema/document_chunks.ts
// apps/web/lib/drizzle/schema/document_processing_jobs.ts
```

### Embeddings
```typescript
// apps/web/lib/embeddings/text-embeddings.ts
// apps/web/lib/embeddings/multimodal-embeddings.ts
```

### Server Actions
```typescript
// apps/web/app/actions/document-actions.ts - Document CRUD
// apps/web/app/actions/rag-actions.ts - Vector search
// apps/web/app/actions/coach-rag-chat.ts - Chat with documents
```

### API Routes
```typescript
// apps/web/app/api/documents/ - Document upload endpoints
// apps/web/app/api/chat/ - Streaming chat endpoint
```

## Common Tasks

### Task 1: Adding New Document Types
1. Update `documents` table with new `document_type` enum
2. Add processing logic in Cloud Function
3. Update Docling extraction for new format
4. Test chunking strategy for new format

### Task 2: Optimizing Vector Search
1. Check HNSW index configuration
2. Adjust similarity thresholds based on use case
3. Test query performance with `EXPLAIN ANALYZE`
4. Consider adding metadata filters

### Task 3: Debugging Document Processing
1. Check `document_processing_jobs` table for status
2. Review Cloud Function logs in GCP
3. Verify GCS bucket permissions
4. Test embeddings generation locally

## Best Practices

### Chunking Strategy
- **Chunk size**: 500-1000 tokens (configurable)
- **Overlap**: 10-20% for context preservation
- **Metadata**: Preserve document source, page numbers, coach_id

### Embedding Generation
- **Batch processing**: Process embeddings in batches of 100
- **Error handling**: Retry failed embeddings with exponential backoff
- **Cost optimization**: Cache embeddings for unchanged chunks

### Vector Search
- **Similarity threshold**: 0.7-0.8 for high relevance
- **Result limit**: Top 5-10 chunks for context
- **Multi-tenancy**: ALWAYS filter by `coach_id` in queries

## Reference Documentation

See [`ai_docs/refs/`](../../../ai_docs/refs/) for detailed references:
- `docling/` - Document processing with Docling
- `gcp/ai-platform/` - Google AI Platform embeddings
- `multi-agent-architecture/07-rag-knowledge-search-architecture.md`

## Troubleshooting

### Issue: Embeddings not generating
**Solution**: Check Google AI Platform API key, verify network connectivity

### Issue: Slow similarity search
**Solution**: Ensure HNSW index exists, check query filters, consider reducing dimensions

### Issue: Processing pipeline stuck
**Solution**: Check Cloud Function logs, verify EventArc trigger, restart processing job

## Security Considerations

- **Data isolation**: All queries MUST filter by `coach_id`
- **RLS policies**: Enforce coach-scoped access at database level
- **Signed URLs**: Use time-limited signed URLs for GCS uploads
- **API key encryption**: Store Google AI Platform keys encrypted at rest
