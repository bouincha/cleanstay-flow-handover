# 🏨 CleanStay Flow Handover — Système Intelligent de Transmission entre Shifts

> Prototype d'automatisation, de validation et de priorisation intelligente par IA pour la transmission des tâches entre équipes (Shift A ➡️ Shift B).

---

## 📌 1. Présentation & Problématique (8%)

Lors des changements d'équipes (Shift A vers Shift B), la transmission des informations opérationnelles rencontre souvent plusieurs problèmes :
- **Perte d'informations :** Tâches oubliées, incomplètes ou mal interprétées.
- **Manque de priorisation :** Difficulté pour l'équipe entrante d'identifier rapidement les urgences critiques par rapport aux tâches normales.
- **Transmission tardive :** Absence de suivi en temps réel des incidents créés en cours de shift.

**Problématique métier :**  
*Comment automatiser, fiabiliser et prioriser intelligemment les informations transmises entre deux shifts afin de permettre à l'équipe entrante d'agir rapidement sur les tâches importantes ?*

---

## 📐 2. Méthodologie d'Analyse (8%)

### ❓ Analyse QQOQCCP
- **Quoi ?** Un système d'automatisation du handover entre shifts assisté par une IA de priorisation.
- **Qui ?** Les équipes opérationnelles (Shift A, Shift B) et les responsables de service.
- **Où ?** Accessible via Webhooks et visualisable sur un Dashboard en temps réel.
- **Quand ?** Lors de la transmission de fin de shift et en continu pour les nouvelles tâches.
- **Comment ?** Réception des données par Webhooks, validation technique par Functions, analyse contextuelle par Agent IA, stockage Supabase et affichage Realtime.
- **Pourquoi ?** Garanti la continuité de service, élimine la perte d'information et réduit le temps d'intervention sur les incidents graves.

### 🔍 Analyse des 5 Pourquoi (5 Whys)
1. *Pourquoi l'équipe du Shift B accuse-t-elle des retards sur certaines urgences ?* Parce qu'elle n'a pas identifié les tâches prioritaires dès son arrivée.
2. *Pourquoi la priorité des tâches n'était-elle pas claire ?* Parce que le Shift A transmet une liste brute sans évaluation de la criticité.
3. *Pourquoi la criticité n'est-elle pas évaluée à la saisie ?* Parce que l'équipe sortante manque de temps et fait une transmission uniquement factuelle.
4. *Pourquoi n'y a-t-il pas d'analyse automatique du contexte ?* Parce que le processus de transmission repose sur une saisie manuelle ou un canal non structuré.
5. *Pourquoi utiliser un canal non structuré ?* **Cause racine :** Absence d'un workflow automatisé et intelligent capable d'analyser le contexte et d'alerter en temps réel.

### 🔄 Processus BPMN
- **BPMN As-Is (Actuel) :** Transmission orale/papier ➡️ Données incomplètes ➡️ Mauvaise priorisation ➡️ Retard ou oubli d'intervention.
- **BPMN To-Be (Futur) :** Webhook (Shift A / New Task) ➡️ Validation Function ➡️ Main DB ➡️ Extraction Open Tasks ➡️ IA Analysis (Priority + Reason) ➡️ Handover DB ➡️ Realtime Dashboard.

*(Les diagrammes BPMN détaillés sont disponibles dans le dossier `/docs/`)*

---

## 🏗️ 3. Architecture Technique (15%)

Le système s'appuie sur une architecture distribuée et événementielle :

```text
[ SHIFT A Data ]  ──> ( Webhook 1 ) ──┐
                                      ├──> [ Validation Function ] ──(TRUE)──> [ MAIN DB (Supabase) ]
[ NEW TASKS Data] ──> ( Webhook 2 ) ──┘                 │                              │
                                                      (FALSE)                          │ (Get Open Tasks)
                                                        │                              ▼
                                               [ HTTP Error 400 ]             [ Agent IA (Fusion AI) ]
                                                                                       │
                                                                           (Priority + Reasoning)
                                                                                       │
                                                                                       ▼
[ Realtime Dashboard ] <── ( Supabase Realtime ) <──────────────────────── [ HANDOVER DB ]
