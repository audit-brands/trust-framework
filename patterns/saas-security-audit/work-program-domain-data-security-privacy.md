# Work Program: Data Security & Privacy

**Pattern:** SaaS Security Audit
**Domain:** Data Security & Privacy
**Version:** 1.0

---

## 🎯 Objective

To verify that sensitive customer and corporate data is classified, handled, and stored securely throughout its lifecycle, and that data privacy principles are embedded into the application design and operations.

## ⚖️ Key Risks

*   **Data Exposure:** Sensitive data is inadvertently exposed due to weak encryption, improper access controls, or misconfigured services.
*   **Data Loss:** Data is permanently lost due to hardware failure, human error, or a malicious attack, with no ability to recover.
*   **Privacy Violations:** The collection, use, or sharing of personal data does not comply with relevant privacy regulations (e.g., GDPR, CCPA) or user expectations, leading to regulatory fines and reputational damage.
*   **Data Sprawl:** Sensitive data is unnecessarily copied or stored in insecure locations, increasing the attack surface.

--- 

## 🔬 Work Program & Testing Procedures

| Control Area | Control Objective | Suggested Testing Procedures |
| :--- | :--- | :--- |
| **Data Classification & Handling** | Data is classified according to its sensitivity, and handling procedures are defined and followed. | 1. **Verify** that a formal data classification policy exists and has been approved by management.<br>2. **Interview** data owners and system architects to understand how data is classified in practice.<br>3. **Select a sample** of key data stores (e.g., databases, S3 buckets) and verify that they have a clear owner and a documented data classification level.<br>4. **Verify** that there are documented procedures for handling sensitive data (e.g., encryption, masking, access restrictions). |
| **Encryption** | Sensitive data is encrypted both in transit and at rest. | 1. **Verify** that all external communication to and from the SaaS application is encrypted using strong, industry-standard protocols (e.g., TLS 1.2 or higher).<br>2. **Inspect** the configuration of production databases, object stores, and other data repositories to verify that encryption at rest is enabled.<br>3. **Verify** that the management of encryption keys is handled through a secure, centralized service (e.g., AWS KMS, Azure Key Vault).<br>4. **For applications with very high security requirements,** verify that sensitive data fields are also encrypted at the application level before being stored in the database. |
| **Data Backup & Recovery** | Production data is regularly backed up, and the backups are tested to ensure they can be restored. | 1. **Verify** that a formal backup policy exists and specifies the frequency, retention period, and storage location for backups.<br>2. **Inspect** the configuration of production databases and servers to verify that automated backups are enabled and running successfully.<br>3. **Verify** that backups are stored in a secure, geographically separate location from the production environment.<br>4. **Verify** that the organization periodically tests its ability to restore from backups and has documented the results of these tests. |
| **Data Retention & Disposal** | Data is retained only for as long as necessary and is securely disposed of at the end of its lifecycle. | 1. **Verify** that a data retention policy is in place and that it defines retention periods for different types of data.<br>2. **Select a sample** of production systems and verify that automated data retention rules (e.g., S3 lifecycle policies, database cleanup jobs) are configured and active.<br>3. **Verify** that the process for disposing of data and physical media is secure and documented. |
| **Privacy by Design** | Privacy principles are embedded into the design and operation of the application. | 1. **Verify** that a public-facing privacy notice is available and accurately describes the data being collected and how it is used.<br>2. **Interview** product managers and engineers to understand how privacy considerations are incorporated into the feature design process.<br>3. **Verify** that mechanisms are in place to support data subject rights (e.g., the right to access, correct, or delete their data), as required by regulations like GDPR. |
