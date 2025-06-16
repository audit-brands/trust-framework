#!/bin/bash

# create-issue.sh - Create a new issue in the local tracking system
# Usage: ./create-issue.sh "Issue Title" [priority] [labels]

set -e

# Configuration
ISSUES_DIR=".issues"
TEMPLATES_DIR=".templates"
CONFIG_FILE=".issues/config.json"

# Ensure we're in the right directory
if [ ! -d "$ISSUES_DIR" ]; then
    echo "Error: $ISSUES_DIR directory not found. Are you in the project root?"
    exit 1
fi

# Get next issue number
get_next_issue_number() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "1"
        return
    fi
    
    LAST_NUMBER=$(jq -r '.last_issue_number // 0' "$CONFIG_FILE" 2>/dev/null || echo "0")
    echo $((LAST_NUMBER + 1))
}

# Update config with new issue number
update_config() {
    local number=$1
    local config_content
    
    if [ ! -f "$CONFIG_FILE" ]; then
        config_content='{"last_issue_number": 0, "created_issues": []}'
    else
        config_content=$(cat "$CONFIG_FILE")
    fi
    
    echo "$config_content" | jq \
        --arg number "$number" \
        --arg id "ISSUE-$number" \
        --arg date "$(date -u +"%Y-%m-%d %H:%M:%S")" \
        '.last_issue_number = ($number | tonumber) | .created_issues += [{"id": $id, "created_at": $date}]' \
        > "$CONFIG_FILE"
}

# Main function
main() {
    local title="$1"
    local priority="${2:-medium}"
    local labels="${3:-}"
    
    if [ -z "$title" ]; then
        echo "Usage: $0 \"Issue Title\" [priority] [labels]"
        echo "Example: $0 \"Add dark mode\" high \"feature,ui\""
        exit 1
    fi
    
    # Generate issue details
    local issue_number=$(get_next_issue_number)
    local issue_id="ISSUE-$issue_number"
    local current_date=$(date -u +"%Y-%m-%d %H:%M:%S")
    local author=$(git config user.name 2>/dev/null || echo "Unknown")
    local safe_title=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
    local filename="${issue_id}-${safe_title}.md"
    local filepath="$ISSUES_DIR/backlog/$filename"
    
    # Create issue file from template
    cp "$TEMPLATES_DIR/issue-template.md" "$filepath"
    
    # Replace placeholders in the file
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/ISSUE-000/$issue_id/g" "$filepath"
        sed -i '' "s/^number: 0/number: $issue_number/" "$filepath"
        sed -i '' "s/\\[TITLE\\]/$title/g" "$filepath"
        sed -i '' "s/priority: \"medium\"/priority: \"$priority\"/" "$filepath"
        sed -i '' "s/author: \"\"/author: \"$author\"/" "$filepath"
        sed -i '' "s/YYYY-MM-DD HH:MM:SS/$current_date/g" "$filepath"
        sed -i '' "s/\\[AUTHOR\\]/$author/g" "$filepath"
        sed -i '' "s/\\[DATE\\]/$current_date/g" "$filepath"
        
        if [ -n "$labels" ]; then
            local labels_json=$(echo "$labels" | tr ',' '\n' | jq -R . | jq -s . | tr -d '\n')
            sed -i '' "s/labels: \\[\\]/labels: $labels_json/" "$filepath"
        fi
    else
        # Linux
        sed -i "s/ISSUE-000/$issue_id/g" "$filepath"
        sed -i "s/^number: 0/number: $issue_number/" "$filepath"
        sed -i "s/\\[TITLE\\]/$title/g" "$filepath"
        sed -i "s/priority: \"medium\"/priority: \"$priority\"/" "$filepath"
        sed -i "s/author: \"\"/author: \"$author\"/" "$filepath"
        sed -i "s/YYYY-MM-DD HH:MM:SS/$current_date/g" "$filepath"
        sed -i "s/\\[AUTHOR\\]/$author/g" "$filepath"
        sed -i "s/\\[DATE\\]/$current_date/g" "$filepath"
        
        if [ -n "$labels" ]; then
            local labels_json=$(echo "$labels" | tr ',' '\n' | jq -R . | jq -s . | tr -d '\n')
            sed -i "s/labels: \\[\\]/labels: $labels_json/" "$filepath"
        fi
    fi
    
    # Update config
    update_config "$issue_number"
    
    # Add to git if we're in a git repo
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git add "$filepath" "$CONFIG_FILE"
        git commit -m "Add issue #$issue_number: $title"
    fi
    
    echo "✅ Created issue #$issue_number: $title"
    echo "   File: $filepath"
    echo "   Priority: $priority"
    echo "   Status: backlog"
    
    if [ -n "$labels" ]; then
        echo "   Labels: $labels"
    fi
    
    echo ""
    echo "Next steps:"
    echo "1. Edit the issue file to add requirements and technical details"
    echo "2. Move to in-progress when ready: ./scripts/move-issue.sh $issue_number in-progress"
    echo "3. Create branch: git checkout -b feature/$issue_id"
}

# Check for required dependencies
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed."
    echo "Install with: brew install jq (macOS) or apt-get install jq (Ubuntu)"
    exit 1
fi

main "$@"