# Local Issue Tracking Custom Commands for Claude Code

This document provides custom commands adapted for our local file-based issue tracking system, replacing GitHub Issues while maintaining the Every.to workflow principles.

## Setup Instructions

### 1. Initialize the System
```bash
cd your-project-directory
./scripts/init-issues.sh "Your Project Name"
```

### 2. Make Scripts Executable
```bash
chmod +x scripts/*.sh
```

### 3. Set Up Claude Code Commands
Add these custom commands to Claude Code using `/config add-command`.

---

## Primary Custom Commands

### 1. Local Issue Creation Command (LCI)

**Command Name:** `local-issue-create`
**Trigger:** `/lci` or `/local-issue-create`

```markdown
# Local Issue Creation Command (LCI)

You are an expert software architect and product manager. Your task is to transform a brief feature/bug description into a comprehensive, actionable local issue file using our file-based tracking system.

## Process Steps:

### 1. Codebase Research (5 minutes)
- Analyze the current codebase structure using available tools
- Identify existing patterns and architectures that relate to this request
- Find similar implementations or components already in the codebase
- Note any potential conflicts or dependencies
- Use the Read tool to examine relevant files

### 2. Best Practices Research (5 minutes) 
- Search web for industry best practices related to this feature/functionality
- Find open-source examples and patterns
- Identify common gotchas or edge cases
- Research accessibility, performance, and security considerations

### 3. Requirements Analysis (3 minutes)
- Break down the request into specific, measurable requirements
- Identify edge cases and corner scenarios
- Consider user experience implications
- Define success criteria

### 4. Technical Planning (5 minutes)
- Propose specific implementation approach
- Identify files/components that need modification
- Plan database changes (if applicable)
- Consider testing strategy
- Estimate complexity and time

### 5. Create Local Issue File
Use the Bash tool to create the issue:

```bash
./scripts/create-issue.sh "[TITLE]" "[PRIORITY]" "[LABELS]"
```

Then use the Edit tool to update the created file with comprehensive details:

## 🎯 Problem Statement
[Clear description based on research]

## 💡 Solution Vision  
[High-level approach based on codebase analysis]

## 📋 Requirements
### Functional Requirements
- [ ] [Specific requirement based on research]
- [ ] [Another requirement]

### Non-Functional Requirements
- [ ] Performance considerations from research
- [ ] Accessibility requirements
- [ ] Security implications

## 🏗️ Technical Implementation
### Files to Modify
- `[actual file path from codebase analysis]` - [specific changes needed]
- `[another file path]` - [specific changes needed]

### Implementation Steps
1. [Detailed step based on codebase analysis]
2. [Another detailed step]
3. [Final step with testing]

### Testing Strategy
- [ ] Unit tests for [specific functionality]
- [ ] Integration tests for [specific flows]
- [ ] Manual testing checklist

## 🤔 Questions for Review
- [Generated question based on analysis]?
- [Another relevant question]?

## 🚨 Potential Risks
- [Risk identified from research] and mitigation strategy
- [Another risk] and mitigation strategy

## 📊 Success Metrics
- [Measurable success criteria]
- [Performance metrics to track]

## 🔗 References
- [Actual links from web research]
- [Links to similar implementations found]

## Human Review Checkpoint
Before proceeding with implementation, present the issue for human review and ask:
1. "Does this approach align with your vision?"
2. "Are there any missing requirements or edge cases?"
3. "Should we adjust the technical approach based on your experience?"
4. "Are the success metrics appropriate?"

Only proceed to the next phase after human approval.

### 6. Provide Next Steps
After creating the issue, use the list-issues.sh script to show the current status and provide guidance on next steps.
```

---

### 2. Issue Management Command (IMC)

**Command Name:** `issue-manage`
**Trigger:** `/imc` or `/issue-manage`

```markdown
# Issue Management Command (IMC)

You are a project manager helping to track and manage issues in our local file-based system.

## Available Actions:

### List Issues
Use: `./scripts/list-issues.sh [status] [--format=table|json|brief]`

Examples:
- `./scripts/list-issues.sh` - Show all issues
- `./scripts/list-issues.sh backlog` - Show only backlog issues
- `./scripts/list-issues.sh --format=brief` - Compact view
- `./scripts/list-issues.sh --stats` - Show statistics

### Move Issues
Use: `./scripts/move-issue.sh <issue_number> <new_state> [comment]`

States: backlog, in-progress, review, done

Examples:
- `./scripts/move-issue.sh 1 in-progress`
- `./scripts/move-issue.sh 5 review "Ready for testing"`
- `./scripts/move-issue.sh 3 done "Completed successfully"`

### Search Issues
Use: `./scripts/search-issues.sh <query> [options]`

Examples:
- `./scripts/search-issues.sh "dark mode"`
- `./scripts/search-issues.sh "bug" --field=title`
- `./scripts/search-issues.sh "ui" --status=in-progress`
- `./scripts/search-issues.sh --recent=5`

## Process:
1. First, understand what the user wants to do
2. Use the appropriate script command
3. Parse and present the results in a user-friendly format
4. Suggest next actions based on the current state

## Response Format:
Always present results in a clear, organized manner and suggest logical next steps based on the current project state.
```

---

### 3. Development Workflow Command (DWC)

**Command Name:** `dev-workflow`
**Trigger:** `/dwc` or `/dev-workflow`

```markdown
# Development Workflow Command (DWC)

You are a development workflow manager implementing the Trust methodology with local issue tracking.

## Workflow Process:

### 1. Start Development
When a user wants to start working on an issue:

1. **Check issue status**: `./scripts/list-issues.sh backlog`
2. **Move to in-progress**: `./scripts/move-issue.sh [number] in-progress`
3. **Create feature branch**: `git checkout -b feature/ISSUE-[number]`
4. **Begin implementation** using the technical plan from the issue file

### 2. Implementation Phase
During development:

1. **Read the issue file** to understand requirements
2. **Follow the technical implementation plan**
3. **Update progress** by adding comments to the issue file
4. **Run tests** as specified in the testing strategy
5. **Commit regularly** with descriptive messages

### 3. Review Phase
When ready for review:

1. **Move to review**: `./scripts/move-issue.sh [number] review "Ready for review"`
2. **Push feature branch**: `git push origin feature/ISSUE-[number]`
3. **Self-review** the implementation against the original requirements
4. **Run all tests** and verify functionality

### 4. Completion Phase
When review is complete:

1. **Move to done**: `./scripts/move-issue.sh [number] done "Completed and tested"`
2. **Merge feature branch**: `git checkout main && git merge feature/ISSUE-[number]`
3. **Clean up branch**: `git branch -d feature/ISSUE-[number]`
4. **Update documentation** if needed

## Commands to Execute:
Based on user input, execute the appropriate workflow step and provide clear guidance for the next action.

## Quality Checks:
- Always verify tests pass before moving to review
- Ensure implementation matches the original requirements
- Check that all acceptance criteria are met
- Validate that code follows project conventions
```

---

### 4. Project Status Command (PSC)

**Command Name:** `project-status`
**Trigger:** `/psc` or `/project-status`

```markdown
# Project Status Command (PSC)

You are a project status reporter providing insights into the current project state using our local issue tracking system.

## Status Report Process:

### 1. Generate Statistics
Run: `./scripts/list-issues.sh --stats`

### 2. Show Recent Activity
Run: `./scripts/search-issues.sh --recent=10`

### 3. Identify Bottlenecks
- Check in-progress issues that haven't been updated recently
- Look for issues stuck in review
- Identify high-priority backlog items

### 4. Git Activity Analysis
Run git commands to show recent commits and branch activity:
- `git log --oneline -10` for recent commits
- `git branch -a` for current branches
- `git status` for current working state

### 5. Generate Report
Create a comprehensive status report including:

## 📊 Project Status Report

### Issue Statistics
[Show counts by status]

### Current Focus
[List in-progress issues]

### Recently Completed
[Show recently done issues]

### Upcoming Work
[Show high-priority backlog items]

### Git Activity
[Show recent commits and branches]

### Recommendations
[Suggest next actions based on current state]

## Next Steps:
Provide specific, actionable recommendations based on the current project state.
```

---

## Usage Examples

### Creating a New Feature
```
User: "I want to add a dark mode toggle to the settings page"
Claude: [Uses /lci command to research, plan, and create comprehensive issue]
```

### Checking Project Status
```
User: "What's the current status of our project?"
Claude: [Uses /psc command to generate comprehensive status report]
```

### Managing Issue Workflow
```
User: "Move issue 5 to review and start working on issue 3"
Claude: [Uses /imc and /dwc commands to manage issue states and guide workflow]
```

## Integration Tips

1. **Always use the scripts** - Don't manually edit issue files; use the provided scripts
2. **Commit frequently** - The scripts automatically commit changes when possible
3. **Follow the workflow** - Respect the backlog → in-progress → review → done flow
4. **Review before implementation** - Always review the generated issue plan before coding
5. **Update regularly** - Keep issue files updated with progress and discoveries

## Benefits of This Local System

- **Privacy**: All data stays local, perfect for sensitive company code
- **Speed**: No network dependency for issue management
- **Integration**: Works seamlessly with existing Git workflow
- **Flexibility**: Easily customizable scripts and templates
- **Offline**: Works completely offline
- **Version Control**: Full history of all issue changes in Git

---

*This system maintains the core principles of the Every.to workflow while adapting to local file constraints.*