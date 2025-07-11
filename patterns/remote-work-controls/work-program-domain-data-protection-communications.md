# Work Program: Data Protection & Communications

**Pattern:** Remote Work Controls Review
**Domain:** Data Protection & Communications
**Version:** 1.0

---

## 🎯 Objective

To verify that sensitive company data is protected from unauthorized access, disclosure, or loss when being accessed and handled by a remote workforce, and that communication channels are secure and used appropriately.

## ⚖️ Key Risks

*   **Data Leakage:** Sensitive data is intentionally or unintentionally transferred to unauthorized locations or personal devices.
*   **Insecure Communication:** Employees use untrusted or unencrypted communication channels to discuss sensitive company information.
*   **Cloud Data Misconfiguration:** Data stored in cloud collaboration tools (e.g., Office 365, Google Workspace) is improperly configured, leading to over-sharing or public exposure.
*   **Loss of Physical Media:** Sensitive data stored on unencrypted removable media (e.g., USB drives) is lost or stolen.

--- 

## 🔬 Work Program & Testing Procedures

| Control Area | Control Objective | Suggested Testing Procedures |
| :--- | :--- | :--- |
| **Data Loss Prevention (DLP)** | Controls are in place to detect and prevent the unauthorized exfiltration of sensitive data. | 1. **Verify** that a Data Loss Prevention (DLP) solution is deployed and configured to monitor key data exfiltration channels (e.g., email, cloud storage, USB drives).<br>2. **Review** the DLP policies to ensure they are configured to detect the company's most sensitive data types (e.g., source code, customer data, financial information).<br>3. **Select a sample** of recent DLP alerts and verify that they were investigated and resolved in a timely manner.<br>4. **Attempt** to send a test file containing sensitive data to an external email address to verify that the DLP policy is working as expected. |
| **Cloud Collaboration Security** | Cloud-based collaboration platforms are configured securely to prevent over-sharing of sensitive information. | 1. **Review** the global sharing settings for key collaboration platforms (e.g., SharePoint, Google Drive) to verify that sharing with external, unauthenticated users is restricted.<br>2. **Verify** that there is a process for periodically reviewing and removing external users who no longer require access.<br>3. **Verify** that security features such as audit logging and file access monitoring are enabled.<br>4. **Select a sample** of sensitive documents and verify that their sharing settings are appropriately restricted. |
| **Secure Communication** | Employees use approved, encrypted channels for all business communication. | 1. **Verify** that the organization has a policy that defines approved communication channels (e.g., corporate email, Slack, Microsoft Teams).<br>2. **Verify** that the policy prohibits the use of unapproved or personal messaging apps for business communication.<br>3. **Review** the security settings for approved communication platforms to ensure that features like end-to-end encryption are enabled where appropriate.<br>4. **Interview** a sample of remote employees to confirm their understanding of the secure communication policy. |
| **Removable Media & Printing** | The use of removable media and the printing of sensitive documents is restricted. | 1. **Verify** that a policy is in place that restricts or prohibits the use of removable media (e.g., USB drives) on company devices.<br>2. **Verify** that the MDM/UEM solution is configured to block or alert on the use of unauthorized removable media.<br>3. **Verify** that the printing of sensitive documents is discouraged and that secure printing solutions are in place if printing is necessary. |
