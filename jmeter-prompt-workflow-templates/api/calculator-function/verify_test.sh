#!/bin/bash

FUNCTION_NAME="calculator-function"
REGION="us-central1"

# ANSI color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color
BLUE='\033[0;34m'

echo "Retrieving service URL..."

# Get the URL of the deployed function
FUNCTION_URL=$(gcloud functions describe $FUNCTION_NAME --region=$REGION --format="value(serviceConfig.uri)")

if [ -z "$FUNCTION_URL" ]; then
    echo "Error: Could not retrieve Function URL. Is the function deployed?"
    exit 1
fi

echo -e "Target URL: ${GREEN}$FUNCTION_URL${NC}"

# Test Payload
PAYLOAD='{"num1": 50, "num2": 75.5}'

echo -e "${BLUE}Running Verification Test...${NC}"
echo "Sending request with payload: $PAYLOAD"

# Perform curl request
echo "Running: curl -s -X POST \"$FUNCTION_URL\" -H \"Content-Type: application/json\" -d '$PAYLOAD'"
RESPONSE=$(curl -s -X POST "$FUNCTION_URL" \
    -H "Content-Type: application/json" \
    -d "$PAYLOAD")

echo -e "Response Received: ${GREEN}$RESPONSE${NC}"

# Start simple validation
# We expect "result": 125.5
if [[ "$RESPONSE" == *"125.5"* ]]; then
    echo -e "${GREEN}✅ Test Passed! Calculation correct.${NC}"
else
    echo "❌ Test Failed. Unexpected response."
fi
