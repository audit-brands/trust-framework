# How to Contribute to The Open Assurance Collective

First of all, thank you for your interest in contributing! The Open Assurance Collective is a community-driven project, and your contributions are essential to its success. Whether you are submitting a new engagement pattern, proposing a core module, or fixing a typo, your help is greatly appreciated.

This document provides guidelines for contributing to the `trust-framework` repository.

## 💡 Guiding Principles

*   **Be Practical:** Our goal is to create resources that are immediately useful to practitioners. Contributions should be grounded in real-world experience and focus on actionable advice.
*   **Be Collaborative:** This is a community project. Be open to feedback, and be willing to work with others to improve the framework.
*   **Be Bold:** We are trying to revolutionize a profession. Don't be afraid to challenge traditional thinking and propose new ideas.

## 🚀 How to Contribute

We welcome contributions in several forms:

*   **New Engagement Patterns:** This is the most common way to contribute. If you have expertise in a specific area of audit, you can create a new pattern to share your knowledge.
*   **New Core Modules:** If you have an idea for a new core audit methodology, you can propose a new module.
*   **Improvements to Existing Content:** You can submit a pull request to fix a typo, clarify a sentence, or add a new resource to an existing module or pattern.

##  Process for Contributing New Content

### 1. Propose Your Idea (Optional, but Recommended)

Before you start writing, it's a good idea to open a [GitHub Issue](https://github.com/google/trust-framework/issues) to propose your idea for a new module or pattern. This allows the community to provide feedback and ensure that your idea is aligned with the project's goals.

### 2. Fork the Repository

Start by forking the `trust-framework` repository to your own GitHub account.

### 3. Create a New Branch

Create a new branch in your forked repository for your contribution. The branch name should be descriptive of the work you are doing.

```bash
# Example for a new pattern
git checkout -b feature/pattern-cloud-cost-management

# Example for a new module
git checkout -b feature/module-quantitative-risk
```

### 4. Create Your Content

Create your new module or pattern in the appropriate directory (`/modules` or `/patterns`). Please adhere to the following quality standards:

*   **Follow the Existing Structure:** Your new module or pattern should follow the same structure as the existing ones, with a `README.md` file and one or more detailed work programs or guides.
*   **Use Clear, Concise Language:** Write in a way that is easy for practitioners to understand and apply.
*   **Adhere to the Metadata Schema:** If you are creating a new pattern, you must include a valid metadata block in the `README.md` file. Please refer to the [pattern-metadata-schema.md](pattern-metadata-schema.md) for the full specification.

### 5. Submit a Pull Request

Once you are finished with your work, submit a pull request from your branch to the `main` branch of the `trust-framework` repository.

In your pull request description, please include:

*   A brief summary of the contribution.
*   A link to the GitHub Issue, if you created one.
*   A statement confirming that your contribution is your own original work.

### 6. The Review Process

Once you submit a pull request, one of the project maintainers will review your contribution. The review will focus on:

*   **Alignment with our philosophy.**
*   **Clarity and quality of the writing.**
*   **Adherence to the required structure and metadata schema.**

The maintainer may ask you to make some changes before your pull request can be merged. Please be responsive to feedback and be prepared to work with the reviewer to improve your contribution.

## 🏆 Competency & Recognition

We believe in recognizing our contributors for their valuable work. Merged contributions are the primary way to earn a place in our **[Competency Registry](competency-registry.md)**.

*   **Current Process:** In our current phase, recognition is granted based on a qualitative review of your merged pull requests by the project maintainers. This requires a GitHub account.
*   **Future Vision:** We are building a dedicated Q&A platform that will allow for broader community participation and a more automated, vote-based recognition system. Participation in this future platform will not require a GitHub account.

Thank you again for your interest in contributing to The Open Assurance Collective!
