# Sécurité des endpoints & supervision SIEM (Wazuh) — AWS Learner Lab

> Projet : déploiement d’une plateforme Wazuh (SIEM/EDR) sur AWS, enrôlement d’agents Linux & Windows, génération d’événements et analyse (threat hunting).

## Informations
- **Étudiant(e)** : Laila Nineflas
- **Encadrant** : Prof. Azeddine KHIAT
- **Filière** : BIG DATA & Cloud Computing
- **Année universitaire** : 2025/2026
- **Établissement** : ENSET MOHAMMEDIA

## Liens importants
- **Rapport PDF** : `docs/rapport/Pojet_VCC_NINEFLAS_Laila.pdf`
- **Dépôt GitHub** : https://github.com/NinflasLeila/endpoints-et-supervision-SIEM-

## Résumé
Ce projet met en place une architecture de supervision de sécurité basée sur Wazuh, combinant SIEM (collecte, corrélation et visualisation des logs) et EDR (visibilité et protection des endpoints).  
Le lab est réalisé sur AWS et démontre la centralisation d’événements Linux/Windows, la détection d’alertes, puis l’analyse via le dashboard Wazuh.

## Objectifs
- Déployer Wazuh All-in-One (manager, indexer, dashboard) sur une instance Ubuntu.
- Enrôler un client Linux Ubuntu et un client Windows Server via agents Wazuh.
- Configurer réseau et ports nécessaires (dashboard + communication agents).
- Générer des scénarios d’événements (SSH failed, sudo, FIM, Windows 4625, etc.).
- Réaliser des requêtes simples de threat hunting et fournir des preuves (captures d’écran).

## Architecture du lab
### Composants
- **EC2-1** : Ubuntu — Wazuh All-in-One (manager, indexer, dashboard)
- **EC2-2** : Ubuntu — Client Linux + agent Wazuh
- **EC2-3** : Windows Server — Client Windows + agent Wazuh (+ Sysmon optionnel)

### Schéma
- Diagramme : `docs/diagrammes/architecture.png`



## Prérequis
- Compte AWS Learner Lab avec droits de création EC2/VPC/Security Groups.
- Trois instances : Ubuntu serveur, Ubuntu client, Windows Server.
- Accès admin (SSH/RDP) limité à l’IP de l’administrateur.
- Git installé (optionnel si upload via interface web GitHub).

## Installation (serveur Wazuh)
> Détails et commandes : `scripts/install_wazuh_server.sh`

Étapes :
1. Mettre à jour la machine Ubuntu.
2. Télécharger et exécuter le script d’installation Wazuh All-in-One.
3. Vérifier que les services Wazuh (manager, indexer, dashboard) sont actifs.
4. Récupérer l’URL du dashboard et identifiants admin (si générés).

## Enrôlement des agents
### Agent Linux (Ubuntu)
- Enrôler via le dashboard (Deploy new agent) ou via commandes fournies.
- Vérifier le statut “Active” dans la liste des agents.

### Agent Windows (Windows Server)
- Installer l’agent Wazuh.
- Vérifier que le service “Wazuh Agent” est en exécution.
- (Optionnel) Installer Sysmon pour enrichir la télémétrie EDR.

## Scénarios de génération d’événements & détection
### Linux
- Tentatives SSH échouées (bruteforce simulé).
- Élévation de privilèges (`sudo su`).
- Modification de fichier sensible (FIM).

### Windows
- Échecs de login (event 4625).
- Création d’un utilisateur local + ajout au groupe Administrateurs.

## Threat hunting (exemples)
- Requête 1 : échecs SSH Linux (IP source, fréquence, agent).
- Requête 2 : Windows Failed logon 4625 (compte, machine, horaire).
- Requête 3 : création d’utilisateur / changement de groupe (IAM/PAM).

## Preuves (captures)
Les captures sont dans `docs/screenshots/` 


## Déploiement / Reproductibilité
Voir `deploy/DEPLOYMENT.md` pour une procédure complète :
- Création EC2 + Security Groups
- Installation Wazuh
- Enrôlement agents
- Exécution scénarios + validation dashboard

## Structure du dépôt
- `README.md` : documentation principale
- `docs/` : rapport, diagrammes, captures
- `scripts/` : scripts d’installation et d’enrôlement
- `config/` : ports, Security Groups, inventaire d’exemple
- `deploy/` : procédure de déploiement
