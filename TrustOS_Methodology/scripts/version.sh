#!/bin/bash

# version.sh - Display Trust Methodology System version information
# Usage: ./version.sh

set -e

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Read version
VERSION=$(grep "Current Version:" "$PROJECT_DIR/VERSION.md" 2>/dev/null | cut -d' ' -f4 || echo "unknown")

# Read config for additional info
CONFIG_FILE="$PROJECT_DIR/.issues/config.json"
if [ -f "$CONFIG_FILE" ]; then
    PROJECT_NAME=$(jq -r '.project_name // "Unknown"' "$CONFIG_FILE" 2>/dev/null || echo "Unknown")
    INITIALIZED_AT=$(jq -r '.initialized_at // "Unknown"' "$CONFIG_FILE" 2>/dev/null || echo "Unknown")
    INITIALIZED_BY=$(jq -r '.initialized_by // "Unknown"' "$CONFIG_FILE" 2>/dev/null || echo "Unknown")
    LAST_ISSUE=$(jq -r '.last_issue_number // 0' "$CONFIG_FILE" 2>/dev/null || echo "0")
else
    PROJECT_NAME="Not initialized"
    INITIALIZED_AT="N/A"
    INITIALIZED_BY="N/A"
    LAST_ISSUE="0"
fi

echo -e "${GREEN}🔧 Trust Methodology System${NC}"
echo -e "${BLUE}Version:${NC} $VERSION"
echo ""
echo -e "${BLUE}Project Information:${NC}"
echo "  Name: $PROJECT_NAME"
echo "  Initialized: $INITIALIZED_AT"
echo "  Initialized by: $INITIALIZED_BY"
echo "  Total issues created: $LAST_ISSUE"
echo ""

# Check if Git repository
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${BLUE}Git Information:${NC}"
    echo "  Repository: $(git rev-parse --show-toplevel 2>/dev/null || echo "Unknown")"
    echo "  Current branch: $(git branch --show-current 2>/dev/null || echo "Unknown")"
    echo "  Last commit: $(git log -1 --format="%h - %s (%cr)" 2>/dev/null || echo "No commits")"
    echo ""
fi

# Check system health
echo -e "${BLUE}System Health:${NC}"
if [ -d "$PROJECT_DIR/.issues" ]; then
    BACKLOG_COUNT=$(ls -1 "$PROJECT_DIR/.issues/backlog"/*.md 2>/dev/null | wc -l | tr -d ' ')
    IN_PROGRESS_COUNT=$(ls -1 "$PROJECT_DIR/.issues/in-progress"/*.md 2>/dev/null | wc -l | tr -d ' ')
    REVIEW_COUNT=$(ls -1 "$PROJECT_DIR/.issues/review"/*.md 2>/dev/null | wc -l | tr -d ' ')
    DONE_COUNT=$(ls -1 "$PROJECT_DIR/.issues/done"/*.md 2>/dev/null | wc -l | tr -d ' ')
    
    echo "  Issues in backlog: $BACKLOG_COUNT"
    echo "  Issues in progress: $IN_PROGRESS_COUNT"
    echo "  Issues in review: $REVIEW_COUNT"
    echo "  Issues completed: $DONE_COUNT"
    echo -e "  Status: ${GREEN}✓ Healthy${NC}"
else
    echo -e "  Status: ${YELLOW}⚠ Not initialized${NC}"
fi

echo ""
echo -e "${BLUE}Quick Commands:${NC}"
echo "  ./scripts/list-issues.sh --stats    # Show detailed statistics"
echo "  ./scripts/create-issue.sh \"Title\"   # Create new issue"
echo "  ./scripts/search-issues.sh --recent # Show recent activity"