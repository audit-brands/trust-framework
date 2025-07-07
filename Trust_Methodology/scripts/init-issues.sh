#!/bin/bash

# init-issues.sh - Initialize the local issue tracking system
# Usage: ./init-issues.sh [project_name]

set -e

ISSUES_DIR=".issues"
TEMPLATES_DIR=".templates"
SCRIPTS_DIR="scripts"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Create directory structure
create_directories() {
    echo -e "${BLUE}📁 Creating directory structure...${NC}"
    
    mkdir -p "$ISSUES_DIR"/{backlog,in-progress,review,done}
    mkdir -p "$TEMPLATES_DIR"
    mkdir -p "$SCRIPTS_DIR"
    
    echo "   ✓ Created $ISSUES_DIR with status directories"
    echo "   ✓ Created $TEMPLATES_DIR for templates"
    echo "   ✓ Created $SCRIPTS_DIR for management scripts"
}

# Create initial config file
create_config() {
    local project_name="$1"
    local config_file="$ISSUES_DIR/config.json"
    
    echo -e "${BLUE}⚙️ Creating configuration...${NC}"
    
    cat > "$config_file" << EOF
{
  "project_name": "$project_name",
  "last_issue_number": 0,
  "created_issues": [],
  "settings": {
    "default_priority": "medium",
    "default_assignee": "",
    "auto_git_commit": true,
    "require_labels": false
  },
  "labels": [
    "bug",
    "feature",
    "enhancement",
    "documentation",
    "technical-debt",
    "urgent",
    "low-priority"
  ],
  "milestones": [],
  "system_version": "$(grep "Current Version:" VERSION.md 2>/dev/null | cut -d' ' -f4 || echo "unknown")",
  "initialized_at": "$(date -u +"%Y-%m-%d %H:%M:%S")",
  "initialized_by": "$(git config user.name 2>/dev/null || echo "Unknown")"
}
EOF
    
    echo "   ✓ Created $config_file"
}

# Create .gitignore entries
create_gitignore() {
    local gitignore_file=".gitignore"
    
    echo -e "${BLUE}📝 Updating .gitignore...${NC}"
    
    # Check if .gitignore exists
    if [ ! -f "$gitignore_file" ]; then
        touch "$gitignore_file"
    fi
    
    # Add entries if they don't exist
    local entries_to_add=(
        "# Issue tracking system"
        ".issues/config.json.bak"
        ".issues/temp/"
        "*.tmp"
    )
    
    for entry in "${entries_to_add[@]}"; do
        if ! grep -Fxq "$entry" "$gitignore_file"; then
            echo "$entry" >> "$gitignore_file"
        fi
    done
    
    echo "   ✓ Updated $gitignore_file with issue tracking entries"
}

# Create README for the issue system
create_readme() {
    local readme_file="$ISSUES_DIR/README.md"
    
    echo -e "${BLUE}📖 Creating documentation...${NC}"
    
    cat > "$readme_file" << 'EOF'
# Local Issue Tracking System

This directory contains a local file-based issue tracking system that mimics GitHub Issues functionality.

## Directory Structure

```
.issues/
├── backlog/        # New issues waiting to be started
├── in-progress/    # Issues currently being worked on
├── review/         # Issues ready for review
├── done/           # Completed issues
├── config.json     # System configuration
└── README.md       # This file
```

## Quick Start

### Create a new issue
```bash
./scripts/create-issue.sh "Add dark mode toggle"
```

### List all issues
```bash
./scripts/list-issues.sh
```

### Move issue to in-progress
```bash
./scripts/move-issue.sh 1 in-progress
```

### Search issues
```bash
./scripts/search-issues.sh "dark mode"
```

## Issue Lifecycle

1. **Backlog** - New issues, not yet started
2. **In Progress** - Currently being worked on
3. **Review** - Ready for code review/testing
4. **Done** - Completed and verified

## File Format

Each issue is stored as a Markdown file with YAML frontmatter containing metadata:

```yaml
---
id: "ISSUE-001"
title: "Add dark mode toggle"
status: "open"
state: "backlog"
priority: "medium"
labels: ["feature", "ui"]
---

# Issue content follows...
```

## Integration with Git

The system automatically commits changes to Git when:
- Creating new issues
- Moving issues between states
- Updating issue metadata

## Scripts

- `create-issue.sh` - Create new issues
- `list-issues.sh` - List and filter issues
- `move-issue.sh` - Move issues between states
- `search-issues.sh` - Search through issues
- `init-issues.sh` - Initialize the system

## Custom Commands

For use with Claude Code, see the custom commands in the methodology documentation.
EOF
    
    echo "   ✓ Created $readme_file"
}

# Make scripts executable
make_scripts_executable() {
    echo -e "${BLUE}🔧 Making scripts executable...${NC}"
    
    for script in "$SCRIPTS_DIR"/*.sh; do
        if [ -f "$script" ]; then
            chmod +x "$script"
            echo "   ✓ Made $(basename "$script") executable"
        fi
    done
}

# Initialize git repository if needed
init_git() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${YELLOW}📦 Initializing Git repository...${NC}"
        git init
        git config --local init.defaultBranch main 2>/dev/null || true
        echo "   ✓ Initialized Git repository"
    else
        echo -e "${GREEN}✓ Git repository already exists${NC}"
    fi
}

# Create initial commit
create_initial_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${BLUE}💾 Creating initial commit...${NC}"
        
        # Add all the files we created
        git add "$ISSUES_DIR/" "$TEMPLATES_DIR/" "$SCRIPTS_DIR/" .gitignore 2>/dev/null || true
        
        # Check if there are changes to commit
        if ! git diff --cached --quiet 2>/dev/null; then
            git commit -m "Initialize local issue tracking system

- Set up directory structure for issue management
- Add templates and management scripts
- Configure Git integration
- Create documentation"
            echo "   ✓ Created initial commit"
        else
            echo "   ✓ No changes to commit"
        fi
    fi
}

# Display success message and next steps
show_success() {
    local project_name="$1"
    
    echo ""
    echo -e "${GREEN}🎉 Successfully initialized issue tracking system for '$project_name'!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Create your first issue:"
    echo "   ./scripts/create-issue.sh \"Your first issue\""
    echo ""
    echo "2. List all issues:"
    echo "   ./scripts/list-issues.sh"
    echo ""
    echo "3. Set up Claude Code custom commands (see methodology docs)"
    echo ""
    echo "4. Start using the TrustOS development process!"
    echo ""
    echo "For more information, see: $ISSUES_DIR/README.md"
}

# Main function
main() {
    local project_name="${1:-$(basename "$(pwd)")}"
    
    local version=$(grep "Current Version:" VERSION.md 2>/dev/null | cut -d' ' -f4 || echo "unknown")
    echo -e "${GREEN}🚀 Initializing TrustOS Methodology System v${version}${NC}"
    echo "Project: $project_name"
    echo ""
    
    # Check if already initialized
    if [ -f "$ISSUES_DIR/config.json" ]; then
        echo -e "${YELLOW}⚠️  Issue tracking system already initialized${NC}"
        echo "To reinitialize, remove the $ISSUES_DIR directory first"
        exit 1
    fi
    
    # Run initialization steps
    create_directories
    create_config "$project_name"
    create_gitignore
    create_readme
    make_scripts_executable
    init_git
    create_initial_commit
    
    show_success "$project_name"
}

# Check dependencies
check_dependencies() {
    local missing_deps=()
    
    if ! command -v jq &> /dev/null; then
        missing_deps+=("jq")
    fi
    
    if ! command -v git &> /dev/null; then
        missing_deps+=("git")
    fi
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo -e "${RED}Error: Missing required dependencies: ${missing_deps[*]}${NC}"
        echo ""
        echo "Install missing dependencies:"
        for dep in "${missing_deps[@]}"; do
            case "$dep" in
                jq)
                    echo "  macOS: brew install jq"
                    echo "  Ubuntu: apt-get install jq"
                    ;;
                git)
                    echo "  macOS: brew install git"
                    echo "  Ubuntu: apt-get install git"
                    ;;
            esac
        done
        exit 1
    fi
}

# Parse arguments
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: $0 [project_name]"
    echo ""
    echo "Initialize a local file-based issue tracking system."
    echo ""
    echo "Arguments:"
    echo "  project_name    Name of the project (default: current directory name)"
    echo ""
    echo "This script will:"
    echo "  • Create directory structure for issues"
    echo "  • Set up configuration and templates"
    echo "  • Make management scripts executable"
    echo "  • Initialize Git repository if needed"
    echo "  • Create initial commit"
    exit 0
fi

check_dependencies
main "$@"