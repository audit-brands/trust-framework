# Engagement Program: SaaS Security Audit

**Version:** 1.0

---

## Phase 1: Planning & Scoping

**Objective:** To align with stakeholders on the engagement's objectives, scope, and approach.

| Step | Procedure | Evidence to Collect |
| :--- | :--- | :--- |
| **1.1** | Conduct kick-off meeting with key stakeholders to confirm scope, timing, and key contacts. | `Meeting minutes`, `Signed engagement letter` |
| **1.2** | Gain a comprehensive understanding of the SaaS architecture, including key components, data flows, and third-party integrations. | `System architecture diagrams`, `Data flow diagrams` |
| **1.3** | Identify all relevant compliance obligations and industry standards (e.g., SOC 2, ISO 27001, PCI DSS). | `List of applicable regulations`, `Prior audit reports` |
| **1.4** | Perform a preliminary risk assessment to identify the highest-risk areas to focus on during the engagement. | `Risk and control matrix (RACM)` |
| **1.5** | Finalize and share the detailed engagement plan and request list with stakeholders. | `Approved engagement plan`, `Initial information request list` |

---

## Phase 2: Fieldwork & Testing

**Objective:** To evaluate the design and operating effectiveness of key security controls across the defined scope.

### **Domain 2.1: Identity & Access Management (IAM)**

| Step | Procedure | Evidence to Collect |
| :--- | :--- | :--- |
| **2.1.1** | Review the user provisioning and de-provisioning processes. Test a sample of new hires and terminations to verify that access was granted and revoked in a timely manner. | `HR records`, `System access logs`, `New hire/termination tickets` |
| **2.1.2** | Evaluate the strength of authentication controls, including password policies, multi-factor authentication (MFA) enforcement, and session management. | `Screenshots of password policy settings`, `MFA configuration reports` |
| **2.1.3** | Review the process for granting and reviewing privileged access (e.g., to cloud infrastructure, databases). | `Privileged access request forms`, `Access review logs` |
| **2.1.4** | Test a sample of user access permissions to ensure the principle of least privilege is being followed. | `User access listings`, `Role-based access control (RBAC) matrix` |

### **Domain 2.2: Data Governance & Protection**

| Step | Procedure | Evidence to Collect |
| :--- | :--- | :--- |
| **2.2.1** | Review the organization's data classification policy. Verify that sensitive data has been identified and classified correctly. | `Data classification policy`, `Data inventory` |
| **2.2.2** | Verify that sensitive data is encrypted at rest and in transit using strong, industry-standard cryptographic protocols. | `Database configuration settings`, `TLS/SSL certificates and configurations` |
| **2.2.3** | Evaluate the effectiveness of data loss prevention (DLP) controls, if applicable. | `DLP tool configuration`, `DLP alert logs` |

### **Domain 2.3: Application Security**

| Step | Procedure | Evidence to Collect |
| :--- | :--- | :--- |
| **2.3.1** | Review the secure software development lifecycle (SSDLC) process, including security training for developers, secure coding standards, and peer review processes. | `SSDLC policy`, `Developer training records`, `Secure coding checklists` |
| **2.3.2** | Evaluate the vulnerability management program, including the tools and processes for scanning, identifying, and remediating vulnerabilities. | `Vulnerability scanning reports`, `Penetration test reports`, `Remediation tickets` |
| **2.3.3** | Review the security of key APIs, including authentication, authorization, and rate limiting controls. | `API documentation`, `API gateway configuration` |

### **Domain 2.4: Infrastructure & Network Security**

| Step | Procedure | Evidence to Collect |
| :--- | :--- | :--- |
| **2.4.1** | Review the configuration of the cloud environment (e.g., AWS, Azure, GCP) against industry best practices (e.g., CIS Benchmarks). | `Cloud configuration reports (e.g., AWS Config, Azure Policy)` |
| **2.4.2** | Evaluate the network architecture, including the use of virtual private clouds (VPCs), subnets, and security groups to segment the environment. | `Network diagrams`, `Firewall rule sets` |
| **2.4.3** | Review the logging and monitoring strategy to ensure that security events are being collected, analyzed, and alerted on. | `Logging and monitoring policy`, `Sample security alerts`, `SIEM configuration` |

---

## Phase 3: Reporting & Follow-up

**Objective:** To communicate the engagement results in a clear, value-driven manner and to partner with stakeholders on a remediation plan.

| Step | Procedure | Evidence to Collect |
| :--- | :--- | :--- |
| **3.1** | For each observation, use the `value-driven-recommendation-guide.md` to transform it from a finding into a collaborative, actionable recommendation. | `Completed recommendation worksheets` |
| **3.2** | Draft the audit report, focusing on the highest-risk areas and the most impactful recommendations. | `Draft audit report` |
| **3.3** | Hold a closing meeting with stakeholders to present the results, validate the recommendations, and agree on a prioritized action plan with clear ownership and timelines. | `Final audit report`, `Management action plan` |
| **3.4** | Schedule follow-up meetings to track the progress of the agreed-upon action items. | `Status updates in project management tool`, `Follow-up meeting minutes` |
