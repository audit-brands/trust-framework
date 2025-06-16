#!/bin/bash

# move-issue.sh - Move issue between states
# Usage: ./move-issue.sh <issue_number> <new_state> [comment]

set -e

ISSUES_DIR=".issues"
VALID_STATES=("backlog" "in-progress" "review" "done")

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Find issue file by number
find_issue_file() {
    local issue_number="$1"
    local issue_id="ISSUE-$issue_number"
    
    for status_dir in "$ISSUES_DIR"/*; do
        if [ ! -d "$status_dir" ]; then continue; fi
        
        for issue_file in "$status_dir"/*.md; do
            if [ ! -f "$issue_file" ]; then continue; fi
            
            # Check if this file contains our issue ID
            if grep -q "^id: \"$issue_id\"" "$issue_file"; then
                echo "$issue_file"
                return 0
            fi
        done
    done
    
    return 1
}

# Extract metadata from issue file
extract_metadata() {
    local file="$1"
    local field="$2"
    
    awk -v field="$field" '
        BEGIN { in_frontmatter=0 }
        /^---$/ { 
            if (in_frontmatter) exit
            else { in_frontmatter=1; next }
        }
        in_frontmatter && $0 ~ "^" field ":" {
            gsub("^" field ": *\"?|\"?$", "")
            print
            exit
        }
    ' "$file"
}

# Update metadata in issue file
update_metadata() {
    local file="$1"
    local field="$2"
    local value="$3"
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/^$field: .*/$field: \"$value\"/" "$file"
    else
        # Linux
        sed -i "s/^$field: .*/$field: \"$value\"/" "$file"
    fi
}

# Add comment to issue
add_comment() {
    local file="$1"
    local comment="$2"
    local author="$3"
    local timestamp="$4"
    
    # Find the comments section and add new comment
    local temp_file=$(mktemp)
    local in_comments=false
    local added_comment=false
    
    while IFS= read -r line; do
        echo "$line" >> "$temp_file"
        
        if [[ "$line" == "## 💬 Comments" ]]; then
            in_comments=true
        elif [[ $in_comments == true && "$line" == "---" && $added_comment == false ]]; then
            echo "" >> "$temp_file"
            echo "### $author - $timestamp" >> "$temp_file"
            echo "$comment" >> "$temp_file"
            added_comment=true
        fi
    done < "$file"
    
    # If we didn't find a comments section, add one
    if [[ $added_comment == false ]]; then
        echo "" >> "$temp_file"
        echo "### $author - $timestamp" >> "$temp_file"
        echo "$comment" >> "$temp_file"
    fi
    
    mv "$temp_file" "$file"
}

# Add activity log entry
add_activity_log() {
    local file="$1"
    local activity="$2"
    local author="$3"
    local timestamp="$4"
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "/^- \*\*Updated\*\*:/i\\
- **$timestamp**: $activity by $author
" "$file"
    else
        # Linux
        sed -i "/^- \*\*Updated\*\*:/i\\
- **$timestamp**: $activity by $author" "$file"
    fi
}

# Validate state
validate_state() {
    local state="$1"
    
    for valid_state in "${VALID_STATES[@]}"; do
        if [[ "$state" == "$valid_state" ]]; then
            return 0
        fi
    done
    
    return 1
}

# Get current state from file path
get_current_state() {
    local file_path="$1"
    basename "$(dirname "$file_path")"
}

# Main function
main() {
    local issue_number="$1"
    local new_state="$2"
    local comment="$3"
    
    if [ -z "$issue_number" ] || [ -z "$new_state" ]; then
        echo "Usage: $0 <issue_number> <new_state> [comment]"
        echo ""
        echo "Valid states: ${VALID_STATES[*]}"
        echo ""
        echo "Examples:"
        echo "  $0 1 in-progress                    # Move issue #1 to in-progress"
        echo "  $0 5 review \"Ready for review\"     # Move issue #5 to review with comment"
        echo "  $0 3 done \"Completed and tested\"  # Move issue #3 to done with comment"
        exit 1
    fi
    
    # Validate new state
    if ! validate_state "$new_state"; then
        echo -e "${RED}Error: Invalid state '$new_state'${NC}"
        echo "Valid states: ${VALID_STATES[*]}"
        exit 1
    fi
    
    # Find the issue file
    local issue_file
    if ! issue_file=$(find_issue_file "$issue_number"); then
        echo -e "${RED}Error: Issue #$issue_number not found${NC}"
        exit 1
    fi
    
    local current_state=$(get_current_state "$issue_file")
    
    # Check if already in target state
    if [[ "$current_state" == "$new_state" ]]; then
        echo -e "${YELLOW}Issue #$issue_number is already in '$new_state' state${NC}"
        exit 0
    fi
    
    # Get issue details for display
    local issue_id=$(extract_metadata "$issue_file" "id" | tr -d '"')
    local title=$(extract_metadata "$issue_file" "title" | tr -d '"')
    local author=$(git config user.name 2>/dev/null || echo "Unknown")
    local timestamp=$(date -u +"%Y-%m-%d %H:%M:%S")
    
    # Create new file path
    local filename=$(basename "$issue_file")
    local new_file_path="$ISSUES_DIR/$new_state/$filename"
    
    # Move the file
    mv "$issue_file" "$new_file_path"
    
    # Update metadata in the moved file
    update_metadata "$new_file_path" "state" "$new_state"
    update_metadata "$new_file_path" "updated_at" "$timestamp"
    update_metadata "$new_file_path" "project_board_column" "$new_state"
    
    # Handle state-specific updates
    case "$new_state" in
        "in-progress")
            update_metadata "$new_file_path" "status" "open"
            local activity="Moved to in-progress"
            ;;
        "review")
            update_metadata "$new_file_path" "status" "open"
            local activity="Moved to review"
            ;;
        "done")
            update_metadata "$new_file_path" "status" "closed"
            update_metadata "$new_file_path" "closed_at" "$timestamp"
            local activity="Completed and moved to done"
            ;;
        "backlog")
            update_metadata "$new_file_path" "status" "open"
            local activity="Moved back to backlog"
            ;;
    esac
    
    # Add comment if provided
    if [ -n "$comment" ]; then
        add_comment "$new_file_path" "$comment" "$author" "$timestamp"
        activity="$activity - $comment"
    fi
    
    # Add activity log entry
    add_activity_log "$new_file_path" "$activity" "$author" "$timestamp"
    
    # Commit changes if in git repo
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git add "$new_file_path"
        
        # Remove old file from git if it was tracked
        if git ls-files --error-unmatch "$issue_file" > /dev/null 2>&1; then
            git rm "$issue_file" > /dev/null 2>&1 || true
        fi
        
        local commit_message="Move issue #$issue_number to $new_state: $title"
        if [ -n "$comment" ]; then
            commit_message="$commit_message - $comment"
        fi
        
        git commit -m "$commit_message"
    fi
    
    echo -e "${GREEN}✅ Successfully moved issue #$issue_number${NC}"
    echo "   Title: $title"
    echo "   From: $current_state → To: $new_state"
    
    if [ -n "$comment" ]; then
        echo "   Comment: $comment"
    fi
    
    echo "   File: $new_file_path"
    
    # Show next steps based on state
    case "$new_state" in
        "in-progress")
            echo ""
            echo "Next steps:"
            echo "• Create feature branch: git checkout -b feature/$issue_id"
            echo "• Start implementing the solution"
            echo "• Move to review when ready: $0 $issue_number review"
            ;;
        "review")
            echo ""
            echo "Next steps:"
            echo "• Review the implementation"
            echo "• Test the changes"
            echo "• Move to done when approved: $0 $issue_number done"
            ;;
        "done")
            echo ""
            echo "🎉 Issue completed!"
            echo "• Merge feature branch if applicable"
            echo "• Deploy changes if needed"
            ;;
    esac
}

# Check if issues directory exists
if [ ! -d "$ISSUES_DIR" ]; then
    echo "Error: $ISSUES_DIR directory not found. Are you in the project root?"
    exit 1
fi

main "$@"