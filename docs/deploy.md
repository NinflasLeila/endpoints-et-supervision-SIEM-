### Étapes principales

1. **Création des instances EC2**
   - Choisir le **VPC / Subnet** commun
   - Lancer les machines : **Wazuh-Server (Ubuntu)**, **Linux-Client**, **Windows-Client**
   - Configurer les **Security Groups** pour SSH/RDP/HTTP(s)
2. **Installation de Wazuh** sur le serveur
3. **Enrôlement des agents** (Linux et Windows)
4. **Exécution des scénarios** et validation via le dashboard Wazuh
