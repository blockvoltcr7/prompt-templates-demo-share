#!/bin/bash

# Configuration
FUNCTION_NAME="process-portfolio"
REGION="us-central1"
ENTRY_POINT="ProcessPortfolio"
RUNTIME="go125"

# ANSI color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color
YELLOW='\033[1;33m'

echo -e "${YELLOW}Starting deployment process for $FUNCTION_NAME...${NC}"

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "Error: gcloud CLI is not installed."
    exit 1
fi

# Get current project ID
PROJECT_ID=$(gcloud config get-value project)
echo -e "Deploying to Project: ${GREEN}$PROJECT_ID${NC}"
echo -e "Region: ${GREEN}$REGION${NC}"

# Enable necessary APIs
echo -e "${YELLOW}Enabling required Cloud APIs...${NC}"
gcloud services enable cloudfunctions.googleapis.com \
    run.googleapis.com \
    artifactregistry.googleapis.com \
    cloudbuild.googleapis.com

# Deploy the function
echo -e "${YELLOW}Deploying Cloud Function (Gen 2)...${NC}"
gcloud functions deploy $FUNCTION_NAME \
    --gen2 \
    --runtime=$RUNTIME \
    --region=$REGION \
    --source=. \
    --entry-point=$ENTRY_POINT \
    --trigger-http \
    --allow-unauthenticated

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Deployment successful!${NC}"
else
    echo "Deployment failed."
    exit 1
fi
