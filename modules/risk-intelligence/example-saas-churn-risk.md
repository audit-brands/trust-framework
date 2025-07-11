# Example: Completed Risk Signal Worksheet for SaaS Customer Churn

**Module:** Risk Intelligence
**Version:** 1.0

---

## 🎯 Objective

This document provides a practical, filled-in example of the [risk-signal-worksheet.md](risk-signal-worksheet.md) to demonstrate how to map the abstract risk of "customer churn" to concrete, monitorable signals for a typical B2B SaaS company.

--- 

## 1. Risk Deconstruction

**Objective:** Break down a broad risk into its specific, observable components.

| | |
| :--- | :--- |
| **High-Level Risk Statement:** | **Risk of increased customer churn rate** |
| **Primary Risk Driver(s):** | 1. Poor customer onboarding experience<br>2. Lack of product engagement<br>3. Ineffective customer support |
| **Key Impact Area(s):** | 1. Revenue contraction<br>2. Damage to brand reputation<br>3. Decreased customer lifetime value (LTV) |

--- 

## 2. Signal Brainstorming & Identification

**Objective:** For each driver and impact area identified above, brainstorm potential data signals that could act as a proxy or leading indicator.

### For Risk Driver: `Lack of product engagement`

| Potential Signal | Type (Leading/Lagging) | Data Source (System/Report) | Frequency | Owner |
| :--- | :--- | :--- | :--- | :--- |
| % of licensed users logging in weekly (WAU) | Leading | `Product Analytics (e.g., Mixpanel)` | Daily | `Product Manager` |
| # of key features used per account per week | Leading | `Product Analytics (e.g., Mixpanel)` | Daily | `Product Manager` |
| Time since last login for key user accounts | Leading | `Application Database` | Daily | `Customer Success` |
| Customer Health Score | Leading | `Customer Success Platform (e.g., Gainsight)` | Daily | `CS Operations` |


### For Impact Area: `Revenue contraction`

| Potential Signal | Type (Leading/Lagging) | Data Source (System/Report) | Frequency | Owner |
| :--- | :--- | :--- | :--- | :--- |
| Monthly Recurring Revenue (MRR) Churn Rate | Lagging | `Billing System (e.g., Stripe)` | Monthly | `Finance` |
| Net Revenue Retention (NRR) | Lagging | `Billing System / CRM` | Monthly | `Finance` |
| # of subscription downgrades | Lagging | `Billing System (e.g., Stripe)` | Weekly | `Customer Success` |

--- 

## 3. Signal Validation & Prioritization

**Objective:** Evaluate the brainstormed signals to select the few that are most reliable, accessible, and predictive. This is the most critical step.

*Score each potential signal from Section 2 on a scale of 1 (Low) to 5 (High).* 

| Signal | **Fidelity** (How accurately does it represent the risk?) | **Accessibility** (How easy is it to get this data?) | **Timeliness** (How quickly does it reflect a change?) | **Actionability** (Can we do something about it if it changes?) | **Total Score** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Customer Health Score** | 5 | 4 | 5 | 5 | **19** |
| **% of licensed users logging in weekly (WAU)** | 4 | 5 | 5 | 4 | **18** |
| **Time since last login for key user accounts** | 4 | 5 | 5 | 5 | **19** |
| **MRR Churn Rate** | 5 | 5 | 2 | 2 | **14** |

**Decision:** Based on the scoring, select the **Top 1-3 Primary Signals** to build your monitoring around. These are your highest-value signals.

*   **Primary Signal 1:** Customer Health Score (as it aggregates multiple engagement factors).
*   **Primary Signal 2:** Time since last login for key user accounts (a simple, powerful, and direct indicator).
*   **Secondary Signal(s) for context:** Weekly Active Users (WAU) provides broader context on overall engagement trends.

--- 

## 4. Monitoring & Threshold Definition

**Objective:** Define the practical parameters for monitoring your selected primary signals.

### For Primary Signal: `Customer Health Score`

| | |
| :--- | :--- |
| **Monitoring Mechanism:** | Automated daily pull from Gainsight API into a centralized executive dashboard (e.g., Tableau). |
| **Baseline / Normal Range:** | A score between 75 and 100 is considered "Healthy". |
| **Alerting Threshold (Yellow):** | Health score drops below 75 ("Needs Attention"). |
| **Alerting Threshold (Red):** | Health score drops below 50 ("At Risk"). |
| **Alerting Protocol:** | **Yellow:** Automated task created in CRM for the assigned Customer Success Manager (CSM) to follow up within 48 hours.<br>**Red:** Automated, high-priority alert sent to the assigned CSM and their manager in Slack. |
| **Response Playbook:** | **Yellow:** CSM follows the "Health Check" playbook (review usage, schedule a check-in call).<br>**Red:** CSM immediately initiates the "Red Account" playbook (escalate to Director of CS, form a tiger team with Product/Engineering if necessary). |

--- 

## 5. Review & Iteration

*   **Validation Date:** `2025-07-10`
*   **Reviewer(s):** `Jane Doe (Director of Customer Success), John Smith (Lead Product Manager)`
*   **Next Review Cycle:** `Quarterly`
*   **Notes & Assumptions:** Assumes that the Customer Health Score algorithm is well-defined and regularly validated. The model currently weighs login frequency (40%), key feature adoption (40%), and support ticket volume (20%). This weighting will be reviewed next quarter. 
