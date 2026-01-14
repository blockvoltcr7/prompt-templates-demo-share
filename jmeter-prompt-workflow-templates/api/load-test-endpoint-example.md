# Load Test Endpoint Task

## Objective
Create and deploy a POST endpoint that accepts JSON request bodies, then validate it with a minimal load test.

## Task Requirements

### 🎯 Deliverables:
- ✅ **Endpoint Implementation**: Go-based POST endpoint accepting JSON payloads
- ✅ **Deployment**: Live service on Google Cloud (Cloud Run recommended) or Supabase Edge Function
- ✅ **Validation Test**: Minimal JMeter test confirming HTTP 200 response

### 📋 Specifications:

**Endpoint Details:**
- **Method**: POST
- **Input**: JSON request body (schema: [DEFINE_JSON_SCHEMA])
- **Output**: JSON response with status code 200
- **Runtime**: Go 1.21+ 
- **Deployment Target**: [GOOGLE_CLOUD_RUN | SUPABASE_EDGE_FUNCTION]

**Deployment Checklist:**
- [ ] Endpoint code written and tested locally
- [ ] Deployed to [CLOUD_PROVIDER]
- [ ] Publicly accessible URL obtained: [ENDPOINT_URL]
- [ ] CORS/auth configured if needed

**Validation Testing:**
- [ ] JMeter test created with minimal configuration
- [ ] Single POST request to endpoint
- [ ] Assert response status = 200
- [ ] Test executes successfully

### 📦 Acceptance Criteria:
- Endpoint returns HTTP 200 for valid JSON payloads
- Deployment is live and accessible
- JMeter test passes without errors

