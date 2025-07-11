# Work Program: Application & Code Security

**Pattern:** SaaS Security Audit
**Domain:** Application & Code Security
**Version:** 1.0

---

## 🎯 Objective

To verify that the application code is developed, tested, and deployed in a secure manner, protecting it from common application-level vulnerabilities and ensuring the integrity of the software supply chain.

## ⚖️ Key Risks

*   **Injection Flaws:** Vulnerabilities like SQL injection or Cross-Site Scripting (XSS) allow attackers to execute malicious code or access sensitive data.
*   **Insecure Design:** The application is not architected with security in mind, leading to fundamental design flaws that cannot be easily patched.
*   **Vulnerable Dependencies:** The use of third-party libraries with known vulnerabilities can introduce significant risk into the application.
*   **Insecure CI/CD Pipeline:** A compromised software delivery pipeline can allow attackers to inject malicious code into the final product.

--- 

## 🔬 Work Program & Testing Procedures

| Control Area | Control Objective | Suggested Testing Procedures |
| :--- | :--- | :--- |
| **Secure Software Development Lifecycle (SSDLC)** | Security is integrated into all phases of the software development lifecycle. | 1. **Verify** that a formal SSDLC process is documented and followed by the engineering team.<br>2. **Interview** developers and product managers to confirm that security requirements are defined during the design phase.<br>3. **Verify** that threat modeling is performed for new, critical features or services.<br>4. **Verify** that all developers receive regular secure coding training. |
| **Static & Dynamic Code Analysis** | The application code is automatically scanned for security vulnerabilities before being deployed to production. | 1. **Verify** that a Static Application Security Testing (SAST) tool is integrated into the CI/CD pipeline and configured to scan all code changes.<br>2. **Verify** that a Dynamic Application Security Testing (DAST) tool is used to scan the running application in a test environment.<br>3. **Review** the results of recent SAST and DAST scans and verify that critical and high-risk findings are being remediated or have a documented risk acceptance.<br>4. **Verify** that scan results are triaged and assigned to developers for remediation in a timely manner. |
| **Dependency & Supply Chain Security** | Third-party and open-source dependencies are scanned for known vulnerabilities, and their use is managed. | 1. **Verify** that a Software Composition Analysis (SCA) tool is used to identify all third-party dependencies and their licenses.<br>2. **Verify** that the SCA tool is configured to scan for known vulnerabilities (CVEs) in the dependencies.<br>3. **Review** the process for approving and managing the use of new third-party libraries.<br>4. **Verify** that the CI/CD pipeline is configured to fail if a new, critical vulnerability is introduced via a dependency. |
| **Code Integrity & Repository Security** | The source code repository is configured securely to prevent unauthorized changes. | 1. **Verify** that the production branch of the source code repository is protected, requiring a peer review (pull request) for all changes.<br>2. **Inspect** the repository settings to ensure that administrative privileges are restricted to a small number of individuals.<br>3. **Verify** that all developers are required to use multi-factor authentication (MFA) to access the source code repository.<br>4. **Verify** that code commits are signed to ensure their integrity. |
| **Secrets Management** | Sensitive information (e.g., API keys, passwords) is not hard-coded in the source code. | 1. **Use** a SAST tool or a specialized secrets scanning tool to scan the entire codebase for hard-coded secrets.<br>2. **Verify** that the application retrieves secrets at runtime from a secure secrets management service (e.g., AWS Secrets Manager, HashiCorp Vault).<br>3. **Interview** developers to understand how they manage secrets in their local development environments. |
