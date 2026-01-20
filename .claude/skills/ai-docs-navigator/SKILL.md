---
name: ai-docs-navigator
description: Navigate and reference OS AI's comprehensive AI documentation in ai_docs/refs/. Use when looking for implementation examples, architecture guides, API references, or technical documentation for ADK, Cloudflare, GCP, Docling, GraphRAG, Mem0, or Trigger.dev.
allowed-tools: Read, Grep, Glob
---

# AI Documentation Navigator Skill

## Overview
OS AI maintains extensive reference documentation in `ai_docs/refs/` covering all major technologies and architectures used in the platform.

## Documentation Structure

```
ai_docs/refs/
├── adk-docs/                    # Google Agent Development Kit
│   ├── agent-starter-pack/      # Quick start guides
│   └── tutorials-and-examples/  # Implementation examples
│
├── cloudflare/                  # Cloudflare Workers and AI
│   ├── code-examples/           # Worker code samples
│   ├── workers/                 # Workers documentation
│   ├── workers-ai/              # AI inference on Workers
│   ├── mcp-servers/             # MCP server integration
│   └── resources/               # API references
│
├── docling/                     # Document processing
│   └── [implementation guides]
│
├── gcp/                         # Google Cloud Platform
│   ├── code-examples/           # GCS, Cloud Run examples
│   ├── cloud-scheduler/         # Scheduled jobs
│   ├── cloud-storage/           # GCS configuration
│   ├── ai-platform/             # Embeddings and AI
│   ├── gcp-knowledge/           # General GCP guides
│   └── resources/               # Official docs
│
├── graphrag/                    # Graph-based RAG
│   └── [architecture guides]
│
├── mem0/                        # Semantic memory
│   └── [memory architecture]
│
├── multi-agent-architecture/    # Core agent system
│   ├── 00-index.md              # Documentation index
│   ├── 01-architecture-overview.md
│   ├── 02-agent-specifications.md
│   ├── 03-state-machine.md
│   ├── 04-data-models.md
│   ├── 05-critical-update-ghl-webhook-flow.md
│   ├── 06-memory-architecture-mem0.md
│   └── 07-rag-knowledge-search-architecture.md
│
└── trigger-dev/                 # Background job processing
    ├── code-examples/           # Trigger.dev examples
    └── resources/               # API documentation
```

## Key Documentation by Use Case

### Working with Agents (Google ADK)
**Start here**: `ai_docs/refs/multi-agent-architecture/00-index.md`

**Essential files**:
1. `01-architecture-overview.md` - High-level system design
2. `02-agent-specifications.md` - 6 agent behaviors (Onboarding, Daily Check-in, Recovery, Weekly Review, Ascension, Support)
3. `03-state-machine.md` - 5-state behavioral tracking (ACTIVE, SLIPPING, RECOVERING, CHURNED, COMPLETED)
4. `04-data-models.md` - Database schema for agent system

**Implementation guides**:
- `adk-docs/agent-starter-pack/` - Quick start examples
- `adk-docs/tutorials-and-examples/` - Full implementations

**When to use**:
- Building or modifying agent behaviors
- Understanding state transitions
- Implementing agent workflows
- Debugging agent responses

### Working with RAG (Document Search)
**Start here**: `ai_docs/refs/multi-agent-architecture/07-rag-knowledge-search-architecture.md`

**Related files**:
- `docling/` - Document processing and extraction
- `gcp/ai-platform/` - Embedding generation (text-embedding-004)
- `graphrag/` - Graph-based retrieval augmentation

**When to use**:
- Implementing document search
- Optimizing retrieval quality
- Adding new document types
- Debugging search relevance

### Working with Memory (Mem0)
**Start here**: `ai_docs/refs/multi-agent-architecture/06-memory-architecture-mem0.md`

**Related files**:
- `mem0/` - Semantic memory implementation guides

**When to use**:
- Implementing user memory
- Storing conversation context
- Retrieving past interactions
- Building personalized experiences

### Working with WhatsApp Integration
**Start here**: `ai_docs/refs/multi-agent-architecture/05-critical-update-ghl-webhook-flow.md`

**Key concepts**:
- GoHighLevel (GHL) webhook routing
- Multi-coach/multi-user architecture
- Bi-directional messaging
- <3s response latency requirements

**When to use**:
- Setting up webhook endpoints
- Routing messages to agents
- Debugging message delivery
- Implementing scheduled messages

### Working with Google Cloud Platform
**Start here**: `ai_docs/refs/gcp/gcp-knowledge/`

**By service**:
- **Cloud Storage**: `gcp/cloud-storage/` - GCS bucket setup, signed URLs, CORS
- **Cloud Scheduler**: `gcp/cloud-scheduler/` - Scheduled agent runs
- **AI Platform**: `gcp/ai-platform/` - Embeddings, multimodal processing
- **Code Examples**: `gcp/code-examples/` - Complete implementations

**When to use**:
- Deploying to GCP
- Configuring GCS buckets
- Setting up scheduled jobs
- Generating embeddings

### Working with Cloudflare (Alternative Deployment)
**Start here**: `ai_docs/refs/cloudflare/resources/`

**By feature**:
- **Workers**: `cloudflare/workers/` - Serverless functions
- **Workers AI**: `cloudflare/workers-ai/` - AI inference at edge
- **MCP Servers**: `cloudflare/mcp-servers/` - MCP integration
- **Code Examples**: `cloudflare/code-examples/` - Implementation samples

**When to use**:
- Deploying to edge locations
- Running AI inference on Cloudflare
- Building serverless APIs
- Implementing MCP servers

### Working with Background Jobs (Trigger.dev)
**Start here**: `ai_docs/refs/trigger-dev/resources/`

**Files**:
- `trigger-dev/code-examples/` - Job implementation examples
- `trigger-dev/resources/` - API references

**When to use**:
- Implementing long-running tasks
- Scheduling recurring jobs
- Processing async workflows
- Debugging job execution

## Quick Reference Commands

### Find Specific Topics

**Search for ADK agent examples**
```bash
grep -r "agent" ai_docs/refs/adk-docs/
```

**Find all embedding-related docs**
```bash
grep -r "embedding" ai_docs/refs/gcp/ai-platform/
```

**Locate state machine documentation**
```bash
cat ai_docs/refs/multi-agent-architecture/03-state-machine.md
```

**Find Cloudflare Worker examples**
```bash
ls ai_docs/refs/cloudflare/code-examples/
```

### Navigation Tips

**Start with the index**
```bash
cat ai_docs/refs/multi-agent-architecture/00-index.md
```

**Browse by technology**
```bash
ls ai_docs/refs/
# Then cd into specific technology folder
```

**Search across all docs**
```bash
grep -r "your search term" ai_docs/refs/
```

## Common Documentation Patterns

### Architecture Documents
- **Overview**: High-level system design
- **Specifications**: Detailed component behaviors
- **Data Models**: Database schema and relationships
- **Workflows**: Step-by-step process flows

### Code Examples
- **Minimal examples**: Quick start snippets
- **Complete implementations**: Full working code
- **Best practices**: Recommended patterns
- **Anti-patterns**: Common mistakes to avoid

### Reference Materials
- **API documentation**: Function signatures and parameters
- **Configuration**: Environment variables and settings
- **Troubleshooting**: Common issues and solutions
- **Performance**: Optimization techniques

## Using Documentation Effectively

### For New Features
1. Read architecture overview first
2. Review relevant specifications
3. Check code examples for patterns
4. Implement with reference to best practices
5. Test against data models and workflows

### For Debugging
1. Check troubleshooting sections first
2. Review relevant specifications
3. Compare implementation to code examples
4. Verify configuration against reference docs
5. Check logs and error patterns

### For Optimization
1. Review performance sections
2. Study best practices
3. Compare to reference implementations
4. Profile current implementation
5. Iterate with documentation guidance

## Documentation Maintenance

### When to Update Documentation
- Adding new agent behaviors
- Modifying state machine logic
- Changing data models
- Adding new integrations
- Discovering new best practices

### Documentation Standards
- **Clear titles**: Descriptive and specific
- **Code examples**: Working, tested code
- **Architecture diagrams**: Visual representations
- **Cross-references**: Link related documents
- **Version info**: Track changes and updates

## Integration with Skills

This navigator skill complements other skills by providing quick access to reference materials:

- **RAG Document Processing Skill** → References `docling/`, `gcp/ai-platform/`
- **Google ADK Agents Skill** → References `multi-agent-architecture/`, `adk-docs/`
- **GCP Deployment Skill** → References `gcp/` all subdirectories
- **Drizzle Database Skill** → References `multi-agent-architecture/04-data-models.md`

## Quick Start Guide

### First Time Using AI Docs

**Step 1**: Read the main README
```bash
cat ai_docs/refs/README.md
```

**Step 2**: Explore multi-agent architecture
```bash
cat ai_docs/refs/multi-agent-architecture/00-index.md
```

**Step 3**: Review your technology stack
```bash
# For GCP
ls ai_docs/refs/gcp/

# For Cloudflare
ls ai_docs/refs/cloudflare/

# For ADK
ls ai_docs/refs/adk-docs/
```

**Step 4**: Find relevant code examples
```bash
# GCP examples
ls ai_docs/refs/gcp/code-examples/

# Cloudflare examples
ls ai_docs/refs/cloudflare/code-examples/
```

## Troubleshooting

### Can't find specific documentation
**Solution**: Use grep to search across all docs, check related technology folders, review index files

### Documentation outdated
**Solution**: Check git history for recent changes, cross-reference with code implementation, update docs

### Need example for specific use case
**Solution**: Check `code-examples/` folders, review tutorials, combine patterns from multiple examples

## Best Practices

### Reading Documentation
- Start with overview/index files
- Follow breadcrumb trails (cross-references)
- Read specifications before implementing
- Keep documentation open while coding
- Verify examples before copying

### Using Documentation
- Reference during planning phase
- Cross-check implementation against specs
- Use code examples as templates
- Adapt patterns to your use case
- Document your own additions

### Contributing to Documentation
- Update when making architectural changes
- Add examples for new patterns
- Include troubleshooting tips
- Cross-reference related documents
- Keep it concise and actionable

## Documentation Philosophy

**OS AI documentation follows these principles**:

1. **Comprehensive but concise** - Cover all topics, avoid redundancy
2. **Example-driven** - Show working code, not just theory
3. **Actionable** - Provide clear next steps
4. **Versioned** - Track changes and updates
5. **Cross-referenced** - Link related concepts
6. **Living** - Update as system evolves

## Next Steps

To maximize value from OS AI documentation:

1. **Bookmark frequently used docs**: Multi-agent architecture, GCP guides
2. **Set up search shortcuts**: grep aliases for common queries
3. **Create documentation rituals**: Review relevant docs before starting work
4. **Contribute back**: Update docs when you discover new insights
5. **Share knowledge**: Use docs to onboard team members

## Reference Links

- **Main AI Docs**: `ai_docs/refs/README.md`
- **Architecture Index**: `ai_docs/refs/multi-agent-architecture/00-index.md`
- **Quick Reference**: `ai_docs/refs/multi-agent-architecture/QUICK-REFERENCE.md`
- **Project README**: `README.md` (root)
