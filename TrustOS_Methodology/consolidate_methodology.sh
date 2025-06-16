#!/bin/bash

# consolidate_methodology.sh - Consolidate trustos_methodology and trustos_methodology_system
# Usage: ./consolidate_methodology.sh

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🔄 Consolidating TrustOS Methodology System${NC}"
echo ""

# Create consolidated directory structure
echo -e "${BLUE}📁 Creating consolidated structure...${NC}"
mkdir -p trustos_methodology_consolidated/{docs,examples}

# Copy system files (scripts, templates, etc.)
echo -e "${BLUE}📋 Copying system files...${NC}"
cp -r trustos_methodology_system/.templates trustos_methodology_consolidated/
cp -r trustos_methodology_system/scripts trustos_methodology_consolidated/
cp trustos_methodology_system/README.md trustos_methodology_consolidated/

# Copy documentation
echo -e "${BLUE}📖 Copying documentation...${NC}"
cp -r trustos_methodology_system/docs/* trustos_methodology_consolidated/docs/
cp trustos_methodology/*.md trustos_methodology_consolidated/docs/

# Create example configuration
echo -e "${BLUE}⚙️ Creating example configuration...${NC}"
mkdir -p trustos_methodology_consolidated/examples/sample_project
cp -r trustos_methodology_system/.issues trustos_methodology_consolidated/examples/sample_project/

# Update the main README
cat > trustos_methodology_consolidated/README.md << 'EOF'
# TrustOS Methodology - Complete System

A comprehensive local development methodology based on Every.to's AI-driven engineering practices.

## Quick Setup for New Project

```bash
# Option 1: Use the setup script
./setup_new_project.sh /path/to/your/project "Project Name"

# Option 2: Manual setup
cp -r . /path/to/your/project/trustos_system
cd /path/to/your/project/trustos_system
./scripts/init-issues.sh "Project Name"
```

## What's Included

- **Scripts**: Complete CLI for issue management
- **Templates**: GitHub-like issue templates
- **Documentation**: Implementation guides and custom commands
- **Examples**: Sample configurations and workflows

## Key Benefits

- 🔒 **Privacy**: Keep sensitive code local
- 🤖 **AI Integration**: Claude Code custom commands
- 📈 **Compounding**: Each task makes future tasks easier
- ⚡ **Speed**: Research-driven development process

## Documentation

- [Implementation Runbook](docs/implementation_runbook.md) - Complete setup guide
- [Custom Commands](docs/local_custom_commands.md) - Claude Code integration
- [Development Process](docs/trustos_development_process.md) - Core methodology
- [GitHub Alternatives](docs/github_integration_alternatives.md) - Why local works

## Support

For issues or questions, refer to the documentation in the `docs/` directory.
EOF

# Create setup script for this version
cat > trustos_methodology_consolidated/setup_new_project.sh << 'EOF'
#!/bin/bash

# setup_new_project.sh - Set up TrustOS methodology for a new project
# Usage: ./setup_new_project.sh /path/to/new/project "Project Name"

set -e

TARGET_DIR="$1"
PROJECT_NAME="$2"

if [ -z "$TARGET_DIR" ] || [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 /path/to/new/project \"Project Name\""
    echo "Example: $0 /Users/user/my_project \"My Project\""
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "🚀 Setting up TrustOS methodology for: $PROJECT_NAME"
echo "Target: $TARGET_DIR"

# Create target directory
mkdir -p "$TARGET_DIR/trustos_system"

# Copy methodology system
cp -r "$SCRIPT_DIR"/* "$TARGET_DIR/trustos_system/"

# Initialize
cd "$TARGET_DIR/trustos_system"
./scripts/init-issues.sh "$PROJECT_NAME"

echo ""
echo "✅ Setup complete!"
echo "Next steps:"
echo "1. cd $TARGET_DIR/trustos_system"
echo "2. Set up Claude Code commands from docs/local_custom_commands.md"
echo "3. Create first issue: /local-issue-create \"Your first feature\""
EOF

chmod +x trustos_methodology_consolidated/setup_new_project.sh

echo ""
echo -e "${GREEN}✅ Consolidation complete!${NC}"
echo ""
echo "New consolidated structure created: trustos_methodology_consolidated/"
echo ""
echo "To use with your 5_star_dashboards project:"
echo "1. cd trustos_methodology_consolidated"
echo "2. ./setup_new_project.sh /Users/jontiveros/Development/5_star_dashboards \"5 Star Dashboards\""
echo ""
echo "Or keep the original separate folders if you prefer."