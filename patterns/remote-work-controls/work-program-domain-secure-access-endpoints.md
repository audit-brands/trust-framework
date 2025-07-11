# Work Program: Secure Access & Endpoints

**Pattern:** Remote Work Controls Review
**Domain:** Secure Access & Endpoints
**Version:** 1.0

---

## 🎯 Objective

To verify that remote employees and contractors have secure, reliable access to company resources, and that the endpoint devices they use (laptops, mobile devices) are configured and managed to protect against security threats.

## ⚖️ Key Risks

*   **Insecure Home Networks:** Employees connecting from insecure home or public Wi-Fi networks can expose corporate traffic to eavesdropping or man-in-the-middle attacks.
*   **Unmanaged Devices:** The use of personal or unmanaged devices (BYOD) to access corporate data can introduce malware and other security threats into the environment.
*   **Weak Authentication:** A lack of strong authentication for remote access can allow unauthorized users to gain access to the corporate network.
*   **Endpoint Compromise:** A compromised endpoint device can be used as a launching point for an attack on the broader corporate network.

--- 

## 🔬 Work Program & Testing Procedures

| Control Area | Control Objective | Suggested Testing Procedures |
| :--- | :--- | :--- |
| **Remote Access & VPN** | Remote access to the corporate network is provided through a secure, encrypted connection. | 1. **Verify** that all remote access to internal resources is required to go through an approved Virtual Private Network (VPN) or Zero Trust Network Access (ZTNA) solution.<br>2. **Review** the configuration of the VPN/ZTNA solution to ensure it is configured with strong encryption protocols.<br>3. **Verify** that split-tunneling is disabled on the VPN, unless a specific risk assessment has been performed and mitigating controls are in place.<br>4. **Verify** that all remote access requires Multi-Factor Authentication (MFA). |
| **Endpoint Security & Configuration** | All company-managed endpoint devices are configured with a standard, secure baseline and protected with security software. | 1. **Verify** that a formal, documented security baseline exists for all standard endpoint devices.<br>2. **Verify** that all company-managed devices are enrolled in a Mobile Device Management (MDM) or Unified Endpoint Management (UEM) solution.<br>3. **Select a sample** of remote employee devices from the MDM/UEM and verify that they are compliant with the security baseline (e.g., disk encryption enabled, local firewall active).<br>4. **Verify** that all endpoints are protected with an approved anti-malware and Endpoint Detection and Response (EDR) solution. |
| **Patch & Vulnerability Management** | Endpoint devices are regularly patched, and vulnerabilities are remediated in a timely manner. | 1. **Verify** that the MDM/UEM solution is configured to automatically deploy critical operating system and application patches to all endpoints.<br>2. **Review** patch compliance reports from the MDM/UEM to verify that the fleet is being patched in accordance with the organization's policy.<br>3. **Verify** that there is a process for identifying and remediating vulnerabilities on endpoint devices. |
| **Bring Your Own Device (BYOD)** | If personal devices are permitted, there is a formal policy and technical controls to manage the associated risks. | 1. **Verify** that a formal BYOD policy exists and has been approved by management.<br>2. **Verify** that the policy clearly defines the requirements for personal devices to access corporate data (e.g., minimum OS version, use of anti-malware).<br>3. **Verify** that technical controls are in place to isolate corporate data on personal devices (e.g., through containerization or VDI).<br>4. **Verify** that the organization has the ability to remotely wipe corporate data from a personal device if it is lost, stolen, or the employee leaves the company. |
