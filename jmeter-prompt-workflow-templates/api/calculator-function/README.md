# Calculator Cloud Function

This is a Google Cloud Function written in Go that accepts two numbers and returns their sum.

## Prerequisites

- [Go 1.21+](https://go.dev/dl/)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)

## Local Development

1. Install dependencies:
   ```bash
   go mod tidy
   ```

2. Run the function locally:
   ```bash
   go run cmd/main.go
   ```

3. Test the function:
   ```bash
   curl -X POST http://localhost:8080 -H "Content-Type: application/json" -d '{"num1": 10, "num2": 25}'
   ```
   Expected output: `{"result":35}`

## Deployment to Google Cloud Functions (2nd Gen)

1. Deploy using gcloud:
   ```bash
   gcloud functions deploy calculator-function \
     --gen2 \
     --runtime=go122 \
     --region=us-central1 \
     --source=. \
     --entry-point=Calculate \
     --trigger-http \
     --allow-unauthenticated
   ```

2. After deployment, you will receive a URL (e.g., `https://calculator-function-xyz-uc.a.run.app`).

## Deployment to Cloud Run (Alternative)

Since this uses the Functions Framework, it behaves like a standard web server on port 8080.

1. Build container:
   ```bash
   gcloud builds submit --tag gcr.io/PROJECT_ID/calculator-function
   ```

2. Deploy to Cloud Run:
   ```bash
   gcloud run deploy calculator-function \
     --image gcr.io/PROJECT_ID/calculator-function \
     --platform managed \
     --allow-unauthenticated
   ```
