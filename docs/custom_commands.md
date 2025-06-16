# Custom Commands for TrustOS Development Process

## Issue Creation Command (CCI)

This is our foundational custom command that transforms brief text descriptions into fully researched GitHub issues.

### Command Structure

```
/issue-create [DESCRIPTION]
```

### Full Command Prompt

```markdown
# Issue Creation Command (CCI)

You are an expert software architect and product manager. Your task is to transform a brief feature/bug description into a comprehensive, actionable GitHub issue.

## Process Steps:

### 1. Codebase Research (5 minutes)
- Analyze the current codebase structure
- Identify existing patterns and architectures that relate to this request
- Find similar implementations or components already in the codebase
- Note any potential conflicts or dependencies

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

### 5. Generate GitHub Issue
Create a comprehensive GitHub issue with this structure:

```markdown
## 🎯 Problem Statement
[Clear description of what needs to be solved]

## 💡 Solution Vision  
[High-level approach to solving the problem]

## 📋 Requirements
### Functional Requirements
- [ ] Requirement 1
- [ ] Requirement 2

### Non-Functional Requirements
- [ ] Performance considerations
- [ ] Accessibility requirements
- [ ] Security implications

## 🏗️ Technical Implementation
### Files to Modify
- `path/to/file1.js` - [description of changes]
- `path/to/file2.js` - [description of changes]

### Implementation Steps
1. Step 1 with specific details
2. Step 2 with specific details
3. Step 3 with specific details

### Testing Strategy
- [ ] Unit tests for [specific functionality]
- [ ] Integration tests for [specific flows]
- [ ] Manual testing checklist

## 🤔 Questions for Review
- Question 1?
- Question 2?
- Question 3?

## 🚨 Potential Risks
- Risk 1 and mitigation strategy
- Risk 2 and mitigation strategy

## 📊 Success Metrics
- How will we know this is working correctly?
- What should we measure?

## 🔗 References
- [Link to relevant documentation]
- [Link to similar implementations]
- [Link to best practices articles]
```

## Human Review Checkpoint
Before implementation, present the issue for human review and ask:
1. "Does this approach align with your vision?"
2. "Are there any missing requirements or edge cases?"
3. "Should we adjust the technical approach based on your experience?"
4. "Are the success metrics appropriate?"

Only proceed to create the GitHub issue after human approval.
```

### How to Set Up This Command

1. **In Claude Code, create the custom command:**
   ```
   /config add-command issue-create "Issue Creation Command"
   ```

2. **Paste the full prompt above when prompted**

3. **Test the command:**
   ```
   /issue-create I want to add dark mode toggle to the settings page
   ```

### Usage Examples

#### Example 1: Feature Request
```
/issue-create Add infinite scroll to the email list so users don't have to paginate
```

#### Example 2: Bug Fix  
```
/issue-create Users are not receiving email notifications when they get new messages
```

#### Example 3: Technical Improvement
```
/issue-create Optimize database queries for the dashboard - it's loading slowly with large datasets
```

### Expected Output Flow

1. **Research Phase** (10-15 minutes)
   - Claude Code analyzes codebase
   - Searches web for best practices
   - Identifies patterns and potential issues

2. **Planning Phase** (5-8 minutes)
   - Creates detailed implementation plan
   - Identifies specific files and changes needed
   - Plans testing approach

3. **Human Review** (2-5 minutes)
   - Presents comprehensive issue for review
   - Asks clarifying questions
   - Refines based on feedback

4. **Issue Creation** (1-2 minutes)
   - Creates formatted GitHub issue
   - Adds to appropriate project board
   - Tags with relevant labels

### Tips for Success

- **Write naturally**: Describe your request as you would to a colleague
- **Be conversational**: Use plain language rather than technical jargon
- **Include context**: Mention user pain points or business reasons
- **Keep it brief**: A sentence or two is usually enough - let the research phase discover details
- **Don't over-specify**: Let the research phase discover the best technical approach

### Command Variants

Once the basic command works well, consider these variants:

- `/bug-report` - Specialized for bug fixes
- `/feature-research` - Research-only, no implementation plan
- `/quick-task` - Simplified version for small tasks
- `/epic-breakdown` - For large features that need to be broken into smaller issues

---

*This command is designed to evolve. Update the prompt based on what works well and what needs improvement.*