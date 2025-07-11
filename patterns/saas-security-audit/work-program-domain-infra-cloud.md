# Work Program: Infrastructure & Cloud Configuration

**Pattern:** SaaS Security Audit
**Domain:** Infrastructure & Cloud Configuration
**Version:** 1.0

---

## 🎯 Objective

To verify that the underlying cloud infrastructure hosting the SaaS application is configured securely, resiliently, and in accordance with industry best practices to protect against common threats.

## ⚖️ Key Risks

*   **Misconfiguration:** Publicly exposed storage buckets, overly permissive firewall rules, or insecure default settings can lead to unauthorized access or data leakage.
*   **Vulnerability:** Unpatched operating systems or container images can be exploited by attackers to gain a foothold in the environment.
*   **Lack of Segregation:** A flat network architecture allows attackers to move laterally and easily access sensitive systems after an initial breach.
*   **Inadequate Logging & Monitoring:** The inability to detect and respond to suspicious activity in the cloud environment can delay incident response and increase the impact of a breach.

--- 

## 🔬 Work Program & Testing Procedures

| Control Area | Control Objective | Suggested Testing Procedures |
| :--- | :--- | :--- |
| **Network Security** | The production network environment is logically segregated and protected from unauthorized access. | 1. **Obtain and review** the cloud network architecture diagram.<br>2. **Verify** that production environments are logically isolated from development and staging environments (e.g., through separate VPCs, subnets, and security groups).<br>3. **Inspect** firewall and security group rules to ensure they follow the principle of least privilege. Pay close attention to inbound rules open to `0.0.0.0/0`.<br>4. **Verify** that network traffic between key application tiers (e.g., web, application, database) is restricted to only necessary ports and protocols. |
| **Secure Configuration & Hardening** | Cloud resources are configured securely and hardened against common vulnerabilities. | 1. **Verify** that a formal process exists for hardening base operating system and container images.<br>2. **Select a sample** of production virtual machines or containers and verify that they are built from approved, hardened images.<br>3. **Utilize** a cloud security posture management (CSPM) tool (e.g., AWS Security Hub, Azure Security Center) to scan for and report on misconfigurations.<br>4. **Verify** that sensitive data (e.g., credentials, API keys) is not hard-coded in configuration files or user data scripts. Use a secrets management service (e.g., AWS Secrets Manager, HashiCorp Vault). |
| **Vulnerability Management** | The infrastructure is continuously scanned for vulnerabilities, and critical issues are remediated in a timely manner. | 1. **Verify** that an automated vulnerability scanning tool is deployed and configured to scan all production infrastructure.<br>2. **Review** the results of recent vulnerability scans and verify that critical and high-risk vulnerabilities have been remediated or have a documented risk acceptance.<br>3. **Interview** DevOps/Engineering teams to understand the patching process and verify that it is being followed.<br>4. **Verify** that there is a defined SLA for remediating vulnerabilities based on their severity. |
| **Logging & Monitoring** | All security-relevant events in the cloud environment are logged, monitored, and alerted on. | 1. **Verify** that logging is enabled for key cloud services (e.g., AWS CloudTrail, Azure Monitor).<br>2. **Inspect** log configurations to ensure that both control plane (e.g., API calls) and data plane (e.g., VPC flow logs) events are being captured.<br>3. **Verify** that alerts are configured for suspicious activities (e.g., unauthorized API calls, changes to security groups, attempts to access sensitive data).<br>4. **Select a sample** of recent security alerts and trace them to the corresponding incident response or investigation process. |
| **Data Storage Security** | Data stored in cloud object storage or databases is encrypted and protected from unauthorized public access. | 1. **Verify** that all production storage buckets (e.g., S3) and databases have encryption at rest enabled by default.<br>2. **Scan** for and report on any publicly accessible storage buckets or snapshots.<br>3. **Verify** that access to sensitive data is restricted via fine-grained IAM policies and that public access is blocked at the account level. |
