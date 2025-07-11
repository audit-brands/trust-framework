# Schema: Engagement Pattern Metadata

**Version:** 1.0

---

## 🎯 Objective

This document defines the official schema for the YAML metadata block at the beginning of each engagement pattern's `README.md` file. This schema provides a structured, machine-readable way to describe the pattern's purpose, scope, and relationship to the core OpenAudit modules. Adherence to this schema is critical for enabling future tooling, such as the `openaudit` CLI, to discover, interpret, and utilize the patterns.

---

## 📝 Schema Definition

The metadata block must be a valid YAML document enclosed in a ````yaml` code block.

### Root Object: `pattern`

The root of the metadata document is the `pattern` object.

| Field | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `name` | String | Yes | The human-readable name of the engagement pattern. *Example: "SaaS Security Audit"* |
| `version` | String | Yes | The semantic version of the pattern. *Example: "1.0"* |
| `description` | String | Yes | A brief, one-sentence description of the pattern's purpose. |
| `tags` | Array of Strings | No | A list of keywords to aid in discovery. *Example: ["Security", "SaaS", "Cloud"]* |
| `owner` | String | No | The individual or group responsible for maintaining the pattern. *Default: "OpenAudit Community"* |

### Child Object: `modules`

The `modules` object is a required child of the `pattern` object. It is an array of objects, where each object links the pattern to a core OpenAudit module and describes how that module is applied.

| Field | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `name` | String | Yes | The machine-readable name of the core module (must match the module's directory name). *Example: "risk-intelligence"* |
| `objectives` | Array of Strings | Yes | A list of 1-3 specific objectives that describe how this pattern applies the principles of the specified module. |

### Child Object: `scope`

The `scope` object is a required child of the `pattern` object. It defines the boundaries of the engagement pattern.

| Field | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `domains` | Array of Strings | Yes | A list of the key risk areas, control domains, or process areas that are covered by this pattern. These domains should correspond to the individual work program files included in the pattern's directory. |

--- 

## ✅ Example

Here is a complete example of a valid metadata block:

```yaml
pattern:
  name: "AI Governance Review"
  version: "1.0"
  description: "A framework for auditing the governance, risk, and control environment for Artificial Intelligence."
  tags: ["AI", "Machine Learning", "Governance", "Ethics", "Emerging Technology"]
  owner: "OpenAudit Community"

modules:
  - name: "risk-intelligence"
    objectives:
      - "Identify and monitor key risk signals related to AI model performance, bias, and data quality."
  - name: "agile-auditing"
    objectives:
      - "Structure the review into sprints focused on specific AI use cases or governance domains."
  - name: "stakeholder-centric"
    objectives:
      - "Align the review with the ethical principles and strategic goals of the organization."
      - "Deliver insights to data science teams, business owners, and leadership."

scope:
  domains:
    - "AI Strategy & Governance"
    - "Data Management & Quality"
    - "Model Development & Validation"
    - "Operationalization & Monitoring"
    - "Ethics & Responsible AI"
```
