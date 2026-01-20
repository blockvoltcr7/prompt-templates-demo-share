---
name: google-adk-agents
description: Work with Google ADK (Agent Development Kit) multi-agent system, behavioral accountability agents, state machines, and WhatsApp integration. Use when working with agents, state transitions, daily check-ins, recovery flows, or the accountability system.
---

# Google ADK Multi-Agent System Skill

## Overview
OS AI uses Google's Agent Development Kit (ADK) to build a multi-agent behavioral accountability system delivered via WhatsApp.

## Agent Architecture

### 6 Specialized Agents
1. **Onboarding Agent** - Initial program setup and goal collection
2. **Daily Check-in Agent** - Morning planning + evening reflection
3. **Recovery Agent** - 3-stage slip recovery flow
4. **Weekly Review Agent** - Progress tracking and plan adjustments
5. **Ascension Agent** - Program completion with soft upsell
6. **Support Agent** - On-demand Q&A and guidance

### 5-State Behavioral Machine
```
ACTIVE → engaged with program (daily check-ins complete)
SLIPPING → 1 missed check-in (automated nudge)
RECOVERING → in recovery flow (3-stage process)
CHURNED → 7+ days inactive (requires re-engagement)
COMPLETED → program finished (ascension flow)
```

## Code Locations

### Architecture Documentation
```
ai_docs/refs/multi-agent-architecture/
├── 00-index.md - Navigation guide
├── 01-architecture-overview.md - High-level system design
├── 02-agent-specifications.md - Detailed agent behaviors
├── 03-state-machine.md - State transitions and rules
├── 04-data-models.md - Database schema for agents
├── 05-critical-update-ghl-webhook-flow.md - Multi-tenancy
├── 06-memory-architecture-mem0.md - Semantic memory
└── 07-rag-knowledge-search-architecture.md - RAG integration
```

### Google ADK Reference
```
ai_docs/refs/adk-docs/
├── agent-starter-pack/ - Quick start guides
└── tutorials-and-examples/ - Implementation examples
```

## Agent Specifications

### Onboarding Agent
**Trigger**: New user joins program (GHL webhook)
**Flow**:
1. Welcome message with program overview
2. Dynamic coach questions (configured per coach)
3. Goal setting and expectation alignment
4. Schedule confirmation for daily check-ins
5. Initial state: `ACTIVE`

### Daily Check-in Agent
**Trigger**: Scheduled (morning + evening)
**Morning Flow**:
1. Greeting with context from yesterday
2. Today's intentions and priorities
3. Potential obstacles identification
4. Accountability commitment

**Evening Flow**:
1. Reflection on day's progress
2. Wins and challenges
3. Learning extraction
4. Tomorrow's preview

**State Impact**: Maintains `ACTIVE` state (missed check-ins → `SLIPPING`)

### Recovery Agent
**Trigger**: User enters `SLIPPING` state (1 missed check-in)
**3-Stage Flow**:
1. **Stage 1**: Gentle nudge ("We missed you yesterday")
2. **Stage 2**: Empathetic check-in (if Stage 1 ignored)
3. **Stage 3**: Coach notification + final outreach

**Goal**: Prevent transition to `CHURNED` state

### Weekly Review Agent
**Trigger**: Scheduled (every Sunday evening)
**Flow**:
1. Week summary (adherence score, wins, patterns)
2. Progress toward goals
3. Adjustments for next week
4. Coach insights integration

### Ascension Agent
**Trigger**: User completes program milestones
**Flow**:
1. Celebration of completion
2. Progress recap and wins
3. Soft upsell to next program tier
4. Transition to alumni status

### Support Agent
**Trigger**: On-demand (user asks questions)
**Capabilities**:
- RAG-powered knowledge search over coach documents
- Contextual guidance using Mem0 semantic memory
- Escalation to human coach if needed

## State Machine Rules

### Transition Triggers
```typescript
ACTIVE → SLIPPING: 1 missed check-in
SLIPPING → ACTIVE: Check-in completed
SLIPPING → RECOVERING: Recovery flow initiated
RECOVERING → ACTIVE: Successful recovery
RECOVERING → CHURNED: 7 days in recovery
ACTIVE → COMPLETED: Program milestones met
CHURNED → ACTIVE: Re-engagement successful
```

### State Metadata
- **Adherence score**: % of check-ins completed
- **Streak**: Consecutive days active
- **Last interaction**: Timestamp for activity tracking
- **Recovery attempts**: Count of recovery flows initiated

## WhatsApp Integration (GoHighLevel)

### Webhook Flow
```
1. User sends WhatsApp message → GHL webhook
2. Webhook received at Next.js API route
3. Route to appropriate agent based on context
4. Agent processes with ADK + Mem0 + RAG
5. Response sent via GHL API (<3s latency)
```

### Multi-Tenancy
- Each coach has separate GHL account
- Webhook routing by `coach_id`
- User data isolated per coach
- Shared agent logic, coach-specific data

### Scheduled Messages
- Google Cloud Scheduler triggers agent runs
- Agents fetch pending users from database
- Messages sent via GHL API (batched)
- Failures logged for retry

## Memory Architecture (Mem0)

### Semantic Memory
- **User facts**: Goals, preferences, patterns
- **Conversation context**: Recent interactions
- **Long-term insights**: Behavioral trends
- **Coach knowledge**: Program-specific information

### Memory Retrieval
```python
# Retrieve relevant memories for user
memories = mem0.search(
    user_id=user_id,
    query=current_message,
    limit=5
)
```

## RAG Knowledge Search

### Integration Points
1. **Support Agent**: Q&A over coach documents
2. **Onboarding Agent**: Program information retrieval
3. **Weekly Review**: Progress insights from documents
4. **All Agents**: Contextual guidance when needed

### Search Strategy
- Semantic search over coach's documents
- Similarity threshold: 0.75
- Top 5 chunks for context
- Coach-scoped (multi-tenancy enforced)

## Development Workflow

### Local Testing
1. Set up ADK development environment (Python 3.12+)
2. Configure GHL sandbox credentials
3. Use ngrok for webhook testing
4. Mock Mem0 and RAG for faster iteration

### Deployment (Google Cloud)
```bash
# Deploy agent to Cloud Run
npm run deploy:agents:production

# Configure Cloud Scheduler
npm run setup:scheduler

# Set up EventArc triggers
npm run setup:eventarc
```

## Common Tasks

### Task 1: Adding New Agent
1. Create agent specification in `ai_docs/refs/multi-agent-architecture/`
2. Implement agent logic with ADK
3. Add database tables for agent state
4. Configure webhook routing
5. Test with GHL sandbox
6. Deploy to Cloud Run

### Task 2: Modifying State Transitions
1. Update state machine diagram
2. Modify transition logic in agent code
3. Update database schema for new metadata
4. Test all state paths
5. Update documentation

### Task 3: Debugging Agent Responses
1. Check Cloud Run logs for agent execution
2. Verify Mem0 memory retrieval
3. Test RAG search results
4. Review GHL webhook payload
5. Validate response latency (<3s)

## Best Practices

### Agent Design
- **Single responsibility**: Each agent handles one workflow
- **Stateless**: All state persisted in database
- **Idempotent**: Handle duplicate webhooks gracefully
- **Fast**: Respond within 3 seconds (GHL timeout)

### State Management
- **Atomic transitions**: Use database transactions
- **Audit trail**: Log all state changes
- **Recovery**: Handle failed transitions gracefully
- **Consistency**: Validate state before transitions

### Memory Management
- **Relevance**: Only store useful user information
- **Privacy**: Respect user data sensitivity
- **Cleanup**: Expire old memories (90 days)
- **Consent**: User opt-in for memory features

## Reference Documentation

See [`ai_docs/refs/`](../../../ai_docs/refs/):
- `multi-agent-architecture/` - Complete architecture specs
- `adk-docs/` - Google ADK documentation
- `mem0/` - Mem0 semantic memory guides
- `gcp/cloud-scheduler/` - Scheduled message setup

## Troubleshooting

### Issue: Agent not responding
**Solution**: Check Cloud Run logs, verify GHL webhook configuration, test agent locally

### Issue: State transitions failing
**Solution**: Check database logs, verify transition rules, ensure atomic updates

### Issue: Slow response times
**Solution**: Optimize RAG search, reduce Mem0 queries, use caching, profile agent code

## Security Considerations

- **Data isolation**: All agent queries MUST filter by `coach_id` and `user_id`
- **Webhook validation**: Verify GHL webhook signatures
- **Rate limiting**: Prevent abuse of agent endpoints
- **PII handling**: Encrypt sensitive user data at rest
- **Coach permissions**: Validate coach access to user data
