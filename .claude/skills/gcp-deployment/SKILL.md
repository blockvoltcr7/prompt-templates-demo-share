---
name: gcp-deployment
description: Work with Google Cloud Platform deployment, Cloud Storage, Cloud Run, Cloud Functions, EventArc, and Cloud Scheduler. Use when deploying agents, setting up GCS buckets, configuring triggers, or working with GCP infrastructure.
---

# GCP Deployment & Infrastructure Skill

## Overview
OS AI uses Google Cloud Platform for document storage, agent hosting, and event-driven processing.

## GCP Services Used

### 1. Google Cloud Storage (GCS)
**Purpose**: Store uploaded coach documents
**Buckets**:
- `os-ai-coach-documents` - Primary document storage
- `os-ai-vault` - Secure encrypted storage

### 2. Cloud Run
**Purpose**: Host ADK agents as serverless containers
**Configuration**:
- Auto-scaling (0 to N instances)
- Request timeout: 300s
- Memory: 2GB per instance
- CPU: 2 vCPU

### 3. Cloud Functions (Gen 2)
**Purpose**: Event-driven document processing
**Triggers**:
- EventArc (GCS bucket finalize events)
- Webhook endpoints for integrations

### 4. Cloud Scheduler
**Purpose**: Trigger scheduled agent runs
**Jobs**:
- Daily check-in agent (morning: 8am, evening: 8pm)
- Weekly review agent (Sunday 8pm)
- State cleanup job (daily at 2am)

### 5. EventArc
**Purpose**: Event routing from GCS to Cloud Functions
**Events**:
- `google.cloud.storage.object.v1.finalized` - New document uploaded
- `google.cloud.storage.object.v1.deleted` - Document deleted

### 6. AI Platform
**Purpose**: Generate embeddings and multimodal processing
**Models**:
- `text-embedding-004` - Text embeddings (768-dim)
- `multimodal-embedding-001` - Images/video/audio

## Code Locations

### GCP Reference Documentation
```
ai_docs/refs/gcp/
├── code-examples/ - GCS, Cloud Run, EventArc examples
├── cloud-scheduler/ - Scheduled job setup
├── cloud-storage/ - GCS bucket configuration
├── ai-platform/ - Embedding generation
├── gcp-knowledge/ - General GCP guides
└── resources/ - API references and tutorials
```

### Deployment Scripts
```
scripts/
├── setup-gcs-buckets.sh - Create and configure GCS buckets
├── deploy-agents.sh - Deploy ADK agents to Cloud Run
├── setup-scheduler.sh - Configure Cloud Scheduler jobs
└── setup-eventarc.sh - Set up event triggers
```

### Environment Configuration
```
# .env.local
GOOGLE_CLOUD_PROJECT=os-ai-production
GCS_BUCKET_NAME=os-ai-coach-documents
GOOGLE_APPLICATION_CREDENTIALS=./service-account-key.json
```

## Common Tasks

### Task 1: Setting Up GCS Buckets

**Create bucket with proper permissions**
```bash
# Run setup script
npm run storage:setup

# Or manually
gcloud storage buckets create gs://os-ai-coach-documents \
  --project=os-ai-production \
  --location=us-central1 \
  --uniform-bucket-level-access

# Set CORS for signed URLs
gcloud storage buckets update gs://os-ai-coach-documents \
  --cors-file=./scripts/cors-config.json
```

**CORS Configuration** (`scripts/cors-config.json`)
```json
[
  {
    "origin": ["http://localhost:3000", "https://app.os-ai.com"],
    "method": ["GET", "PUT", "POST"],
    "responseHeader": ["Content-Type"],
    "maxAgeSeconds": 3600
  }
]
```

**Set lifecycle rules**
```bash
# Delete processed temp files after 7 days
gcloud storage buckets update gs://os-ai-coach-documents \
  --lifecycle-file=./scripts/lifecycle-config.json
```

### Task 2: Generating Signed URLs

**For document uploads** (apps/web/lib/google-cloud.ts)
```typescript
import { Storage } from '@google-cloud/storage';

const storage = new Storage({
  projectId: process.env.GOOGLE_CLOUD_PROJECT,
  keyFilename: process.env.GOOGLE_APPLICATION_CREDENTIALS,
});

const bucket = storage.bucket(process.env.GCS_BUCKET_NAME!);
const file = bucket.file(`coaches/${coachId}/documents/${fileName}`);

const [signedUrl] = await file.getSignedUrl({
  version: 'v4',
  action: 'write',
  expires: Date.now() + 15 * 60 * 1000, // 15 minutes
  contentType: mimeType,
});

return signedUrl;
```

### Task 3: Deploying Cloud Functions for Document Processing

**Function code structure**
```python
# functions/process-document/main.py
import functions_framework
from docling import DocumentConverter

@functions_framework.cloud_event
def process_document(cloud_event):
    """Triggered by GCS finalize event"""
    bucket = cloud_event.data['bucket']
    name = cloud_event.data['name']

    # 1. Download file from GCS
    # 2. Extract text with Docling
    # 3. Chunk text with overlap
    # 4. Generate embeddings
    # 5. Store in PostgreSQL
    # 6. Update processing_jobs table
```

**Deploy function**
```bash
gcloud functions deploy process-document \
  --gen2 \
  --runtime=python312 \
  --region=us-central1 \
  --source=./functions/process-document \
  --entry-point=process_document \
  --trigger-event-filters="type=google.cloud.storage.object.v1.finalized" \
  --trigger-event-filters="bucket=os-ai-coach-documents" \
  --memory=2GB \
  --timeout=540s
```

### Task 4: Deploying ADK Agents to Cloud Run

**Dockerfile** (apps/agents/Dockerfile)
```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
```

**Build and deploy**
```bash
# Build container
gcloud builds submit \
  --tag gcr.io/os-ai-production/accountability-agents

# Deploy to Cloud Run
gcloud run deploy accountability-agents \
  --image gcr.io/os-ai-production/accountability-agents \
  --platform managed \
  --region us-central1 \
  --memory 2Gi \
  --cpu 2 \
  --timeout 300 \
  --min-instances 0 \
  --max-instances 10 \
  --allow-unauthenticated
```

**Or use npm script**
```bash
npm run deploy:agents:production
```

### Task 5: Setting Up Cloud Scheduler Jobs

**Create morning check-in job**
```bash
gcloud scheduler jobs create http morning-checkin \
  --location us-central1 \
  --schedule "0 8 * * *" \
  --uri "https://accountability-agents-xyz.run.app/trigger/morning-checkin" \
  --http-method POST \
  --headers "Content-Type=application/json" \
  --message-body '{"agent":"daily_checkin","type":"morning"}' \
  --oidc-service-account-email agents@os-ai-production.iam.gserviceaccount.com
```

**List all jobs**
```bash
gcloud scheduler jobs list --location us-central1
```

**Trigger manually for testing**
```bash
gcloud scheduler jobs run morning-checkin --location us-central1
```

### Task 6: Configuring EventArc Triggers

**Create trigger for document processing**
```bash
gcloud eventarc triggers create document-processing-trigger \
  --location=us-central1 \
  --destination-run-service=process-document-function \
  --destination-run-region=us-central1 \
  --event-filters="type=google.cloud.storage.object.v1.finalized" \
  --event-filters="bucket=os-ai-coach-documents" \
  --service-account=eventarc@os-ai-production.iam.gserviceaccount.com
```

## AI Platform Integration

### Text Embeddings

**Generate embeddings** (apps/web/lib/embeddings/text-embeddings.ts)
```typescript
import { GoogleGenerativeAI } from '@google/generative-ai';

const genAI = new GoogleGenerativeAI(process.env.GOOGLE_API_KEY!);
const model = genAI.getGenerativeModel({ model: 'text-embedding-004' });

const result = await model.embedContent(text);
const embedding = result.embedding.values; // 768 dimensions
```

### Multimodal Embeddings

**Generate image embeddings**
```typescript
const model = genAI.getGenerativeModel({
  model: 'multimodal-embedding-001'
});

const imageData = fs.readFileSync('image.jpg').toString('base64');
const result = await model.embedContent({
  content: [{
    inlineData: {
      mimeType: 'image/jpeg',
      data: imageData,
    }
  }]
});
```

## Best Practices

### Security
- **Service accounts**: Use least-privilege service accounts
- **IAM roles**: Grant minimal necessary permissions
- **Signed URLs**: Use short expiration times (15 minutes)
- **VPC**: Consider VPC Service Controls for production
- **Secrets**: Use Secret Manager for API keys

### Performance
- **Regional deployment**: Deploy in same region as database
- **Auto-scaling**: Configure min/max instances appropriately
- **Caching**: Use Cloud CDN for static assets
- **Compression**: Enable gzip compression for GCS
- **Connection pooling**: Use connection poolers for database

### Cost Optimization
- **Lifecycle policies**: Delete old temp files automatically
- **Min instances**: Set to 0 for low-traffic services
- **Committed use**: Consider for predictable workloads
- **Monitoring**: Set up budget alerts
- **Storage class**: Use Nearline/Coldline for archival

### Monitoring
- **Cloud Logging**: Enable structured logging
- **Cloud Monitoring**: Set up dashboards and alerts
- **Error Reporting**: Track and aggregate errors
- **Cloud Trace**: Profile request latency
- **Uptime checks**: Monitor service availability

## Environment-Specific Configuration

### Development
```bash
GOOGLE_CLOUD_PROJECT=os-ai-dev
GCS_BUCKET_NAME=os-ai-coach-documents-dev
```

### Staging
```bash
GOOGLE_CLOUD_PROJECT=os-ai-staging
GCS_BUCKET_NAME=os-ai-coach-documents-staging
```

### Production
```bash
GOOGLE_CLOUD_PROJECT=os-ai-production
GCS_BUCKET_NAME=os-ai-coach-documents
```

## Troubleshooting

### Issue: Signed URL generation fails
**Solution**: Check service account permissions, verify key file path, ensure IAM roles include `storage.objectAdmin`

### Issue: Cloud Function not triggering
**Solution**: Verify EventArc trigger exists, check service account permissions, review Cloud Logging for errors

### Issue: Cloud Run deployment fails
**Solution**: Check Docker build logs, verify memory/CPU limits, ensure environment variables are set

### Issue: Embeddings API quota exceeded
**Solution**: Implement rate limiting, batch requests, cache embeddings, request quota increase

### Issue: High GCS costs
**Solution**: Review lifecycle policies, delete unused files, use appropriate storage class, enable compression

## Useful Commands

```bash
# List all GCS buckets
gcloud storage buckets list

# View Cloud Run services
gcloud run services list

# Check Cloud Function logs
gcloud functions logs read process-document --limit=50

# List Cloud Scheduler jobs
gcloud scheduler jobs list

# View EventArc triggers
gcloud eventarc triggers list

# Monitor resource usage
gcloud monitoring dashboards list
```

## Reference Documentation

See [`ai_docs/refs/gcp/`](../../../ai_docs/refs/gcp/):
- `code-examples/` - Implementation examples
- `cloud-storage/` - GCS configuration guides
- `cloud-scheduler/` - Scheduled job setup
- `ai-platform/` - Embedding generation guides
- `resources/` - Official documentation links

## Security Considerations

- **IAM**: Use principle of least privilege for all service accounts
- **Signed URLs**: Short expiration, validate on backend
- **CORS**: Restrict origins to known domains only
- **Encryption**: Enable encryption at rest and in transit
- **Audit logs**: Enable Cloud Audit Logs for compliance
- **Network security**: Use VPC Service Controls for sensitive data
