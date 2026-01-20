---
name: cloudflare-workers
description: Work with Cloudflare Workers, Workers AI, edge functions, and serverless deployment. Use when deploying to Cloudflare, implementing edge functions, running AI inference at the edge, or working with MCP servers on Cloudflare.
---

# Cloudflare Workers & Edge Deployment Skill

## Overview
Cloudflare Workers provide serverless edge computing, enabling OS AI to run code close to users worldwide with minimal latency. Workers AI adds on-device AI inference capabilities.

## Cloudflare Services Overview

### 1. Cloudflare Workers
**Purpose**: Serverless JavaScript/TypeScript execution at the edge
**Use Cases**:
- API endpoints with low latency
- Webhook receivers
- Request routing and middleware
- Edge-side rendering

### 2. Workers AI
**Purpose**: AI inference at the edge without GPU infrastructure
**Models Available**:
- Text generation (LLMs)
- Embeddings
- Image classification
- Translation
- Speech recognition

### 3. Workers KV
**Purpose**: Global, low-latency key-value storage
**Use Cases**:
- Caching
- Session storage
- Configuration data
- Rate limiting

### 4. Durable Objects
**Purpose**: Strongly consistent, stateful serverless objects
**Use Cases**:
- Real-time collaboration
- Chat applications
- Rate limiting with precision
- Distributed locks

### 5. R2 Storage
**Purpose**: S3-compatible object storage (no egress fees)
**Use Cases**:
- Document storage (alternative to GCS)
- Media files
- Static assets
- Backups

## Code Locations

### Cloudflare Reference Documentation
```
ai_docs/refs/cloudflare/
├── code-examples/        # Worker implementations
├── workers/              # Workers core documentation
├── workers-ai/           # AI inference guides
├── mcp-servers/          # MCP server integration
└── resources/            # API references and tutorials
```

## Worker Implementation Examples

### Basic Worker
```typescript
// worker.ts
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);

    if (url.pathname === '/api/hello') {
      return new Response(JSON.stringify({ message: 'Hello from the edge!' }), {
        headers: { 'content-type': 'application/json' },
      });
    }

    return new Response('Not found', { status: 404 });
  },
};
```

### Worker with Database (D1)
```typescript
export interface Env {
  DB: D1Database;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const { pathname } = new URL(request.url);

    if (pathname === '/api/users') {
      const users = await env.DB.prepare(
        'SELECT * FROM users WHERE coach_id = ?'
      ).bind(coachId).all();

      return Response.json(users);
    }

    return new Response('Not found', { status: 404 });
  },
};
```

### Worker with AI Inference
```typescript
export interface Env {
  AI: Ai;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const messages = [
      { role: 'system', content: 'You are a helpful accountability coach.' },
      { role: 'user', content: 'How can I stay motivated?' },
    ];

    const response = await env.AI.run('@cf/meta/llama-2-7b-chat-int8', {
      messages,
    });

    return Response.json(response);
  },
};
```

### Worker with Embeddings
```typescript
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const text = await request.text();

    // Generate embeddings at the edge
    const embeddings = await env.AI.run('@cf/baai/bge-base-en-v1.5', {
      text: [text],
    });

    // Store or compare embeddings
    return Response.json({ embeddings });
  },
};
```

### Worker with KV Storage
```typescript
export interface Env {
  CACHE: KVNamespace;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const cacheKey = 'user:123:profile';

    // Try cache first
    const cached = await env.CACHE.get(cacheKey, 'json');
    if (cached) {
      return Response.json(cached);
    }

    // Fetch from origin
    const data = await fetchUserProfile(123);

    // Store in cache for 1 hour
    await env.CACHE.put(cacheKey, JSON.stringify(data), {
      expirationTtl: 3600,
    });

    return Response.json(data);
  },
};
```

### Worker with Durable Objects
```typescript
// Durable Object for real-time chat
export class ChatRoom implements DurableObject {
  state: DurableObjectState;
  sessions: Set<WebSocket>;

  constructor(state: DurableObjectState) {
    this.state = state;
    this.sessions = new Set();
  }

  async fetch(request: Request): Promise<Response> {
    const upgradeHeader = request.headers.get('Upgrade');
    if (upgradeHeader !== 'websocket') {
      return new Response('Expected WebSocket', { status: 400 });
    }

    const pair = new WebSocketPair();
    const [client, server] = Object.values(pair);

    this.handleSession(server);

    return new Response(null, {
      status: 101,
      webSocket: client,
    });
  }

  handleSession(webSocket: WebSocket) {
    webSocket.accept();
    this.sessions.add(webSocket);

    webSocket.addEventListener('message', (event) => {
      // Broadcast to all connected clients
      this.broadcast(event.data);
    });

    webSocket.addEventListener('close', () => {
      this.sessions.delete(webSocket);
    });
  }

  broadcast(message: string) {
    for (const session of this.sessions) {
      session.send(message);
    }
  }
}

// Worker that uses the Durable Object
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const id = env.CHAT_ROOM.idFromName('room-123');
    const stub = env.CHAT_ROOM.get(id);
    return stub.fetch(request);
  },
};
```

## Deployment

### Using Wrangler CLI

**Install Wrangler**
```bash
npm install -g wrangler
```

**Login to Cloudflare**
```bash
wrangler login
```

**Initialize Project**
```bash
wrangler init os-ai-workers
```

**Configure wrangler.toml**
```toml
name = "os-ai-workers"
main = "src/index.ts"
compatibility_date = "2024-01-01"

[env.production]
workers_dev = false
route = "api.os-ai.com/*"
vars = { ENVIRONMENT = "production" }

[[kv_namespaces]]
binding = "CACHE"
id = "your-kv-namespace-id"

[ai]
binding = "AI"
```

**Deploy Worker**
```bash
# Development
wrangler deploy

# Production
wrangler deploy --env production
```

### Environment Variables & Secrets

**Set secrets**
```bash
wrangler secret put OPENROUTER_API_KEY
wrangler secret put DATABASE_URL
wrangler secret put SUPABASE_SERVICE_ROLE_KEY
```

**Access in worker**
```typescript
export interface Env {
  OPENROUTER_API_KEY: string;
  DATABASE_URL: string;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const apiKey = env.OPENROUTER_API_KEY;
    // Use the secret
  },
};
```

## Workers AI Models

### Text Generation
```typescript
const response = await env.AI.run('@cf/meta/llama-2-7b-chat-int8', {
  messages: [
    { role: 'system', content: 'You are a helpful assistant.' },
    { role: 'user', content: 'Hello!' },
  ],
});
```

**Available Models**:
- `@cf/meta/llama-2-7b-chat-int8`
- `@cf/mistral/mistral-7b-instruct-v0.1`
- `@cf/openchat/openchat-3.5-0106`

### Embeddings
```typescript
const embeddings = await env.AI.run('@cf/baai/bge-base-en-v1.5', {
  text: ['Hello world', 'Another sentence'],
});
```

**Available Models**:
- `@cf/baai/bge-base-en-v1.5` (768 dimensions)
- `@cf/baai/bge-small-en-v1.5` (384 dimensions)

### Image Classification
```typescript
const result = await env.AI.run('@cf/microsoft/resnet-50', {
  image: imageArrayBuffer,
});
```

### Translation
```typescript
const translation = await env.AI.run('@cf/meta/m2m100-1.2b', {
  text: 'Hello world',
  source_lang: 'en',
  target_lang: 'es',
});
```

## Integration with OS AI

### Edge RAG Search
```typescript
// Worker for edge-based document search
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const { query } = await request.json();

    // Generate query embedding at edge
    const queryEmbedding = await env.AI.run('@cf/baai/bge-base-en-v1.5', {
      text: [query],
    });

    // Search database for similar documents
    const results = await searchDocuments(
      env.DB,
      queryEmbedding.data[0],
      coachId
    );

    return Response.json(results);
  },
};

async function searchDocuments(db: D1Database, embedding: number[], coachId: string) {
  // Perform vector similarity search in D1
  return await db.prepare(`
    SELECT content, metadata
    FROM document_chunks
    WHERE coach_id = ?
    ORDER BY embedding <-> ?
    LIMIT 5
  `).bind(coachId, JSON.stringify(embedding)).all();
}
```

### WhatsApp Webhook Handler
```typescript
// Fast webhook processing at the edge
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    if (request.method !== 'POST') {
      return new Response('Method not allowed', { status: 405 });
    }

    const webhook = await request.json();

    // Route to appropriate agent based on message
    const response = await routeToAgent(webhook, env);

    // Send response via GHL API
    await sendWhatsAppMessage(webhook.from, response);

    return new Response('OK');
  },
};

async function routeToAgent(webhook: any, env: Env): Promise<string> {
  // Determine user state and context
  const userState = await getUserState(env.DB, webhook.from);

  // Use AI to generate contextual response
  const aiResponse = await env.AI.run('@cf/meta/llama-2-7b-chat-int8', {
    messages: [
      { role: 'system', content: getAgentPrompt(userState) },
      { role: 'user', content: webhook.message },
    ],
  });

  return aiResponse.response;
}
```

### Scheduled Messages (Cron Triggers)
```typescript
export default {
  async scheduled(event: ScheduledEvent, env: Env): Promise<void> {
    // Runs on schedule (e.g., daily at 8am)
    const users = await getUsersForMorningCheckIn(env.DB);

    for (const user of users) {
      const message = await generateMorningCheckIn(user, env);
      await sendWhatsAppMessage(user.phoneNumber, message);
    }
  },
};
```

**Configure in wrangler.toml**
```toml
[triggers]
crons = ["0 8 * * *", "0 20 * * *"]  # 8am and 8pm UTC
```

## Best Practices

### Performance
- **Cold starts**: Workers start in <5ms (minimal cold start)
- **Regional caching**: Use KV for frequently accessed data
- **Minimize dependencies**: Keep worker code lightweight
- **Streaming responses**: Use ReadableStream for large responses
- **Connection pooling**: Reuse database connections

### Security
- **CORS**: Configure appropriate CORS headers
- **Rate limiting**: Use Durable Objects for precise rate limiting
- **Secrets management**: Use wrangler secrets, not environment vars
- **Input validation**: Validate all user inputs
- **Authentication**: Verify JWT tokens at the edge

### Cost Optimization
- **Free tier**: 100,000 requests/day free
- **R2 egress**: No egress fees (unlike S3)
- **KV pricing**: $0.50/million reads
- **Workers AI**: Pay per inference, no infrastructure costs
- **Caching**: Reduce origin requests with aggressive caching

### Development Workflow
- **Local testing**: Use `wrangler dev` for local development
- **Staging environment**: Deploy to staging before production
- **Monitoring**: Use Workers Analytics dashboard
- **Logging**: Use `console.log()` → visible in wrangler tail
- **Testing**: Write integration tests with Miniflare

## MCP Server Integration

### Running MCP Servers on Workers
```typescript
// Worker that hosts an MCP server
import { MCPServer } from '@anthropic/mcp-server';

const server = new MCPServer({
  name: 'os-ai-knowledge',
  version: '1.0.0',
});

server.tool('search_documents', async ({ query, coachId }) => {
  // Perform RAG search at the edge
  const results = await searchWithWorkerAI(query, coachId);
  return results;
});

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    return server.handleRequest(request, env);
  },
};
```

See [`ai_docs/refs/cloudflare/mcp-servers/`](../../../ai_docs/refs/cloudflare/mcp-servers/) for detailed MCP integration guides.

## Common Use Cases for OS AI

### 1. Low-Latency API Endpoints
Deploy webhook receivers and API routes to Workers for <10ms response times globally.

### 2. Edge-Based RAG Search
Run embeddings and similarity search at the edge, reducing latency for knowledge retrieval.

### 3. Real-Time Agent Responses
Process WhatsApp messages and generate AI responses with Workers AI, eliminating cold starts.

### 4. Scheduled Agent Triggers
Use cron triggers to initiate daily check-ins and weekly reviews without Cloud Scheduler.

### 5. Global Content Delivery
Serve coach documents and media files from R2 with Cloudflare's global CDN.

## Troubleshooting

### Issue: Worker deployment fails
**Solution**: Check wrangler.toml syntax, verify KV namespace IDs, ensure secrets are set

### Issue: High latency for database queries
**Solution**: Use connection pooling, cache frequently accessed data in KV, consider D1 for edge database

### Issue: Workers AI quota exceeded
**Solution**: Implement request caching, batch AI calls, use smaller models, upgrade plan

### Issue: CORS errors
**Solution**: Add proper CORS headers, handle OPTIONS preflight requests, verify origin whitelist

## Monitoring & Debugging

### Wrangler Commands
```bash
# Tail worker logs in real-time
wrangler tail

# View analytics
wrangler analytics

# Test worker locally
wrangler dev

# Publish to production
wrangler deploy --env production
```

### Analytics Dashboard
- Request volume and error rates
- CPU time and bandwidth usage
- Edge location distribution
- Success/error status codes

## Reference Documentation

See [`ai_docs/refs/cloudflare/`](../../../ai_docs/refs/cloudflare/):
- `workers/` - Core Workers documentation
- `workers-ai/` - AI inference guides
- `code-examples/` - Complete implementations
- `resources/` - Official Cloudflare docs
- `mcp-servers/` - MCP integration

## Migration from GCP to Cloudflare

### Comparison

| Feature | GCP | Cloudflare |
|---------|-----|------------|
| **Cold starts** | 1-5 seconds | <5ms |
| **Edge locations** | Regional | 300+ cities globally |
| **AI inference** | Vertex AI (GPU) | Workers AI (serverless) |
| **Storage** | GCS | R2 (no egress fees) |
| **Database** | Cloud SQL | D1 (edge database) |
| **Pricing** | Pay for infrastructure | Pay per request |

### When to Use Cloudflare
- Need <10ms global latency
- Want to eliminate cold starts
- High egress costs on GCP
- Simple stateless functions
- Edge-based AI inference

### When to Use GCP
- Complex stateful services
- Need GPUs for large models
- Existing GCP infrastructure
- Advanced ML/AI workflows
- Enterprise compliance requirements

## Security Considerations

- **Secrets**: Use wrangler secrets for sensitive data
- **CORS**: Restrict origins to known domains
- **Rate limiting**: Implement per-user rate limits with Durable Objects
- **Input validation**: Sanitize all user inputs at edge
- **Authentication**: Verify JWT tokens before processing
- **DDoS protection**: Cloudflare's built-in DDoS mitigation
