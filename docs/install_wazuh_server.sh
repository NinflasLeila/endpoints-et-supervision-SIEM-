## Installation (serveur Wazuh)
> Détails et commandes : `scripts/install_wazuh_server.sh`

### Étapes

1. **Mettre à jour la machine Ubuntu**
   ```bash
   sudo apt update && sudo apt upgrade -y''
   
2.   Télécharger et exécuter le script d’installation Wazuh All-in-One
wget https://raw.githubusercontent.com/wazuh/wazuh/v4.7.5/install.sh -O install_wazuh_server.sh
chmod +x install_wazuh_server.sh
./install_wazuh_server.sh


3. Vérifier que les services Wazuh sont actifs


sudo systemctl status wazuh-manager
sudo systemctl status wazuh-indexer
sudo systemctl status wazuh-dashboard


4. Récupérer l’URL du dashboard et les identifiants admin

L’URL est généralement : https://<IP_SERVEUR>:5601

Identifiants admin si générés : voir sortie du script ou fichier /root/wazuh-install-files/wazuh-passwords.txt
