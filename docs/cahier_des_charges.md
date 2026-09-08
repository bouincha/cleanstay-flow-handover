CLEANSTAY FLOW
CAHIER DES CHARGES
Gestion intelligente et passation des opérations de housekeeping
Agence de conciergerie locative en ligne

Durée	2 jours
Équipe	5 personnes
Plateforme	ABA Fusion
Version	MVP - Prototype pédagogique
Document de cadrage fonctionnel et technique
 
Fiche de contrôle du document
Élément	Valeur
Nom du projet	CleanStay Flow
Objet	Coordination et passation des tâches de housekeeping
Version	1.0
Statut	À valider par l’équipe projet
Périmètre	MVP réalisable en deux jours

Sommaire
•	1. Présentation et contexte
•	2. Problématique et objectifs
•	3. Périmètre du MVP
•	4. Parties prenantes
•	5. Processus métier cible
•	6. Exigences fonctionnelles
•	7. Données d’entrée
•	8. Règles métier
•	9. Architecture et workflows ABA Fusion
•	10. Agent IA et rapport de passation
•	11. Dashboard et indicateurs
•	12. Exigences non fonctionnelles
•	13. Gestion des erreurs
•	14. Tests et critères d’acceptation
•	15. Organisation en deux jours
•	16. Répartition entre cinq personnes
•	17. Livrables et conclusion
 
1. Présentation et contexte
CleanStay Flow est un prototype destiné à une agence de conciergerie locative en ligne. Il centralise les opérations réalisées entre le départ d’un voyageur et l’arrivée du suivant : nettoyage, changement du linge, réapprovisionnement, contrôle qualité et signalement des incidents.
Les informations sont souvent réparties entre des messages, appels, formulaires et feuilles de calcul. Cette dispersion peut provoquer un ménage oublié, un logement non prêt, une mauvaise affectation ou un problème technique non transmis à l’équipe suivante.
Besoin central — fournir à chaque équipe une vision fiable des logements à préparer, des tâches ouvertes et des risques avant les prochaines arrivées.
2. Problématique et objectifs
2.1 Problématique
Comment automatiser la création, l’affectation, le suivi et la passation des tâches de housekeeping afin de garantir que chaque logement soit propre, contrôlé et prêt avant l’arrivée du prochain voyageur ?
2.2 Objectif général
Développer dans ABA Fusion un assistant intelligent qui suit les tâches de housekeeping, détecte les risques et transmet automatiquement les tâches non terminées à l’équipe entrante.
2.3 Objectifs spécifiques
•	Enregistrer les logements, réservations simulées et tâches de ménage.
•	Affecter les tâches et suivre leur avancement.
•	Calculer les retards et le risque de logement non prêt.
•	Signaler les incidents techniques et contrôles qualité échoués.
•	Produire une synthèse intelligente des tâches ouvertes.
•	Notifier l’équipe entrante et présenter les KPI dans un dashboard.
3. Périmètre du MVP
Inclus	Exclu du MVP
1 agence fictive, 5 à 10 logements	Connexion réelle à Airbnb ou Booking
2 équipes et 5 à 15 tâches de test	Paiements, facturation et contrats
Formulaire/webhook et Google Sheets	Application mobile et géolocalisation
Validation, calcul des risques et IA	Reconnaissance d’images du ménage
Rapport, Gmail et dashboard simple	Gestion complète des stocks et serrures

4. Parties prenantes
Acteur	Responsabilité
Manager	Suit les performances, risques et incidents.
Coordinateur housekeeping	Planifie, affecte et supervise les tâches.
Agent de ménage	Exécute et met à jour les tâches.
Contrôleur qualité	Vérifie la conformité du logement.
Technicien	Traite les incidents techniques.
Responsables de quart	Transmettent et valident la passation.
Agent IA	Analyse et synthétise les informations validées.

5. Processus métier cible
1.	Importer ou saisir les informations de la réservation.
2.	Créer une tâche de ménage après le départ.
3.	Valider et normaliser les données.
4.	Affecter la tâche à un agent et suivre son statut.
5.	Calculer le retard et le temps restant avant l’arrivée.
6.	Enregistrer le contrôle qualité et les incidents éventuels.
7.	Regrouper les tâches ouvertes à la fin du quart.
8.	Analyser les risques avec l’agent IA.
9.	Générer puis envoyer le rapport de passation.
10.	Mettre à jour le dashboard et enregistrer la réception.
6. Exigences fonctionnelles
ID	Fonction	Exigence
BF01	Logements	Créer et mettre à jour un logement et son état.
BF02	Réservations	Recevoir les horaires de départ et de prochaine arrivée.
BF03	Tâches	Créer une tâche de housekeeping avec identifiant unique.
BF04	Affectation	Associer chaque tâche ouverte à un agent.
BF05	Avancement	Mettre à jour statut, progression et commentaire.
BF06	Retard	Détecter automatiquement toute échéance dépassée.
BF07	Risque	Évaluer le risque qu’un logement ne soit pas prêt.
BF08	Incident	Enregistrer un incident découvert pendant le ménage.
BF09	Inspection	Enregistrer le contrôle qualité et demander une reprise.
BF10	Passation	Extraire les tâches non terminées ou critiques.
BF11	IA	Produire une synthèse, des alertes et recommandations.
BF12	Notification	Envoyer le rapport à l’équipe entrante.
BF13	Dashboard	Afficher les KPI et les tâches prioritaires.

7. Données d’entrée
7.1 Logement et réservation
Objet	Champs essentiels
Logement	property_id, property_name, address_zone, current_status
Réservation	reservation_id, property_id, checkout_at, next_checkin_at, special_instructions

7.2 Tâche de housekeeping
Champ	Type	Obligatoire	Exemple
task_id	String	Oui	HK-2026-001
property_id	String	Oui	PROP-001
task_type	Enum	Oui	CHECKOUT_CLEANING
assigned_to	String	Oui si ouverte	AGENT-HK-03
planned_start	DateTime	Oui	2026-09-07T11:15:00Z
deadline	DateTime	Oui	2026-09-07T14:00:00Z
status	Enum	Oui	IN_PROGRESS
priority	Enum	Oui	HIGH
progress_percentage	Number	Non	60

Statuts autorisés : NEW, ASSIGNED, IN_PROGRESS, READY_FOR_INSPECTION, COMPLETED, BLOCKED et CANCELLED.
7.3 Incident et inspection
Objet	Champs essentiels
Incident	incident_id, task_id, incident_type, description, severity, status, assigned_department
Inspection	inspection_id, task_id, inspector_id, inspection_status, score, issues_found, rework_required

8. Règles métier
8.1 Calcul du retard
overdue = true si deadline < date actuelle et si le statut n’est ni COMPLETED ni CANCELLED.
8.2 Calcul de la priorité
Condition	Priorité
Arrivée dans moins d’une heure et logement non prêt	CRITICAL
Tâche en retard ou incident de sécurité	CRITICAL
Incident bloquant ou contrôle qualité échoué	HIGH
Aucun agent assigné	HIGH
Manque de linge ou de produits	MEDIUM
Tâche planifiée sans urgence	LOW

8.3 Conditions de préparation
Un logement passe à READY uniquement lorsque le ménage est terminé, le contrôle qualité est validé et aucun incident bloquant n’est ouvert.
8.4 Conditions de passation
•	Tâche non terminée ou bloquée.
•	Échéance dépassée.
•	Contrôle qualité échoué.
•	Responsable ou donnée obligatoire manquante.
•	Arrivée proche avec logement non prêt.
9. Architecture et workflows ABA Fusion
Architecture minimale : Formulaire/Webhook → Extraction → Normalisation → Validation → If/Else → Google Sheets → Calcul du risque → Agent IA → Rapport → Gmail/Dashboard.
9.1 Workflow de collecte
Le webhook reçoit l’événement. Une fonction extrait l’objet utile, normalise les valeurs, contrôle les champs puis dirige l’entrée vers le stockage ou vers le journal d’erreur.
9.2 Workflow d’analyse
Le workflow lit les tâches, calcule le temps restant avant l’arrivée, détecte les retards et met à jour la priorité selon des règles déterministes.
9.3 Workflow de passation
À la fin du quart, un déclenchement manuel récupère les tâches ouvertes, les regroupe par logement, appelle l’agent IA, construit le rapport et l’envoie par Gmail.
9.4 Stockage conseillé
Feuille	Contenu
Properties	Logements et état actuel
Reservations	Départs, arrivées et instructions
Tasks	Tâches de housekeeping et avancement
Incidents	Anomalies et actions techniques
Handovers	Rapports et accusés de réception
Logs	Étapes, erreurs et tentatives

10. Agent IA et rapport de passation
10.1 Rôle de l’agent IA
•	Résumer la situation du quart.
•	Identifier les logements prioritaires.
•	Regrouper les tâches liées au même logement.
•	Expliquer les risques et proposer les prochaines actions.
•	Signaler les contradictions sémantiques et informations manquantes.
Les calculs de dates, retards, KPI, doublons et validations restent dans les fonctions JavaScript. L’IA ne doit jamais inventer un logement, une réservation, un responsable ou une échéance.
10.2 Contenu du rapport
•	Informations générales du quart.
•	Nombre de logements prêts, à nettoyer et bloqués.
•	Tâches ouvertes, critiques et en retard.
•	Incidents et contrôles qualité échoués.
•	Informations manquantes.
•	Synthèse et recommandations de l’IA.
•	Validation de l’équipe entrante.
11. Dashboard et indicateurs
KPI	Méthode de calcul
Logements à nettoyer	Nombre de logements avec statut TO_CLEAN
Ménages en cours	Nombre de tâches IN_PROGRESS
Logements prêts	Nombre de logements READY
Tâches en retard	Tâches ouvertes dont l’échéance est dépassée
Taux de tâches terminées	Tâches terminées / total des tâches × 100
Taux de conformité	Contrôles PASSED / contrôles réalisés × 100

Code couleur : vert pour prêt/terminé, bleu pour en cours, orange pour risque, rouge pour critique/en retard et gris pour information manquante.
12. Exigences non fonctionnelles
Domaine	Exigences
Performance	Traiter une entrée en quelques secondes et au moins quinze tâches de démonstration.
Fiabilité	Vérifier les champs, dates et doublons; conserver un format JSON uniforme.
Sécurité	Utiliser des données fictives et ne stocker aucun véritable code d’accès.
Maintenabilité	Nommer clairement les nœuds, commenter les fonctions et documenter les entrées/sorties.
Traçabilité	Associer chaque traitement à un transaction_id et enregistrer son statut.

13. Gestion des erreurs
Erreur	Traitement attendu
Champ obligatoire absent	Rejeter l’entrée ou demander une correction.
Date invalide	Diriger l’entrée vers la branche d’erreur.
Tâche dupliquée	Mettre à jour la tâche existante.
Agent non assigné	Créer un avertissement HIGH.
Google Sheets indisponible	Journaliser l’échec et conserver la donnée à retraiter.
Agent IA indisponible	Générer un résumé de secours basé sur les règles fixes.
Gmail indisponible	Conserver le rapport et journaliser l’échec d’envoi.

14. Tests et critères d’acceptation
14.1 Scénarios de test
Test	Donnée principale	Résultat attendu
T1	Tâche normale	Stockage sans alerte critique
T2	Échéance dépassée	overdue=true et CRITICAL
T3	Arrivée dans moins d’une heure	Alerte logement non prêt
T4	assigned_to vide	Avertissement HIGH
T5	Fuite d’eau ouverte	Logement BLOCKED
T6	Inspection FAILED	Reprise demandée
T7	Plusieurs tâches ouvertes	Rapport IA et notification

14.2 Critères d’acceptation
•	Une tâche peut être créée et mise à jour.
•	Les entrées invalides sont détectées.
•	Les retards et arrivées critiques déclenchent une alerte.
•	Un incident peut bloquer un logement.
•	Les tâches ouvertes sont regroupées dans la passation.
•	L’IA retourne une synthèse structurée.
•	Le rapport est envoyé et les KPI sont corrects.
•	La démonstration fonctionne de bout en bout.
15. Organisation en deux jours
Période	Activités	Résultat
Jour 1 — matin	Cadrage, données, Google Sheets, webhook, validation	Entrées valides stockées
Jour 1 — après-midi	Calcul des retards, risque, prompt IA, premier test	Input → validation → IA
Jour 2 — matin	Rapport, Gmail, dashboard et intégration	Parcours complet
Jour 2 — après-midi	Tests, corrections, documentation et répétition	MVP stable

Règle de pilotage — à partir du milieu du deuxième jour, aucune nouvelle fonctionnalité ne doit être ajoutée.
16. Répartition entre cinq personnes
Membre	Rôle	Responsabilités principales
P1	Leader / intégration	Cadrage, BPMN, architecture, suivi et intégration finale
P2	Données	Google Sheets, jeux de test, validation et normalisation
P3	ABA Fusion	Webhook, workflow, conditions, stockage et Gmail
P4	IA / rapport	Prompt, format JSON, synthèse et rapport de passation
P5	Dashboard / qualité	KPI, dashboard, tests, présentation et démonstration

Un point d’avancement court est réalisé au minimum deux fois par jour. Tout blocage supérieur à une heure est communiqué au leader. Les cinq membres participent au test final et comprennent le parcours complet.
17. Livrables et conclusion
17.1 Livrables
•	Cahier des charges validé.
•	QQOQCCP et analyse des 5 Pourquoi.
•	BPMN As-Is et To-Be.
•	Architecture technique et structure des données.
•	Jeu de données fictives.
•	Workflow ABA Fusion et fonctions JavaScript.
•	Prompt IA et rapport de passation.
•	Dashboard et plan de tests.
•	Présentation et démonstration fonctionnelle.
17.2 Résultat attendu
Une réservation simulée déclenche une tâche de ménage. ABA Fusion valide et stocke la tâche, calcule son niveau de risque, détecte les retards et rassemble les tâches non terminées. L’agent IA produit une synthèse de passation, le coordinateur reçoit le rapport et consulte l’état des logements dans un dashboard.
CleanStay Flow doit privilégier un parcours simple, stable et démontrable de bout en bout.
