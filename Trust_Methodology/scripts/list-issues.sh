#!/bin/bash

# list-issues.sh - List issues by status or show all
# Usage: ./list-issues.sh [status] [--format=table|json|brief]

set -e

ISSUES_DIR=".issues"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Priority colors
get_priority_color() {
    case "$1" in
        "high") echo "$RED" ;;
        "medium") echo "$YELLOW" ;;
        "low") echo "$GREEN" ;;
        *) echo "$NC" ;;
    esac
}

# Status colors
get_status_color() {
    case "$1" in
        "backlog") echo "$CYAN" ;;
        "in-progress") echo "$BLUE" ;;
        "review") echo "$PURPLE" ;;
        "done") echo "$GREEN" ;;
        *) echo "$NC" ;;
    esac
}

# Extract metadata from issue file
extract_metadata() {
    local file="$1"
    local field="$2"
    
    # Extract YAML frontmatter field
    awk -v field="$field" '
        BEGIN { in_frontmatter=0; found=0 }
        /^---$/ { 
            if (in_frontmatter) exit
            else { in_frontmatter=1; next }
        }
        in_frontmatter && $0 ~ "^" field ":" {
            gsub("^" field ": *\"?|\"?$", "")
            print
            found=1
            exit
        }
    ' "$file"
}

# List issues in table format
list_table() {
    local status_filter="$1"
    
    printf "%-8s %-12s %-8s %-50s %-10s %-12s\n" "ID" "STATUS" "PRIORITY" "TITLE" "ASSIGNEE" "UPDATED"
    printf "%-8s %-12s %-8s %-50s %-10s %-12s\n" "--------" "------------" "--------" "--------------------------------------------------" "----------" "------------"
    
    for status_dir in "$ISSUES_DIR"/*; do
        if [ ! -d "$status_dir" ]; then continue; fi
        
        local status=$(basename "$status_dir")
        
        # Skip if filtering by status
        if [ -n "$status_filter" ] && [ "$status" != "$status_filter" ]; then
            continue
        fi
        
        for issue_file in "$status_dir"/*.md; do
            if [ ! -f "$issue_file" ]; then continue; fi
            
            local id=$(extract_metadata "$issue_file" "id" | tr -d '"')
            local title=$(extract_metadata "$issue_file" "title" | tr -d '"')
            local priority=$(extract_metadata "$issue_file" "priority" | tr -d '"')
            local assignee=$(extract_metadata "$issue_file" "assignees" | tr -d '[]"' | cut -d',' -f1)
            local updated=$(extract_metadata "$issue_file" "updated_at" | tr -d '"' | cut -d' ' -f1)
            
            # Truncate title if too long
            if [ ${#title} -gt 48 ]; then
                title="${title:0:45}..."
            fi
            
            # Color coding
            local status_color=$(get_status_color "$status")
            local priority_color=$(get_priority_color "$priority")
            
            printf "${status_color}%-8s${NC} ${status_color}%-12s${NC} ${priority_color}%-8s${NC} %-50s %-10s %-12s\n" \
                "$id" "$status" "$priority" "$title" "$assignee" "$updated"
        done
    done
}

# List issues in brief format
list_brief() {
    local status_filter="$1"
    
    for status_dir in "$ISSUES_DIR"/*; do
        if [ ! -d "$status_dir" ]; then continue; fi
        
        local status=$(basename "$status_dir")
        
        # Skip if filtering by status
        if [ -n "$status_filter" ] && [ "$status" != "$status_filter" ]; then
            continue
        fi
        
        local status_color=$(get_status_color "$status")
        local count=$(ls -1 "$status_dir"/*.md 2>/dev/null | wc -l | tr -d ' ')
        
        if [ "$count" -gt 0 ]; then
            echo -e "${status_color}▶ ${status^^} ($count issues)${NC}"
            
            for issue_file in "$status_dir"/*.md; do
                if [ ! -f "$issue_file" ]; then continue; fi
                
                local id=$(extract_metadata "$issue_file" "id" | tr -d '"')
                local title=$(extract_metadata "$issue_file" "title" | tr -d '"')
                local priority=$(extract_metadata "$issue_file" "priority" | tr -d '"')
                
                local priority_color=$(get_priority_color "$priority")
                echo -e "  ${priority_color}●${NC} $id: $title ${priority_color}($priority)${NC}"
            done
            echo ""
        fi
    done
}

# List issues in JSON format
list_json() {
    local status_filter="$1"
    local issues=()
    
    echo "["
    local first=true
    
    for status_dir in "$ISSUES_DIR"/*; do
        if [ ! -d "$status_dir" ]; then continue; fi
        
        local status=$(basename "$status_dir")
        
        # Skip if filtering by status
        if [ -n "$status_filter" ] && [ "$status" != "$status_filter" ]; then
            continue
        fi
        
        for issue_file in "$status_dir"/*.md; do
            if [ ! -f "$issue_file" ]; then continue; fi
            
            if [ "$first" = true ]; then
                first=false
            else
                echo ","
            fi
            
            # Extract all metadata and create JSON object
            local id=$(extract_metadata "$issue_file" "id" | tr -d '"')
            local number=$(extract_metadata "$issue_file" "number")
            local title=$(extract_metadata "$issue_file" "title" | tr -d '"')
            local priority=$(extract_metadata "$issue_file" "priority" | tr -d '"')
            local author=$(extract_metadata "$issue_file" "author" | tr -d '"')
            local created=$(extract_metadata "$issue_file" "created_at" | tr -d '"')
            local updated=$(extract_metadata "$issue_file" "updated_at" | tr -d '"')
            
            jq -n \
                --arg id "$id" \
                --arg number "$number" \
                --arg title "$title" \
                --arg status "$status" \
                --arg priority "$priority" \
                --arg author "$author" \
                --arg created "$created" \
                --arg updated "$updated" \
                --arg file "$issue_file" \
                '{
                    id: $id,
                    number: ($number | tonumber),
                    title: $title,
                    status: $status,
                    priority: $priority,
                    author: $author,
                    created_at: $created,
                    updated_at: $updated,
                    file_path: $file
                }' | tr -d '\n'
        done
    done
    
    echo ""
    echo "]"
}

# Show statistics
show_stats() {
    echo -e "${CYAN}📊 Issue Statistics${NC}"
    echo ""
    
    local total=0
    for status_dir in "$ISSUES_DIR"/*; do
        if [ ! -d "$status_dir" ]; then continue; fi
        
        local status=$(basename "$status_dir")
        local count=$(ls -1 "$status_dir"/*.md 2>/dev/null | wc -l | tr -d ' ')
        local status_color=$(get_status_color "$status")
        
        printf "${status_color}%-12s${NC}: %s\n" "${status^}" "$count"
        total=$((total + count))
    done
    
    echo ""
    printf "%-12s: %s\n" "Total" "$total"
}

# Main function
main() {
    local status_filter=""
    local format="table"
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            backlog|in-progress|review|done)
                status_filter="$1"
                shift
                ;;
            --format=*)
                format="${1#*=}"
                shift
                ;;
            --stats)
                show_stats
                exit 0
                ;;
            --help|-h)
                echo "Usage: $0 [status] [--format=table|json|brief] [--stats]"
                echo ""
                echo "Arguments:"
                echo "  status    Filter by status: backlog, in-progress, review, done"
                echo "  --format  Output format: table (default), json, brief"
                echo "  --stats   Show issue statistics"
                echo ""
                echo "Examples:"
                echo "  $0                    # List all issues in table format"
                echo "  $0 backlog            # List only backlog issues"
                echo "  $0 --format=brief     # List all issues in brief format"
                echo "  $0 in-progress --format=json  # List in-progress issues as JSON"
                exit 0
                ;;
            *)
                echo "Unknown argument: $1"
                echo "Use --help for usage information"
                exit 1
                ;;
        esac
    done
    
    # Check if issues directory exists
    if [ ! -d "$ISSUES_DIR" ]; then
        echo "Error: $ISSUES_DIR directory not found. Are you in the project root?"
        exit 1
    fi
    
    # Execute based on format
    case "$format" in
        table)
            list_table "$status_filter"
            ;;
        brief)
            list_brief "$status_filter"
            ;;
        json)
            list_json "$status_filter"
            ;;
        *)
            echo "Error: Unknown format '$format'. Use table, brief, or json."
            exit 1
            ;;
    esac
}

# Check for required dependencies
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed."
    echo "Install with: brew install jq (macOS) or apt-get install jq (Ubuntu)"
    exit 1
fi

main "$@"