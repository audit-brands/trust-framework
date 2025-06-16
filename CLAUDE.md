# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Overview

This is the **TrustOS Methodology System v1.0.0** - a complete local development methodology implementing Every.to's AI-driven engineering practices. It provides a local file-based alternative to GitHub Issues while maintaining full privacy and offline capability.

## Core Architecture

The system is built around **local file-based issue tracking** with shell script automation:

- **Issues stored as files** in `issues/` directory with YAML frontmatter
- **Workflow states**: backlog → in-progress → review → done  
- **Shell script suite** for all operations (create, list, move, search issues)
- **Git integration** with automatic commits and branch management
- **Claude Code custom commands** for AI-driven development workflow

## Essential Commands

### Project Setup
```bash
# Deploy to any new project
./setup_new_project.sh /path/to/project "Project Name"

# Initialize in current directory  
./scripts/init-issues.sh "Project Name"

# Check system version and health
./scripts/version.sh
```

### Issue Management (Primary Workflow)
```bash
# Create comprehensive issues with research
./scripts/create-issue.sh "Issue title" "priority" "label1,label2"

# List and filter issues
./scripts/list-issues.sh                    # All issues
./scripts/list-issues.sh backlog            # By status
./scripts/list-issues.sh --format=brief     # Compact view
./scripts/list-issues.sh --stats            # Statistics

# Move through workflow states
./scripts/move-issue.sh 1 in-progress "Starting work"
./scripts/move-issue.sh 1 review "Ready for testing"  
./scripts/move-issue.sh 1 done "Completed successfully"

# Search across all content
./scripts/search-issues.sh "search term"
./scripts/search-issues.sh --recent=5
```

## Claude Code Integration

The system includes 4 custom commands designed for Claude Code:

1. **`/local-issue-create`** - AI-powered issue creation with 15-20 minute research phase
2. **`/issue-manage`** - Issue listing, filtering, and status management
3. **`/dev-workflow`** - Development lifecycle management with Git integration
4. **`/project-status`** - Comprehensive project reporting and next steps

See `docs/local_custom_commands.md` for complete command definitions.

## Development Workflow

### Standard Process:
1. **Idea → Research**: Use `/local-issue-create` for AI-driven planning
2. **Human Review**: Always review generated issue plans before implementation
3. **Implementation**: Use `/dev-workflow` to manage Git branches and progress
4. **Quality**: Move through review phase with testing
5. **Completion**: Merge branches and mark issues done

### Key Principles:
- **"Fix at lowest value stage"** - catch problems during planning, not implementation
- **Compounding engineering** - each task should make future tasks easier
- **Long-running AI workflows** - aim for 15-25 minute continuous execution
- **Human review checkpoints** - maintain quality control

## File Structure

```
TrustOS_Methodology/
├── scripts/                  # Core management scripts
│   ├── init-issues.sh        # Initialize system
│   ├── create-issue.sh       # Create new issues
│   ├── list-issues.sh        # List/filter issues
│   ├── move-issue.sh         # Change issue states
│   ├── search-issues.sh      # Search functionality
│   └── version.sh            # System information
├── docs/                     # Complete documentation
├── setup_new_project.sh      # Deploy to new projects
└── issues/                   # Issue files (created after init)
```

## Working with Issues

### Issue File Format:
Issues are stored as markdown files with YAML frontmatter containing metadata (status, priority, labels, assignee, etc.) and full markdown content for requirements, implementation plans, and discussions.

### Always Use Scripts:
- **Never manually edit** issue files - use the provided scripts
- Scripts handle Git commits, metadata updates, and state transitions
- This ensures consistency and proper workflow tracking

## Dependencies

- **Git** - Version control integration
- **jq** - JSON processing for configuration  
- **Claude Code Pro/Max** - For unlimited AI agent usage

## Testing and Validation

No specific test framework - this is a shell script and documentation system. Validate by:
- Running `./scripts/version.sh` for system health
- Testing issue creation/management workflow
- Verifying Git integration works properly

## Privacy and Local Operation

This system operates **100% locally** with no external dependencies beyond Claude Code itself. All issue data, project information, and workflow state remains on your machine.