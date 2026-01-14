# Process Portfolio Function

This is a Google Cloud Function written in Go that accepts a list of stock holdings and returns the count.

## Prerequisites

- [Go 1.22+](https://go.dev/dl/)
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
   curl -X POST http://localhost:8080 -H "Content-Type: application/json" -d '{"holdings": ["AAPL", "GOOG", "TSLA"]}'
   ```
   Expected output: `{"size":3}`

## Deployment to Google Cloud Functions (2nd Gen)

1. Deploy using script:
   ```bash
   ./deploy.sh
   ```

2. Verify deployment:
   ```bash
   ./verify_test.sh
   ```
