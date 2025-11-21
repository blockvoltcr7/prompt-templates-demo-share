#!/bin/bash
# Validate generated copilot-instructions.md file
# Usage: bash validate-output.sh

set -e

FILE=".github/copilot-instructions.md"

echo "🔍 Validating GitHub Copilot instructions..."
echo ""

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "❌ Error: $FILE does not exist"
    echo ""
    echo "Make sure you:"
    echo "  1. Are in your project root directory"
    echo "  2. Have run all 4 phases"
    echo "  3. Phase 1 completed successfully"
    exit 1
fi

echo "✅ File exists: $FILE"

# Check for placeholder text
if grep -q '\[e\.g\.,' "$FILE"; then
    echo "⚠️  Warning: File contains placeholder text [e.g., ...]"
    echo "   → Search for '[e.g.,' and replace with actual examples"
    echo ""
fi

if grep -q '\[pattern' "$FILE"; then
    echo "⚠️  Warning: File contains placeholder text [pattern ...]"
    echo "   → Search for '[pattern' and replace with actual patterns"
    echo ""
fi

# Check minimum length
LINES=$(wc -l < "$FILE")
if [ "$LINES" -lt 100 ]; then
    echo "⚠️  Warning: File seems short ($LINES lines)"
    echo "   → Expected: 200-500 lines"
    echo "   → This might be normal for small codebases"
    echo ""
elif [ "$LINES" -lt 200 ]; then
    echo "⚠️  Info: File is on the shorter side ($LINES lines)"
    echo "   → Expected: 200-500 lines"
    echo "   → Check if all 4 phases completed"
    echo ""
else
    echo "✅ File length: $LINES lines (within expected range)"
fi

# Check for "Generated:" marker (indicates Phase 4 completed)
if grep -q "Generated:" "$FILE"; then
    echo "✅ File appears complete (has generation timestamp)"
else
    echo "⚠️  Warning: File missing generation timestamp"
    echo "   → Phase 4 may not have completed"
    echo "   → Run phase-4-finalize-polish.md"
    echo ""
fi

# Check for main sections
echo ""
echo "📋 Checking for required sections..."

sections=(
    "## Technology Stack"
    "## Repository Structure"
    "## Architecture Guidelines"
    "## Coding Standards"
    "## Testing Conventions"
    "## Development Workflow"
)

missing_sections=0
for section in "${sections[@]}"; do
    if grep -q "$section" "$FILE"; then
        echo "✅ Found: $section"
    else
        echo "❌ Missing: $section"
        missing_sections=$((missing_sections + 1))
    fi
done

echo ""

if [ $missing_sections -eq 0 ]; then
    echo "✅ All required sections present"
else
    echo "⚠️  Warning: $missing_sections section(s) missing"
    echo "   → Check which phases completed successfully"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Validation Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "File: $FILE"
echo "Lines: $LINES"
echo "Missing sections: $missing_sections"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $missing_sections -eq 0 ] && [ "$LINES" -ge 200 ] && ! grep -q '\[e\.g\.,' "$FILE"; then
    echo "✅ Validation passed! File looks good."
    echo ""
    echo "Next steps:"
    echo "  1. Review file manually: cat .github/copilot-instructions.md"
    echo "  2. Commit to repository: git add .github/copilot-instructions.md"
    echo "  3. Push: git commit -m 'Add Copilot instructions' && git push"
    exit 0
else
    echo "⚠️  Validation complete with warnings"
    echo ""
    echo "Recommended actions:"
    if grep -q '\[e\.g\.,' "$FILE"; then
        echo "  → Replace placeholder text with actual examples"
    fi
    if [ "$LINES" -lt 200 ]; then
        echo "  → Verify all 4 phases completed successfully"
    fi
    if [ $missing_sections -gt 0 ]; then
        echo "  → Re-run phases that didn't complete"
    fi
    echo ""
    echo "For help: see docs/troubleshooting.md"
    exit 0
fi
