# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Overview

This repository contains **Trust: An Open System for Modern Assurance** - an open-source framework for building trust through modern assurance.

## Repository Structure

```
trust-framework/             # Root repository  
├── core/                    # Trust: An Open System for Modern Assurance core principles
│   ├── MANIFESTO.md        # Vision and philosophy
│   ├── GOVERNANCE.md       # Open governance model
│   ├── BRAND_USAGE.md      # Brand guidelines
│   └── CONTRIBUTING.md     # Contribution guidelines
├── modules/                 # Trust functional modules
│   └── control_design_maturity/  # Control maturity framework
├── patterns/                # Practice-based assurance patterns (coming soon)
├── tools/                   # Technical implementations
│   ├── trust-cli/          # Local-first AI CLI assistant
│   └── local-issue-tracker/  # File-based issue tracking system
├── docs/                    # Documentation
│   └── kedro_inspiration.md  # Kedro-inspired architecture plans
└── assets/                  # Logos and visuals
```

## Key Concepts

### Trust Framework
- **Modular architecture**: Core principles, functional modules, and practice patterns
- **Open source**: Community-driven development and governance
- **Assurance focus**: Designed for audit practitioners and risk professionals
- **Local-first**: Privacy-preserving tools and offline capability

### Available Tools

1. **trust-cli**: A local-first AI assistant that uses GGUF models for complete privacy
   - Located in `/tools/trust-cli/`
   - Separate repository: https://github.com/audit-brands/trust-cli

2. **local-issue-tracker**: A file-based issue tracking system
   - Located in `/tools/local-issue-tracker/`
   - Run `./setup_new_project.sh` to deploy to any project

## Working with Trust Content

### Modules
- Each module in `/modules/` contains functional assurance frameworks
- Currently includes Control Design & Maturity 2.0
- Modules use markdown format with optional YAML metadata

### Patterns (Coming Soon)
- Will contain practice-based blueprints
- Combine control design with feedback loops and KPIs
- Include industry-specific overlays

### Contributing
- Follow guidelines in `/core/CONTRIBUTING.md`
- Submit new modules or patterns via pull request
- Maintain markdown format and clear documentation

## Development Guidelines

1. **Preserve simplicity**: Trust content should remain human-readable markdown
2. **Maintain modularity**: Components should work independently
3. **Document thoroughly**: Each module/pattern needs clear documentation
4. **Test locally**: Ensure changes work offline

## Future Enhancements

See `/docs/kedro_inspiration.md` for planned improvements including:
- Project scaffolding tools
- Visualization capabilities
- CI/CD automation
- Pattern metadata schema

---

*For questions about the Trust framework, refer to the MANIFESTO.md and blueprint.md files.*