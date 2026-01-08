# ======================================================
# Atelier Sécurité des Endpoints et Supervision SIEM
# Multi-OS (Linux & Windows) - Template YAML
# Auteur : Laila Ninf
# Encadrant : Prof. Azeddine KHIAT
# Année universitaire : 2025/2026
# ======================================================

project:
  name: "Atelier Sécurité des Endpoints et Supervision SIEM"
  description: >
    Déploiement d'une plateforme complète de supervision et de protection de la sécurité
    basée sur Wazuh, combinant SIEM et EDR pour Linux et Windows dans un AWS Learner Lab.
  student: "Laila Ninf"
  supervisor: "Prof. Azeddine KHIAT"
  academic_year: "2025/2026"
  field: "[Nom de la filière]"
  github_repo: "[Insérer lien GitHub ici]"

# ======================================================
# 1. Architecture du Lab
# ======================================================
architecture:
  vpc:
    name: "LabVPC"
    subnet: "10.0.0.0/24"
    description: "Réseau AWS pour les instances du lab Wazuh"
  instances:
    - name: "Wazuh-Server"
      type: "t3.large"
      os: "Ubuntu 22.04 LTS"
      roles:
        - "Wazuh Manager"
        - "Indexer"
        - "Dashboard"
      security_group: "SG-Wazuh-Server"
      storage_gb: 30
    - name: "Linux-Client"
      type: "t2.micro"
      os: "Ubuntu 22.04"
      roles:
        - "Wazuh Agent"
      security_group: "SG-Linux-Client"
    - name: "Windows-Client"
      type: "t2.medium"
      os: "Windows Server 2025"
      roles:
        - "Wazuh Agent"
        - "Sysmon (optionnel)"
      security_group: "SG-Windows-Client"

# ======================================================
# 2. Security Groups & Ports
# ======================================================
security_groups:
  SG-Wazuh-Server:
    inbound_rules:
      - port: 22
        protocol: tcp
        source: "Votre IP" # SSH
      - port: 443
        protocol: tcp
        source: "Votre IP" # Dashboard HTTPS
      - port: 1514
        protocol: tcp
        source: "SG-Linux-Client, SG-Windows-Client" # Communication agent
      - port: 1515
        protocol: tcp
        source: "SG-Linux-Client, SG-Windows-Client" # Enrollment agent
  SG-Linux-Client:
    inbound_rules:
      - port: 22
        protocol: tcp
        source: "Votre IP"
  SG-Windows-Client:
    inbound_rules:
      - port: 3389
        protocol: tcp
        source: "Votre IP"

# ======================================================
# 3. Installation et Configuration Wazuh
# ======================================================
wazuh_server_installation:
  commands:
    - "sudo apt update && sudo apt -y upgrade"
    - "curl -sO https://packages.wazuh.com/4.7/wazuh-install.sh"
    - "sudo bash wazuh-install.sh -a"
  dashboard:
    url: "https://<IP_SERVER_WAZUH>"
    admin_user: "admin"
    admin_password: "*ChBidg89A.Qwr8LhZw+2t?vJyhoJPHG"
  services_to_check:
    - "wazuh-manager"
    - "wazuh-indexer"
    - "wazuh-dashboard"

agents:
  Linux-Client:
    enrollment_method: "via Wazuh Dashboard"
    commands_example: "copier les commandes fournies par Dashboard"
    verification: "sudo systemctl status wazuh-agent"
  Windows-Client:
    enrollment_method: "via Wazuh Dashboard & PowerShell"
    verification: "Services → Wazuh Agent = Running"

# ======================================================
# 4. Scénarios de démonstration SIEM & EDR
# ======================================================
scenarios:
  Linux:
    - name: "Tentatives SSH échouées"
      command: "ssh fakeuser@IP_LINUX_CLIENT"
      repeat: 5-10
      expected_alert: "authentication failed / sshd"
    - name: "Élévation de privilèges"
      command: "sudo su"
      expected_alert: "sudo events"
    - name: "Modification fichier sensible (FIM)"
      command: 'echo "test" | sudo tee -a /etc/passwd'
      expected_alert: "File Integrity Monitoring"

  Windows:
    - name: "Échecs de login RDP"
      action: "Mauvais mot de passe RDP 2-5 fois"
      expected_alert: "Windows Security Event 4625"
    - name: "Création utilisateur local"
      command: |
        net user labuser P@ssw0rd! /add
        net localgroup administrators labuser /add
      expected_alert: "user created / group changed"
    - name: "EDR enrichi (option Sysmon)"
      expected_alert: "process creation, network connection"

# ======================================================
# 5. Dashboard Wazuh
# ======================================================
dashboard:
  view:
    - "Security events / Threat hunting"
    - "Filtrer par agent: Linux-Client / Windows-Client"
    - "Filtrer par type d'événement: sshd, authentication_failed, Windows Security, user added/group changed, Sysmon logs"

# ======================================================
# 6. Livrables attendus
# ======================================================
deliverables:
  - "Schéma VPC + Security Groups + Instances"
  - "Captures d'écran des agents actifs"
  - "Captures des alertes Linux & Windows"
  - "Rapport comparatif SIEM vs EDR"
  - "IAM / PAM"
  - "3 requêtes de Threat Hunting"
  - "Vidéo synthétique (5 à 10 minutes)"
  - "Lien GitHub du projet"

# ======================================================
# 7. Notes supplémentaires
# ======================================================
notes:
  - "Toutes les étapes doivent être documentées dans GitHub"
  - "Les fichiers de configuration, diagrammes et captures doivent être inclus"
  - "Le rapport doit contenir le logo de l’établissement, le titre, le nom de l’étudiant, le nom de l’encadrant, l’année universitaire et la filière"
