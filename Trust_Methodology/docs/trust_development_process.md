# Trust Development Process

*Based on insights from Kieran Klaassen and Nityesh Agarwal's workflow at Every (Cora team)*

## Core Philosophy: Compounding Engineering

Each piece of work should make the next piece easier. Build tools, prompts, and workflows that compound over time rather than doing one-off tasks.

## Primary Tools & Setup

### Claude Code as Central Hub
- **Primary tool**: Claude Code for research, planning, implementation, and coordination
- **Reasoning**: More general-purpose than coding-specific tools; can handle the full engineering workflow
- **Setup**: `claude` command in terminal with Pro/Max subscription for unlimited usage

### Multi-Agent Approach
- **Claude Code**: Research, planning, complex implementation
- **Friday**: UI-focused tasks (when available)  
- **Charlie**: Code reviews (when available)
- **Cursor/Windsurf**: File reading/editing when needed
- **Principle**: Use the best tool for each specific task type

## Development Workflow

### 1. Idea Capture & Initial Planning
- **Voice-to-text**: Use voice input for rapid idea capture (reduce friction)
- **Custom commands**: Create reusable prompts for common workflows
- **Parallel brainstorming**: Run multiple Claude Code instances simultaneously on different ideas

### 2. Research & Requirements (Critical Phase)
**"Fix problems at the lowest value stage"** - catch issues during planning, not implementation

#### Standard Research Process:
1. **Codebase grounding**: Let Claude Code understand existing patterns and architecture
2. **Best practices research**: Web search for open-source patterns and industry standards  
3. **Detailed planning**: Create comprehensive GitHub issues with:
   - Problem statement
   - Solution vision  
   - Technical requirements
   - Implementation steps
   - Corner cases and considerations

#### Human Review Requirements:
- **Always review plans before implementation**
- Look for red flags, missing requirements, incorrect assumptions
- Make research documents more engaging (user stories, Q&A format vs boring PRDs)
- Ask: "What questions would a good PM ask about this?"

### 3. Implementation
- **Let agents run long**: Aim for 15-25+ minute continuous runs
- **Include testing**: Always have agents write and run tests as part of implementation
- **Parallel execution**: Run multiple implementation tasks simultaneously
- **Social coding**: Work collaboratively on calls while agents execute

### 4. Quality Assurance
- **Traditional testing**: Smoke tests, unit tests, integration tests
- **Evals for prompts**: Test prompt reliability (run 10x, should pass consistently)  
- **Manual verification**: Quick manual checks of key functionality
- **Code reviews**: Use specialized tools (Charlie) or human review for critical changes

## Custom Commands & Automation

### Essential Custom Commands
1. **Issue Creation Command** (`CCI`): 
   - Input: Voice description of feature/bug
   - Output: Fully researched GitHub issue with implementation plan

2. **Status Commands**:
   - "What did we ship this week?" (git log analysis)
   - "What's in the pipeline?" (upcoming work analysis)

3. **Research Commands**:
   - Automated best practices research
   - Codebase pattern analysis
   - Competitive analysis

### Prompt Engineering Tips
- Use Anthropic's prompt improver tool for refining complex prompts
- Build prompts that create other prompts (meta-prompting)
- Make prompts ask clarifying questions vs outputting long documents
- Focus on user stories and practical examples vs technical specifications

## Key Principles

### 1. Planning Over Implementation  
- Spend more time on research and planning
- Detailed GitHub issues are investments in faster implementation
- Better to over-plan than to implement the wrong thing

### 2. Continuous Tool Evolution
- Regularly test new agents and tools
- Build custom workflows and commands as needs arise
- Share successful patterns with team

### 3. Human-AI Collaboration Patterns
- Human provides intuition, context, and taste
- AI handles research, implementation, and repetitive work
- Always maintain human review checkpoints

### 4. Leverage Existing Ecosystems
- Use GitHub, PRs, issue tracking (don't reinvent)
- Integrate with existing developer workflows
- Make it easy for humans to review and contribute

## Implementation Strategy

### Phase 1: Foundation
1. Set up Claude Code with Pro/Max subscription
2. Create first custom command for issue creation
3. Establish GitHub integration workflow
4. Practice voice-to-text input

### Phase 2: Workflow Development  
1. Build 3-5 core custom commands
2. Establish parallel execution patterns
3. Create quality assurance checklist
4. Document successful prompt patterns

### Phase 3: Optimization
1. Measure and optimize for longer Claude Code runs
2. Build meta-prompts that improve other prompts
3. Create agent specialization strategies
4. Establish collaborative working patterns

## Success Metrics

- **Agent run duration**: Aim for 15+ minute continuous execution
- **Issue-to-implementation time**: Track from idea to production
- **Human review efficiency**: Time spent on planning vs debugging
- **Compound effect**: How much faster each subsequent similar task becomes

## Common Pitfalls to Avoid

1. **Skipping human review**: Always review plans before implementation
2. **Over-relying on single agent**: Use specialized tools for specialized tasks  
3. **Insufficient testing**: Traditional tests and evals are still essential
4. **Rushing through planning**: Catch problems early in the process
5. **Not building compound workflows**: Each task should make future tasks easier

---

*This process is designed to evolve. Regularly update based on what works and what doesn't in practice.*