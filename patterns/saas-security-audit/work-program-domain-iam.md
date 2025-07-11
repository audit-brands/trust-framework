# Work Program: Identity & Access Management

**Pattern:** SaaS Security Audit
**Domain:** Identity & Access Management (IAM)
**Version:** 1.0

---

## 🎯 Objective

To verify that access to the SaaS application and its underlying infrastructure is properly controlled, authenticated, and authorized based on the principle of least privilege, ensuring that users, services, and administrators only have the access they need to perform their roles.

## ⚖️ Key Risks

*   **Weak Authentication:** The use of single-factor authentication or weak passwords can allow attackers to easily compromise user accounts.
*   **Privilege Escalation:** A user or service with excessive permissions can be exploited by an attacker to gain broader access to the system.
*   **Credential Theft:** Stolen API keys or service account credentials can provide an attacker with persistent, often undetected, access to the environment.
*   **Orphaned Accounts:** The failure to de-provision access for terminated employees or services can leave a significant security hole.

--- 

## 🔬 Work Program & Testing Procedures

| Control Area | Control Objective | Suggested Testing Procedures |
| :--- | :--- | :--- |
| **Authentication** | All user and service access is authenticated using strong, modern mechanisms. | 1. **Verify** that all users are required to use Multi-Factor Authentication (MFA) to access the application and its underlying infrastructure.<br>2. **Verify** that a formal password policy is in place and enforced, requiring complexity and a minimum length.<br>3. **Verify** that the application uses a centralized identity provider (e.g., Okta, Azure AD) for user authentication, rather than managing local user accounts.<br>4. **For service-to-service authentication,** verify that short-lived credentials (e.g., IAM roles, OAuth tokens) are used instead of long-lived API keys where possible. |
| **Authorization & Least Privilege** | Users and services are granted the minimum level of access required to perform their job functions. | 1. **Verify** that a formal access control policy or role-based access control (RBAC) model is documented.<br>2. **Select a sample** of user roles and inspect their assigned permissions to ensure they align with the principle of least privilege.<br>3. **Verify** that administrative or privileged access to the production environment is restricted to a small, named set of individuals.<br>4. **For cloud infrastructure,** inspect IAM policies to ensure they do not use wildcards (`*`) for actions or resources unless absolutely necessary and justified. |
| **Access Reviews** | User access is periodically reviewed by management, and unnecessary access is revoked in a timely manner. | 1. **Verify** that a formal process is in place for conducting periodic access reviews (e.g., quarterly) for all critical systems.<br>2. **Select a sample** of recent access reviews and verify that they were completed, signed off by the appropriate data or system owner, and that any identified excessive access was revoked.<br>3. **Verify** that the access review process includes both application-level and infrastructure-level permissions. |
| **Provisioning & De-provisioning** | User and service access is granted and revoked in a timely and automated manner. | 1. **Verify** that there is an automated process for provisioning and de-provisioning user access that is linked to the HR system (e.g., when an employee joins, changes roles, or leaves).<br>2. **Select a sample** of recently terminated employees and verify that their access to all systems was revoked on their last day of employment.<br>3. **Verify** that a similar process exists for de-provisioning service accounts or API keys that are no longer needed. |
| **Secrets & Credential Management** | Service account credentials and other secrets are securely stored, rotated, and managed. | 1. **Verify** that all privileged credentials and API keys are stored in a secure, audited secrets management system (e.g., HashiCorp Vault, AWS Secrets Manager).<br>2. **Verify** that there is an automated process for rotating critical secrets on a regular basis.<br>3. **Verify** that access to the secrets management system itself is tightly controlled and monitored. |
