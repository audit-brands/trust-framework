# Pattern Metadata Schema

**Version:** 1.0
**Status:** Active

---

## 1. Overview

Every engagement pattern within the Trust Framework must include a `metadata.yaml` file in its root directory. This file provides structured data that allows the pattern to be discovered, parsed, and integrated with tooling like the `trust-cli`.

This document defines the official schema for that metadata file. All community contributions for new patterns must include a `metadata.yaml` file that conforms to this specification.

---

## 2. Schema Specification

### **`name`**
*   **Type:** `String`
*   **Required:** `Yes`
*   **Description:** The human-readable name of the engagement pattern.
*   **Example:** `SaaS Security Audit`

### **`version`**
*   **Type:** `String`
*   **Required:** `Yes`
*   **Description:** The version of the pattern, which should follow Semantic Versioning (e.g., `1.0.0`, `1.1.0`).
*   **Example:** `1.0.0`

### **`author`**
*   **Type:** `String`
*   **Required:** `Yes`
*   **Description:** The original author or group that contributed the pattern.
*   **Example:** `OpenAudit Community`

### **`description`**
*   **Type:** `String`
*   **Required:** `Yes`
*   **Description:** A brief, one-sentence description of the pattern's purpose and scope.
*   **Example:** `A comprehensive pattern for auditing the security of a SaaS application and its cloud infrastructure.`

### **`tags`**
*   **Type:** `List of Strings`
*   **Required:** `Yes`
*   **Description:** A list of relevant keywords that help categorize and discover the pattern. Tags should be lowercase.
*   **Example:**
    ```yaml
    tags:
      - "security"
      - "cloud"
      - "saas"
      - "technology"
    ```

### **`associated_frameworks`**
*   **Type:** `List of Strings`
*   **Required:** `No`
*   **Description:** A list of common industry or regulatory frameworks that this pattern helps address.
*   **Example:**
    ```yaml
    associated_frameworks:
      - "SOC 2"
      - "ISO 27001"
      - "NIST Cybersecurity Framework"
    ```

### **`dependencies`**
*   **Type:** `Object`
*   **Required:** `No`
*   **Description:** An object that lists other Trust Framework components that this pattern builds upon or recommends using.
*   **Sub-keys:**
    *   `modules`: A list of recommended `module` slugs.
    *   `patterns`: A list of recommended `pattern` slugs.
*   **Example:**
    ```yaml
    dependencies:
      modules:
        - "risk-intelligence"
        - "stakeholder-centric-assurance"
    ```

---

## 3. Complete Example

Here is a complete example of a well-formed `metadata.yaml` file, using the `saas-security-audit` pattern as a reference.

```yaml
name: "SaaS Security Audit"
version: "1.0.0"
author: "OpenAudit Community"

description: "A comprehensive pattern for auditing the security of a SaaS application and its cloud infrastructure."

tags:
  - "security"
  - "cloud"
  - "saas"
  - "technology"

associated_frameworks:
  - "SOC 2"
  - "ISO 27001"
  - "NIST Cybersecurity Framework"
  - "CIS Benchmarks"

dependencies:
  modules:
    - "risk-intelligence"
    - "stakeholder-centric-assurance"
```
