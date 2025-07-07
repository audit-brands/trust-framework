# Local Issue Tracker

A lightweight, file-based issue tracking system for managing development tasks locally without external dependencies.

## Overview

This tool provides a complete issue tracking workflow using only local files and shell scripts. It's designed for developers who need to track work privately or in environments where cloud-based tools aren't available.

## Features

- **100% Local**: All data stored as markdown files
- **Git Integration**: Automatic commits for issue state changes
- **Workflow States**: backlog → in-progress → review → done
- **Search & Filter**: Find issues by status, priority, or content
- **Claude Code Integration**: Custom commands for AI-assisted workflows

## Quick Start

### Setup in a New Project
```bash
./setup_new_project.sh /path/to/your/project "Project Name"
```

### Basic Commands
```bash
# Initialize issue tracking
./scripts/init-issues.sh "Project Name"

# Create a new issue
./scripts/create-issue.sh "Issue title" "high" "bug,frontend"

# List all issues
./scripts/list-issues.sh

# Move issue to in-progress
./scripts/move-issue.sh 1 in-progress "Starting work"

# Search issues
./scripts/search-issues.sh "search term"
```

## File Structure

```
.issues/
├── config.json         # System configuration
├── backlog/           # New issues
├── in-progress/       # Active work
├── review/            # Under review
└── done/              # Completed
```

## Issue Format

Issues are stored as markdown files with YAML frontmatter:

```yaml
---
issue_number: 1
title: "Example Issue"
status: "backlog"
priority: "medium"
labels: ["enhancement"]
created_at: "2025-01-07T10:00:00Z"
assignee: "developer"
---

## Description
Issue details here...

## Implementation Plan
- [ ] Task 1
- [ ] Task 2
```

## Claude Code Integration

For enhanced AI-assisted workflows, see `local_custom_commands.md` for Claude Code custom commands that integrate with this system.

## Why Local Issue Tracking?

- **Privacy**: Keep sensitive project details completely private
- **Offline Work**: No internet connection required
- **Version Control**: Issues tracked alongside code in git
- **Simplicity**: No external services or authentication
- **Flexibility**: Customize scripts for your workflow

---

*This tool is part of the Trust framework's collection of local-first development tools.*