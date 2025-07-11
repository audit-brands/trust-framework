# Suggested Testing Procedures: SaaS Security Audit

**Version:** 1.0

---

## 🎯 Objective

This document provides a set of specific, practical testing procedures that can be used to execute the fieldwork described in the `engagement_program.md`. These are suggestions and should be tailored to the specific technologies and environment of the organization being audited.

---

### Domain 2.1: Identity & Access Management (IAM)

*   **Test 2.1.1: User Provisioning & De-provisioning**
    *   **Procedure:** Obtain a list of all employees hired and terminated in the last quarter from the HR system. For a sample of 5 of each, request the corresponding access control tickets and system logs to verify that access was granted/revoked within the SLA defined in the IT policy (e.g., 24 hours).
    *   **Tools:** HRIS export, JIRA/ServiceNow, Splunk/Sumo Logic query.

*   **Test 2.1.3: Privileged Access**
    *   **Procedure:** Obtain a list of all users with administrative access to the production cloud environment (e.g., the `AdministratorAccess` role in AWS). For each user, verify that there is a documented approval from their manager and the system owner.
    *   **Tools:** AWS IAM query, CloudTrail logs.

### Domain 2.2: Data Governance & Protection

*   **Test 2.2.2: Encryption at Rest**
    *   **Procedure:** For the primary production database (e.g., Amazon RDS), obtain a screenshot of the configuration settings to verify that encryption is enabled. For object storage (e.g., Amazon S3), review the bucket policies to ensure that default encryption is enforced.
    *   **Tools:** AWS Management Console, Azure Portal, GCP Console.

*   **Test 2.2.2: Encryption in Transit**
    *   **Procedure:** Use a free online SSL/TLS checker (e.g., Qualys SSL Labs) to scan the application's public-facing endpoints. Verify that it receives an "A" rating and does not support outdated protocols (e.g., SSLv3, TLS 1.0/1.1).
    *   **Tools:** Qualys SSL Labs, `nmap` scripts.

### Domain 2.3: Application Security

*   **Test 2.3.2: Vulnerability Management**
    *   **Procedure:** Obtain the last 3 months of vulnerability scan reports from the organization's scanning tool (e.g., Nessus, Qualys, Snyk). For a sample of 5 critical vulnerabilities, trace them to the remediation ticket in the ticketing system and verify that they were remediated within the SLA (e.g., 30 days for critical vulnerabilities).
    *   **Tools:** Vulnerability scanner reports, JIRA/ServiceNow.

### Domain 2.4: Infrastructure & Network Security

*   **Test 2.4.1: Cloud Configuration**
    *   **Procedure:** Run an open-source cloud security posture management (CSPM) tool like Prowler (for AWS) or ScoutSuite (for multiple clouds) against a read-only account in the production environment. Review the report for high-risk misconfigurations (e.g., public S3 buckets, unrestricted security groups).
    *   **Tools:** Prowler, ScoutSuite, or native cloud security tools.

*   **Test 2.4.2: Network Segmentation**
    *   **Procedure:** Review the inbound rules for the security groups associated with production databases. Verify that they only allow traffic from the specific application servers and not from the entire internet (`0.0.0.0/0`).
    *   **Tools:** AWS Management Console, `aws ec2 describe-security-groups` CLI command.

*   **Test 2.4.3: Logging & Monitoring**
    *   **Procedure:** Attempt to perform a sensitive action in the production environment (e.g., logging in as a privileged user, attempting to access a restricted resource). Within 5 minutes, verify that a corresponding event is generated in the security logging tool (e.g., Splunk, Sumo Logic).
    *   **Tools:** Application UI, Splunk/Sumo Logic query.

---

## 💡 Note on Automation

Many of these tests can and should be automated. The `trust-cli` can be used to execute scripts (e.g., Prowler, nmap) and to analyze the output of these tools. The goal is to move towards a state of continuous assurance where these tests are run automatically on a regular basis.
