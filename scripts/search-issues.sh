#!/bin/bash

# search-issues.sh - Search through issues by content, title, or metadata
# Usage: ./search-issues.sh <query> [--field=title|content|labels|all] [--status=backlog|in-progress|review|done]

set -e

ISSUES_DIR=".issues"

# Colors
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

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

# Search in specific field
search_field() {
    local file="$1"
    local query="$2"
    local field="$3"
    
    case "$field" in
        "title")
            local title=$(extract_metadata "$file" "title" | tr -d '"')
            if [[ "$title" =~ $query ]]; then
                return 0
            fi
            ;;
        "labels")
            local labels=$(extract_metadata "$file" "labels")
            if [[ "$labels" =~ $query ]]; then
                return 0
            fi
            ;;
        "content")
            # Search in the content body (after frontmatter)
            if awk '/^---$/{if(p) exit; p=1; next} p' "$file" | grep -qi "$query"; then
                return 0
            fi
            ;;
        "all")
            # Search in title
            local title=$(extract_metadata "$file" "title" | tr -d '"')
            if [[ "$title" =~ $query ]]; then
                return 0
            fi
            
            # Search in labels
            local labels=$(extract_metadata "$file" "labels")
            if [[ "$labels" =~ $query ]]; then
                return 0
            fi
            
            # Search in content
            if awk '/^---$/{if(p) exit; p=1; next} p' "$file" | grep -qi "$query"; then
                return 0
            fi
            ;;
    esac
    
    return 1
}

# Highlight matching text
highlight_matches() {
    local text="$1"
    local query="$2"
    
    # Case-insensitive highlighting
    echo "$text" | sed "s/$query/${YELLOW}&${NC}/gi"
}

# Display search result
display_result() {
    local file="$1"
    local query="$2"
    local field="$3"
    
    local id=$(extract_metadata "$file" "id" | tr -d '"')
    local title=$(extract_metadata "$file" "title" | tr -d '"')
    local priority=$(extract_metadata "$file" "priority" | tr -d '"')
    local status=$(basename "$(dirname "$file")")
    local labels=$(extract_metadata "$file" "labels" | tr -d '[]"' | tr ',' ' ')
    
    # Status color
    case "$status" in
        "backlog") local status_color="$BLUE" ;;
        "in-progress") local status_color="$YELLOW" ;;
        "review") local status_color="$RED" ;;
        "done") local status_color="$GREEN" ;;
        *) local status_color="$NC" ;;
    esac
    
    echo -e "${status_color}■${NC} $id: $(highlight_matches "$title" "$query") ${status_color}($status, $priority)${NC}"
    
    if [ -n "$labels" ]; then
        echo -e "  Labels: $(highlight_matches "$labels" "$query")"
    fi
    
    # Show matching content snippets if searching in content
    if [[ "$field" == "content" || "$field" == "all" ]]; then
        local content_matches=$(awk '/^---$/{if(p) exit; p=1; next} p' "$file" | grep -ni "$query" | head -3)
        if [ -n "$content_matches" ]; then
            echo -e "  ${GREEN}Content matches:${NC}"
            echo "$content_matches" | while IFS= read -r line; do
                local line_num=$(echo "$line" | cut -d':' -f1)
                local line_content=$(echo "$line" | cut -d':' -f2-)
                echo -e "    Line $line_num: $(highlight_matches "$line_content" "$query")"
            done
        fi
    fi
    
    echo -e "  File: $file"
    echo ""
}

# Main search function
search_issues() {
    local query="$1"
    local field="$2"
    local status_filter="$3"
    local found_count=0
    
    echo -e "${GREEN}🔍 Searching for: \"$query\"${NC}"
    if [ "$field" != "all" ]; then
        echo -e "Field: $field"
    fi
    if [ -n "$status_filter" ]; then
        echo -e "Status: $status_filter"
    fi
    echo ""
    
    for status_dir in "$ISSUES_DIR"/*; do
        if [ ! -d "$status_dir" ]; then continue; fi
        
        local status=$(basename "$status_dir")
        
        # Skip if filtering by status
        if [ -n "$status_filter" ] && [ "$status" != "$status_filter" ]; then
            continue
        fi
        
        for issue_file in "$status_dir"/*.md; do
            if [ ! -f "$issue_file" ]; then continue; fi
            
            if search_field "$issue_file" "$query" "$field"; then
                display_result "$issue_file" "$query" "$field"
                ((found_count++))
            fi
        done
    done
    
    if [ $found_count -eq 0 ]; then
        echo -e "${RED}No issues found matching: \"$query\"${NC}"
        exit 1
    else
        echo -e "${GREEN}Found $found_count issue(s) matching: \"$query\"${NC}"
    fi
}

# Show recent issues
show_recent() {
    local count="${1:-10}"
    
    echo -e "${GREEN}📅 $count Most Recently Updated Issues${NC}"
    echo ""
    
    # Find all issues and sort by updated date
    local temp_file=$(mktemp)
    
    for status_dir in "$ISSUES_DIR"/*; do
        if [ ! -d "$status_dir" ]; then continue; fi
        
        for issue_file in "$status_dir"/*.md; do
            if [ ! -f "$issue_file" ]; then continue; fi
            
            local updated=$(extract_metadata "$issue_file" "updated_at" | tr -d '"')
            echo "$updated|$issue_file" >> "$temp_file"
        done
    done
    
    # Sort by date (newest first) and take top N
    sort -r "$temp_file" | head -n "$count" | while IFS='|' read -r date file; do
        local id=$(extract_metadata "$file" "id" | tr -d '"')
        local title=$(extract_metadata "$file" "title" | tr -d '"')
        local status=$(basename "$(dirname "$file")")
        local priority=$(extract_metadata "$file" "priority" | tr -d '"')
        
        case "$status" in
            "backlog") local status_color="$BLUE" ;;
            "in-progress") local status_color="$YELLOW" ;;
            "review") local status_color="$RED" ;;
            "done") local status_color="$GREEN" ;;
            *) local status_color="$NC" ;;
        esac
        
        echo -e "${status_color}■${NC} $id: $title ${status_color}($status, $priority)${NC}"
        echo -e "  Updated: $date"
        echo ""
    done
    
    rm "$temp_file"
}

# Main function
main() {
    local query=""
    local field="all"
    local status_filter=""
    local recent_count=""
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --field=*)
                field="${1#*=}"
                shift
                ;;
            --status=*)
                status_filter="${1#*=}"
                shift
                ;;
            --recent)
                recent_count="10"
                shift
                ;;
            --recent=*)
                recent_count="${1#*=}"
                shift
                ;;
            --help|-h)
                echo "Usage: $0 <query> [options]"
                echo ""
                echo "Options:"
                echo "  --field=FIELD    Search in specific field: title, content, labels, all (default)"
                echo "  --status=STATUS  Filter by status: backlog, in-progress, review, done"
                echo "  --recent[=N]     Show N most recent issues (default: 10)"
                echo ""
                echo "Examples:"
                echo "  $0 \"dark mode\"                    # Search for 'dark mode' in all fields"
                echo "  $0 \"bug\" --field=title            # Search for 'bug' in titles only"
                echo "  $0 \"ui\" --status=in-progress      # Search for 'ui' in in-progress issues"
                echo "  $0 --recent                         # Show 10 most recent issues"
                echo "  $0 --recent=5                       # Show 5 most recent issues"
                exit 0
                ;;
            -*)
                echo "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
                ;;
            *)
                if [ -z "$query" ]; then
                    query="$1"
                else
                    echo "Error: Multiple queries not supported"
                    exit 1
                fi
                shift
                ;;
        esac
    done
    
    # Check if issues directory exists
    if [ ! -d "$ISSUES_DIR" ]; then
        echo "Error: $ISSUES_DIR directory not found. Are you in the project root?"
        exit 1
    fi
    
    # Handle recent issues
    if [ -n "$recent_count" ]; then
        show_recent "$recent_count"
        exit 0
    fi
    
    # Require query for search
    if [ -z "$query" ]; then
        echo "Error: Search query required"
        echo "Use --help for usage information"
        exit 1
    fi
    
    # Validate field
    case "$field" in
        title|content|labels|all)
            ;;
        *)
            echo "Error: Invalid field '$field'. Use: title, content, labels, or all"
            exit 1
            ;;
    esac
    
    # Validate status filter
    if [ -n "$status_filter" ]; then
        case "$status_filter" in
            backlog|in-progress|review|done)
                ;;
            *)
                echo "Error: Invalid status '$status_filter'. Use: backlog, in-progress, review, or done"
                exit 1
                ;;
        esac
    fi
    
    # Perform search
    search_issues "$query" "$field" "$status_filter"
}

main "$@"