#!/bin/bash

# setup_new_project.sh - Set up Trust methodology for a new project
# Usage: ./setup_new_project.sh /path/to/new/project "Project Name"

set -e

# Configuration
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
METHODOLOGY_SOURCE="$SCRIPT_DIR"
TARGET_DIR="$1"
PROJECT_NAME="$2"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Validate arguments
if [ -z "$TARGET_DIR" ] || [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 /path/to/new/project \"Project Name\""
    echo ""
    echo "Example: $0 /Users/jontiveros/Development/5_star_dashboards \"5 Star Dashboards\""
    exit 1
fi

# Check if methodology source exists
if [ ! -d "$METHODOLOGY_SOURCE" ]; then
    echo -e "${RED}Error: Trust methodology source not found at $METHODOLOGY_SOURCE${NC}"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${BLUE}📁 Creating project directory: $TARGET_DIR${NC}"
    mkdir -p "$TARGET_DIR"
fi

echo -e "${GREEN}🚀 Setting up Trust methodology for: $PROJECT_NAME${NC}"
echo "Target directory: $TARGET_DIR"
echo ""

# Copy methodology system to target
echo -e "${BLUE}📋 Copying Trust methodology system...${NC}"
cp -r "$METHODOLOGY_SOURCE" "$TARGET_DIR/trust_system"

# Initialize the issue tracking system
echo -e "${BLUE}⚙️ Initializing issue tracking system...${NC}"
cd "$TARGET_DIR/trust_system"
./scripts/init-issues.sh "$PROJECT_NAME"

echo ""
echo -e "${GREEN}✅ Trust methodology successfully set up!${NC}"
echo ""
echo "Next steps:"
echo "1. Navigate to your project:"
echo "   cd $TARGET_DIR"
echo ""
echo "2. Set up Claude Code custom commands:"
echo "   claude"
echo "   # Then add commands from: trust_system/docs/local_custom_commands.md"
echo ""
echo "3. Create your first issue:"
echo "   cd trust_system"
echo "   /local-issue-create \"Your first feature\""
echo ""
echo "4. Start developing with Trust methodology!"
echo ""
echo "Documentation available at: $TARGET_DIR/trust_system/docs/"