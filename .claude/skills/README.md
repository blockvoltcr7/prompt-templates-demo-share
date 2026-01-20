# OS AI - Claude Skills

This directory contains specialized Claude Skills for the OS AI project. Skills are automatically discovered and invoked by Claude when working on relevant tasks.

## 📚 Available Skills

### 1. **RAG Document Processing** ⭐
**Skill**: `rag-document-processing`
**Location**: `.claude/skills/rag-document-processing/`

**Use when**:
- Working with document uploads and processing
- Implementing embeddings and vector search
- Debugging RAG pipeline issues
- Optimizing similarity search performance

**Key topics**:
- Docling document extraction
- Google AI Platform embeddings (text-embedding-004)
- pgvector and HNSW indexes
- Multi-tenancy and coach-scoped queries

---

### 2. **Google ADK Multi-Agent System** ⭐
**Skill**: `google-adk-agents`
**Location**: `.claude/skills/google-adk-agents/`

**Use when**:
- Building or modifying agent behaviors
- Understanding the 5-state machine (ACTIVE, SLIPPING, RECOVERING, CHURNED, COMPLETED)
- Implementing WhatsApp integration via GHL
- Working with Mem0 semantic memory

**Key topics**:
- 6 specialized agents (Onboarding, Daily Check-in, Recovery, Weekly Review, Ascension, Support)
- State transitions and behavioral tracking
- WhatsApp webhook routing
- Multi-coach/multi-user architecture

---

### 3. **Drizzle ORM Database** ⭐
**Skill**: `drizzle-database`
**Location**: `.claude/skills/drizzle-database/`

**Use when**:
- Creating or modifying database schema
- Writing database migrations
- Working with PostgreSQL and Supabase
- Implementing RLS policies
- Using pgvector for embeddings

**Key topics**:
- Database schema design patterns
- Migration generation and rollback
- Vector similarity search
- Multi-tenancy with coach isolation
- Performance optimization

---

### 4. **GCP Deployment & Infrastructure**
**Skill**: `gcp-deployment`
**Location**: `.claude/skills/gcp-deployment/`

**Use when**:
- Deploying agents to Cloud Run
- Setting up GCS buckets and signed URLs
- Configuring Cloud Functions and EventArc
- Scheduling jobs with Cloud Scheduler
- Generating embeddings with AI Platform

**Key topics**:
- Google Cloud Storage configuration
- Cloud Run containerized deployments
- EventArc event-driven triggers
- Cloud Scheduler cron jobs
- AI Platform API integration

---

### 5. **AI Documentation Navigator**
**Skill**: `ai-docs-navigator`
**Location**: `.claude/skills/ai-docs-navigator/`

**Use when**:
- Looking for implementation examples
- Navigating the extensive `ai_docs/refs/` directory
- Finding API references and guides
- Understanding architecture documentation

**Key topics**:
- Multi-agent architecture specs
- Google ADK tutorials
- Cloudflare Workers guides
- GCP service documentation
- Code examples and best practices

---

### 6. **Onboarding Flow Design**
**Skill**: `onboarding-flow-design`
**Location**: `.claude/skills/onboarding-flow-design/`

**Use when**:
- Designing user onboarding experiences
- Implementing dynamic coach questions
- Building goal-setting flows
- Creating personalized program setup

**Key topics**:
- 5-stage onboarding flow
- Dynamic question types (multiple choice, free text, scale, date, time)
- Goal extraction and structuring
- Schedule customization
- Initial memory creation

---

### 7. **Cloudflare Workers & Edge Deployment**
**Skill**: `cloudflare-workers`
**Location**: `.claude/skills/cloudflare-workers/`

**Use when**:
- Deploying serverless functions to the edge
- Implementing Workers AI inference
- Using Durable Objects for stateful logic
- Setting up cron triggers
- Migrating from GCP to Cloudflare

**Key topics**:
- Workers core concepts and deployment
- Workers AI models (LLMs, embeddings, translation)
- KV storage for caching
- Durable Objects for real-time features
- R2 object storage

---

### 8. **Deploy Supabase Edge Functions**
**Skill**: `deploy-edge-function`
**Location**: `.claude/skills/deploy-edge-function/`

**Use when**:
- Deploying Supabase Edge Functions to production
- Managing webhook endpoints
- Configuring JWT verification settings
- Setting up environment variables for functions

**Key topics**:
- Function discovery and selection
- JWT verification vs. custom authentication
- Environment variable management
- Deployment troubleshooting
- Function monitoring and logs

---

### 9. **Delete User Account** ⭐
**Skill**: `delete-user`
**Location**: `.claude/skills/delete-user/`

**Use when**:
- Deleting a user account from the system
- Removing user data for GDPR compliance
- Cleaning up test accounts
- Handling right-to-be-forgotten requests

**Key topics**:
- Safe deletion with confirmation
- Proper foreign key cascade order
- Related data analysis and summary
- Deletion verification
- Creator profile cleanup
- Program and enrollment handling

---

## 🚀 How Skills Work

### Automatic Activation
Skills activate automatically when Claude detects relevant keywords in your request. For example:

- **User**: "Help me optimize the RAG search performance"
- **Claude**: *Automatically activates `rag-document-processing` skill*

- **User**: "I need to deploy the agents to Cloud Run"
- **Claude**: *Automatically activates `gcp-deployment` skill*

- **User**: "How do I create a new database migration?"
- **Claude**: *Automatically activates `drizzle-database` skill*

### Skill Discovery
Claude reads the `description` field in each SKILL.md frontmatter to determine when to activate. The description includes:
- What the skill does
- When to use it
- Key trigger terms

### Skill Composition
Multiple skills can work together. For example, implementing a new agent might activate:
1. `google-adk-agents` - For agent architecture
2. `drizzle-database` - For database schema
3. `ai-docs-navigator` - For reference materials

---

## 📖 Skill Structure

Each skill follows this structure:

```
.claude/skills/skill-name/
├── SKILL.md              # Required: Main skill file with frontmatter
├── REFERENCE.md          # Optional: Detailed API references
├── EXAMPLES.md           # Optional: Usage examples
├── scripts/              # Optional: Helper scripts
└── templates/            # Optional: Code templates
```

### SKILL.md Format

```yaml
---
name: skill-name-kebab-case
description: What it does and when to use it. Include trigger keywords.
allowed-tools: Read, Grep, Glob  # Optional: Restrict Claude's tools
---

# Skill Title

## Overview
Brief description of the skill's purpose

## Key Concepts
Important information Claude needs

## Common Tasks
Step-by-step guides for frequent operations

## Best Practices
Recommendations and patterns

## Reference Documentation
Links to related docs

## Troubleshooting
Common issues and solutions
```

---

## 🎯 Best Practices

### For Users

**1. Be Specific in Requests**
- ✅ "Help me add pgvector support to the document_chunks table"
- ❌ "Help with the database"

**2. Reference Technologies**
- ✅ "Deploy this Cloud Function to process documents"
- ❌ "Deploy this function"

**3. Mention Use Cases**
- ✅ "I need to implement the recovery agent flow"
- ❌ "I need to implement an agent"

### For Skill Maintainers

**1. Write Clear Descriptions**
Include specific trigger terms users would naturally say:
```yaml
description: Work with Drizzle ORM, PostgreSQL, migrations, pgvector. Use when creating database schema, writing migrations, or working with Supabase.
```

**2. Keep Skills Focused**
- One skill = One domain of expertise
- Don't combine unrelated topics
- Split large skills into smaller ones

**3. Provide Actionable Content**
- Step-by-step guides
- Working code examples
- Clear troubleshooting steps
- Links to reference docs

**4. Update Regularly**
- Keep code examples current
- Update when architecture changes
- Add new patterns as discovered
- Remove deprecated information

---

## 🔄 Skill Lifecycle

### Creating a New Skill

**1. Identify the Need**
- Is there a repetitive task Claude handles?
- Is there complex domain knowledge to capture?
- Would a skill improve Claude's effectiveness?

**2. Create the Directory**
```bash
mkdir -p .claude/skills/your-skill-name
```

**3. Write SKILL.md**
- Clear, specific description with trigger terms
- Comprehensive instructions
- Code examples
- Troubleshooting guide

**4. Test the Skill**
Ask Claude questions that should trigger the skill:
```
"Help me implement [skill topic]"
"I need to [skill action]"
"How do I [skill use case]"
```

**5. Commit to Git**
```bash
git add .claude/skills/
git commit -m "Add [skill name] skill for [purpose]"
```

### Updating a Skill

When architecture or best practices change:

1. Update the SKILL.md content
2. Add version notes if significant changes
3. Test that skill still activates correctly
4. Commit with descriptive message

### Deprecating a Skill

If a skill is no longer relevant:

1. Add deprecation notice to SKILL.md
2. Point to replacement skill or alternative
3. After transition period, remove the skill directory

---

## 📊 Skill Coverage Matrix

| Domain | Skill | Coverage |
|--------|-------|----------|
| **Document Processing** | rag-document-processing | ✅ Complete |
| **Agent System** | google-adk-agents | ✅ Complete |
| **Database** | drizzle-database | ✅ Complete |
| **GCP Deployment** | gcp-deployment | ✅ Complete |
| **Documentation** | ai-docs-navigator | ✅ Complete |
| **Onboarding** | onboarding-flow-design | ✅ Complete |
| **Edge Computing** | cloudflare-workers | ✅ Complete |
| **Edge Functions** | deploy-edge-function | ✅ Complete |
| **User Management** | delete-user | ✅ Complete |
| **Testing** | - | ⏳ Planned |
| **Monitoring** | - | ⏳ Planned |
| **Security** | - | ⏳ Planned |

---

## 🤝 Contributing

### Adding a New Skill

1. Discuss with team first to avoid duplicates
2. Create skill in `.claude/skills/`
3. Follow the SKILL.md format
4. Include practical examples
5. Test activation with relevant queries
6. Update this README
7. Submit for review

### Improving Existing Skills

1. Identify gaps or outdated information
2. Update SKILL.md with improvements
3. Add examples if missing
4. Test skill activation still works
5. Commit with clear description

---

## 📝 Skill vs. Slash Command

When deciding between a Skill and a Slash Command:

| Use Skill | Use Slash Command |
|-----------|-------------------|
| Complex multi-step workflows | Simple prompt snippets |
| Domain expertise with multiple files | Single template or reminder |
| Automatically triggered by context | Explicitly invoked by user |
| Requires reference documentation | One-time quick access |
| Team-shared best practices | Personal shortcuts |

**Example Skill**: `google-adk-agents` (complex architecture, multiple agents, state machines)
**Example Slash Command**: `/commit` (simple git commit prompt)

---

## 🔗 Related Documentation

- [Claude Code Skills Documentation](https://code.claude.com/docs/en/skills.md)
- [Slash Commands Guide](https://code.claude.com/docs/en/slash-commands.md)
- [OS AI Architecture](../../../ai_docs/refs/multi-agent-architecture/)
- [Project README](../../../README.md)

---

## 📞 Support

If you have questions about skills:

1. Check this README first
2. Review skill-specific SKILL.md files
3. Ask in team chat
4. Consult [Claude Code documentation](https://code.claude.com/docs)

---

**Last Updated**: 2026-01-10
**Skills Count**: 9
**Project**: OS AI - Intelligent AI Agent Operating System
