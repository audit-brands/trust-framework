# trust-cli

A local-first AI CLI assistant that embodies Trust privacy and transparency principles. Built as a fork of Google's Gemini CLI, trust-cli replaces cloud API calls with local GGUF model inference for complete privacy and offline capability.

**🔗 Active Development Repository**: https://github.com/audit-brands/trust-cli

## Vision

Fork Google's Gemini CLI to create a local-first AI workflow tool that uses GGUF models (Llama, Phi, Qwen, etc.) instead of cloud APIs, maintaining all the sophisticated features while ensuring complete privacy and offline capability.

## Key Features

- **Local-first**: All AI processing happens on your machine
- **Privacy-focused**: No data leaves your device
- **Offline capable**: Works without internet connection
- **Model flexibility**: Support for multiple GGUF models
- **Familiar interface**: Same command patterns as Gemini CLI
- **Resource efficient**: Optimized for 8-16GB RAM systems

## Architecture

- **Runtime**: Node.js with TypeScript
- **Model backend**: node-llama-cpp for GGUF inference
- **Configuration**: YAML-based config in `~/.trustcli/`
- **Binary name**: `trust` (coexists with `gemini`)

## Development Status

🚧 **Planning Phase** - See [local_gemini_cli_plan.md](local_gemini_cli_plan.md) for comprehensive project scope and technical details.

## Trust Principles

This project embodies core Trust values:
- **Transparency**: Open source, auditable code
- **Privacy**: Local processing, no external data transmission
- **Trust-by-design**: Security built into the architecture
- **Community-driven**: Open contribution model

## Getting Started

Visit the active development repository: https://github.com/audit-brands/trust-cli

## Contributing

Active development happens in the separate trust-cli repository. This project follows Trust contribution guidelines - see the main [CONTRIBUTING.md](../../core/CONTRIBUTING.md) for details.

## License

This project will be released under an open source license aligned with Trust principles.