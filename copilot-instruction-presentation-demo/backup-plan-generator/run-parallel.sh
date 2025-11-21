#!/bin/bash
#
# Parallel GitHub Copilot CLI Phase Execution
#
# This script runs all 4 phases in parallel using separate GitHub Copilot CLI instances.
# Each instance has built-in workspace awareness (#codebase, #search, etc.).
# No LangChain or RAG configuration needed!
#

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
OUTPUT_DIR=".github"
FINAL_OUTPUT="$OUTPUT_DIR/copilot-instructions.md"
PHASE_OUTPUTS_DIR=".copilot-phases"

# Create output directories
mkdir -p "$OUTPUT_DIR"
mkdir -p "$PHASE_OUTPUTS_DIR"

# Phase output files
PHASE1_OUTPUT="$PHASE_OUTPUTS_DIR/phase-1-tech-stack.md"
PHASE2_OUTPUT="$PHASE_OUTPUTS_DIR/phase-2-patterns.md"
PHASE3_OUTPUT="$PHASE_OUTPUTS_DIR/phase-3-testing.md"
PHASE4_OUTPUT="$PHASE_OUTPUTS_DIR/phase-4-security.md"

echo -e "${BLUE}🚀 Starting parallel phase execution...${NC}\n"

# Function to run a single phase
run_phase() {
    local phase_num=$1
    local phase_file=$2
    local output_file=$3

    echo -e "${YELLOW}[Phase $phase_num] Starting...${NC}"

    # Run GitHub Copilot CLI with the phase prompt
    # The CLI already has workspace awareness through #codebase, #search, etc.
    gh copilot chat -f "$phase_file" > "$output_file" 2>&1

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[Phase $phase_num] ✅ Completed${NC}"
    else
        echo -e "${RED}[Phase $phase_num] ❌ Failed${NC}"
        return 1
    fi
}

# Start timestamp
START_TIME=$(date +%s)

# Run all phases in parallel using background jobs
run_phase 1 "phase-1-tech-stack-discovery.md" "$PHASE1_OUTPUT" &
PID1=$!

run_phase 2 "phase-2-patterns-architecture.md" "$PHASE2_OUTPUT" &
PID2=$!

run_phase 3 "phase-3-testing-workflow.md" "$PHASE3_OUTPUT" &
PID3=$!

run_phase 4 "phase-4-finalize-polish.md" "$PHASE4_OUTPUT" &
PID4=$!

echo -e "${BLUE}All phases running in parallel...${NC}\n"

# Wait for all background jobs to complete
wait $PID1
RESULT1=$?

wait $PID2
RESULT2=$?

wait $PID3
RESULT3=$?

wait $PID4
RESULT4=$?

# End timestamp
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo -e "\n${BLUE}📊 Phase Execution Summary:${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Phase 1 (Tech Stack):    $([ $RESULT1 -eq 0 ] && echo -e "${GREEN}✅ Success${NC}" || echo -e "${RED}❌ Failed${NC}")"
echo -e "Phase 2 (Patterns):      $([ $RESULT2 -eq 0 ] && echo -e "${GREEN}✅ Success${NC}" || echo -e "${RED}❌ Failed${NC}")"
echo -e "Phase 3 (Testing):       $([ $RESULT3 -eq 0 ] && echo -e "${GREEN}✅ Success${NC}" || echo -e "${RED}❌ Failed${NC}")"
echo -e "Phase 4 (Security):      $([ $RESULT4 -eq 0 ] && echo -e "${GREEN}✅ Success${NC}" || echo -e "${RED}❌ Failed${NC}")"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Total Time:              ${DURATION}s"
echo ""

# Check if all phases succeeded
if [ $RESULT1 -eq 0 ] && [ $RESULT2 -eq 0 ] && [ $RESULT3 -eq 0 ] && [ $RESULT4 -eq 0 ]; then
    echo -e "${GREEN}✅ All phases completed successfully!${NC}\n"

    # Combine outputs into final file
    echo -e "${BLUE}📝 Combining outputs into final file...${NC}"

    cat > "$FINAL_OUTPUT" << EOF
# GitHub Copilot Instructions

> **Generated:** $(date -u +"%Y-%m-%dT%H:%M:%SZ")
> **Method:** Parallel Multi-Phase Analysis
> **Execution Time:** ${DURATION}s

---

EOF

    # Append each phase's output
    cat "$PHASE1_OUTPUT" >> "$FINAL_OUTPUT"
    echo "" >> "$FINAL_OUTPUT"

    cat "$PHASE2_OUTPUT" >> "$FINAL_OUTPUT"
    echo "" >> "$FINAL_OUTPUT"

    cat "$PHASE3_OUTPUT" >> "$FINAL_OUTPUT"
    echo "" >> "$FINAL_OUTPUT"

    cat "$PHASE4_OUTPUT" >> "$FINAL_OUTPUT"

    echo -e "${GREEN}✅ Final output created: $FINAL_OUTPUT${NC}"
    echo -e "\n${BLUE}📄 File size: $(wc -l < "$FINAL_OUTPUT") lines${NC}"

    # Optional: Clean up phase outputs
    # rm -rf "$PHASE_OUTPUTS_DIR"

else
    echo -e "${RED}❌ Some phases failed. Check outputs in $PHASE_OUTPUTS_DIR${NC}"
    exit 1
fi

echo -e "\n${GREEN}🎉 Parallel execution complete!${NC}"
