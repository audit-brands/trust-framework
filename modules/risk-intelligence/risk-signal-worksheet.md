# Worksheet: Identifying & Mapping Risk Signals

**Module:** Risk Intelligence
**Version:** 1.0

---

## 🎯 Objective

This worksheet provides a structured, meticulous process for moving beyond traditional, high-level risk statements (e.g., "Risk of Talent Attrition") to identify and map the high-fidelity, quantitative signals that can provide early warnings and actionable insights.

Use one copy of this worksheet for each significant organizational risk you are analyzing.

---

## 1. Risk Deconstruction

**Objective:** Break down a broad risk into its specific, observable components.

| | |
| :--- | :--- |
| **High-Level Risk Statement:** | *(e.g., "Risk of declining product quality")* |
| **Primary Risk Driver(s):** | *(What are the 1-3 root causes or contributing factors? e.g., "Insufficient QA resources," "Increased code complexity," "Pressure to ship features faster.")* |
| **Key Impact Area(s):** | *(Where would the impact of this risk crystallize? e.g., "Customer support tickets," "Negative app store reviews," "Subscription churn.")* |

---

## 2. Signal Brainstorming & Identification

**Objective:** For each driver and impact area identified above, brainstorm potential data signals that could act as a proxy or leading indicator.

### For Risk Driver: `[Insert Driver 1 from above]`

| Potential Signal | Type (Leading/Lagging) | Data Source (System/Report) | Frequency | Owner |
| :--- | :--- | :--- | :--- | :--- |
| *(e.g., Ratio of open bugs to closed bugs)* | Leading | `Jira` | Daily | `Engineering Lead` |
| *(e.g., Avg. cyclomatic complexity score)* | Leading | `Code Quality Scanner` | Per Commit | `DevOps` |
| *(e.g., Overtime hours logged by QA team)* | Leading | `HRIS / Time Tracking` | Weekly | `QA Manager` |

### For Impact Area: `[Insert Impact Area 1 from above]`

| Potential Signal | Type (Leading/Lagging) | Data Source (System/Report) | Frequency | Owner |
| :--- | :--- | :--- | :--- | :--- |
| *(e.g., Volume of tickets with "bug" tag)* | Lagging | `Zendesk` | Daily | `Support Lead` |
| *(e.g., Avg. app store rating this week)* | Lagging | `App Store Connect` | Weekly | `Product Manager` |
| *(e.g., # of customers citing "bugs" in churn survey)* | Lagging | `SurveyMonkey` | Monthly | `Customer Success` |

---

## 3. Signal Validation & Prioritization

**Objective:** Evaluate the brainstormed signals to select the few that are most reliable, accessible, and predictive. This is the most critical step.

*Score each potential signal from Section 2 on a scale of 1 (Low) to 5 (High).* 

| Signal | **Fidelity** (How accurately does it represent the risk?) | **Accessibility** (How easy is it to get this data?) | **Timeliness** (How quickly does it reflect a change?) | **Actionability** (Can we do something about it if it changes?) | **Total Score** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| *[Signal 1]* | | | | | |
| *[Signal 2]* | | | | | |
| *[Signal 3]* | | | | | |

**Decision:** Based on the scoring, select the **Top 1-3 Primary Signals** to build your monitoring around. These are your highest-value signals.

*   **Primary Signal 1:**
*   **Primary Signal 2:**
*   **Secondary Signal(s) for context:**

---

## 4. Monitoring & Threshold Definition

**Objective:** Define the practical parameters for monitoring your selected primary signals.

### For Primary Signal: `[Insert Primary Signal 1 from above]`

| | |
| :--- | :--- |
| **Monitoring Mechanism:** | *(How will this signal be tracked? e.g., "Automated SQL query to data warehouse, visualized in a Grafana dashboard.")* |
| **Baseline / Normal Range:** | *(What is the current acceptable range for this metric? e.g., "1.5 - 2.0 open/closed bug ratio.")* |
| **Alerting Threshold (Yellow):** | *(At what point does this signal require attention? e.g., "Ratio > 2.5 for 3 consecutive days.")* |
| **Alerting Threshold (Red):** | *(At what point does this signal require immediate escalation? e.g., "Ratio > 3.5.")* |
| **Alerting Protocol:** | *(Who gets notified and how? e.g., "Automated Slack message to #engineering-quality channel.")* |
| **Response Playbook:** | *(What is the pre-agreed-upon action when a threshold is breached? e.g., "Initiate bug swarm, pause new feature development for 24 hours.")* |

---

## 5. Review & Iteration

*   **Validation Date:** `[Date]`
*   **Reviewer(s):** `[Names/Roles of people who validated this worksheet]`
*   **Next Review Cycle:** `[e.g., Quarterly]`
*   **Notes & Assumptions:** *(Document any assumptions made during this process, or areas that require further investigation.)*
