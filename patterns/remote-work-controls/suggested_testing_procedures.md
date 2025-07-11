# Suggested Testing Procedures: Remote Work Controls Review

**Version:** 1.0

---

## 🎯 Objective

This document provides a set of specific, practical testing procedures for a remote work controls review.

---

### Domain 2.1: Endpoint Security

*   **Test 2.1.1: Endpoint Management**
    *   **Procedure:** Obtain a report from the MDM/UEM solution of all managed devices. Compare this list to the organization's asset inventory to identify any gaps.
    *   **Tools:** MDM/UEM reports, asset inventory system.

*   **Test 2.1.2: Security Control Enforcement**
    *   **Procedure:** For a sample of 10 managed devices, use the MDM/UEM console to verify that key security policies are being enforced (e.g., disk encryption is enabled, anti-malware is running and up-to-date, the host-based firewall is on).
    *   **Tools:** MDM/UEM console.

### Domain 2.2: Network Security

*   **Test 2.2.1: VPN Configuration**
    *   **Procedure:** Review the VPN concentrator configuration to verify that it is configured to require MFA for all connections. Attempt to connect to the VPN with a test account that does not have MFA enabled to verify that the connection is denied.
    *   **Tools:** VPN configuration files, VPN client.

### Domain 2.3: Data Security

*   **Test 2.3.1: Data Loss Prevention**
    *   **Procedure:** With permission, attempt to copy a file containing sensitive test data from a managed device to a USB drive or a personal cloud storage account. Verify that the action is blocked by the DLP tool and that an alert is generated.
    *   **Tools:** Managed laptop, USB drive, DLP tool console.

### Domain 2.4: HR & People Operations

*   **Test 2.4.2: Security Awareness Training**
    *   **Procedure:** Obtain the completion reports from the security awareness training platform for the last 12 months. Verify that all employees have completed the training on remote work security.
    *   **Tools:** Security awareness training platform reports.
