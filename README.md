# CleanStay Flow — Workflow Automation & AI Handover System

**CleanStay Flow** is an automated workflow orchestration system designed for short-term rental management and property housekeeping operations. It standardizes task validation, dynamically evaluates urgency and SLA risks, automatically routes tasks based on agent availability, and uses an AI-driven agent to generate shift handover reports.

---

## Key Features

* **Task Validation & Normalization:** Validates payload requirements (`taskId`, `propertyId`, `taskType`, valid `checkIn` dates) and rejects malformed requests.


* **Dynamic SLA & Risk Calculation:** Calculates hours left before guest check-in, flags SLA breaches, and assigns priority scores based on VIP status, maintenance requirements, and time sensitivity.


* **Auto-Routing & Escalation:** Automatically assigns unassigned tasks to available field staff based on workload. Escalates high-risk tasks or SLA breaches directly to management via webhooks and external databases.


* **AI Shift Handover Analyst:** Integrates an AI agent powered by Groq LLM (`groq/compound-mini`) to analyze open and critical tasks, generating structured shift reports for incoming management teams.


* **Resilient Fallback Mechanisms:** Includes deterministic fallback logic to construct emergency reports and mock data in case the external database or the AI LLM fails.



---

## Workflow Architecture

```
[Webhook / Manual Trigger]
            │
            ▼
   [Validation Script] ──(Invalid)──► [Rejection Builder] ──► [Log Rejection]
            │
         (Valid)
            ▼
  [Status Normalization]
            │
            ▼
 [Risk & Priority Scoring] ──► [Agent Auto-Assignment]
                                         │
                 ┌───────────────────────┴───────────────────────┐
                 ▼                                               ▼
         (High Risk / VIP)                               (Standard Task)
                 │                                               │
                 ▼                                               ▼
        [Escalate Webhook]                              [Notify Team Webhook]
                 │                                               │
                 ▼                                               ▼
   [Airtable: CriticalAlerts]                         [Airtable: TeamTasks]

─────────────────────────────────────────────────────────────────────────────
[Shift Handover Pipeline]
  [Manual Trigger / Schedule] ──► [Fetch Tasks] ──► [Format Shift Context]
                                                            │
                                             ┌──────────────┴──────────────┐
                                             ▼                             ▼
                                   [AI Handover Agent]           [Deterministic Fallback]
                                     (Groq LLM)                     (If LLM Fails)

```

---

## Node Component Overview

### 1. Ingestion & Validation

* **Webhook - Task Event (`/cleanstay-task`):** Receives HTTP request payloads from external booking platforms.


* **Function (`b75d6e6c`):** Validates input attributes (`taskId`, `propertyId`, `taskType`, `checkIn`) and generates an array of validation errors.


* **If-Else - Task Valid?:** Routes the payload to status normalization if valid, or rejection processing if invalid.



### 2. Processing & Routing

* **Function QC - Delay and Risk (`b5f932f1`):** Computes time remaining until `checkIn`, calculates a `priorityScore`, and sets the `riskLevel` (`ready`, `at_risk`, `not_ready`).


* **Function - Assign and Route (`fc0dff50`):** Evaluates staff roster workloads (`Sara`, `Omar`, `Yasmine`, `Mehdi`) and automatically assigns unassigned active tasks to the agent with the lowest active task count.


* **If-Else - Critical?:** Evaluates whether a task requires immediate escalation (`riskLevel === 'not_ready'` or `priority === 'high'`).



### 3. External Integrations

* **Escalate (`bc07cacd`):** Sends high-priority alert payloads to the management webhook endpoint.


* **Notify Team (`3390f8d5`):** Dispatches standard task notifications to the operations team webhook.


* **Airtable Nodes (`482b7002` & `df0afe24`):** Formats and records task details in the `CriticalAlerts` and `TeamTasks` tables via the Airtable API.



### 4. AI Shift Handover Pipeline

* **GET TeamTasks Open (`301d2d2a`):** Fetches ongoing tasks from Airtable.


* **Agent - Shift Handover Analyst (`60191d3e`):** Executes system prompts using `groq/compound-mini` to output structured handover summaries, including non-completed tasks, critical risk points, and actionable recommendations.


* **Fallback Systems (`wyog6px0` & `q2ycwg4d`):** Handles database timeouts or LLM failures by generating fallback emergency context and deterministic text reports.



---

## Data Schema Example

### Input Payload (Webhook)

```json
{
  "taskId": "CS-002",
  "propertyId": "APT-05",
  "bookingRef": "BK-222",
  "taskType": "cleaning",
  "status": "NEW",
  "checkIn": "2026-09-08T12:06:00Z",
  "vipGuest": true,
  "incidentReported": false,
  "notes": "VIP guest - urgent cleaning request"
}

```

### Calculated Risk Output

```json
{
  "taskId": "CS-002",
  "propertyId": "APT-05",
  "priorityScore": 90,
  "priority": "high",
  "riskLevel": "not_ready",
  "slaBreach": false,
  "assignedAgent": "Yasmine",
  "assignmentMode": "auto"
}

```
