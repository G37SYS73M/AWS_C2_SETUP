#!/bin/bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# Set variables
ANSIBLE_PLAYBOOK="ansible/mythic.yml" # Path to the Ansible playbook
INVENTORY_FILE="ansible/inventory.ini" # Path to the Ansible inventory file


# Step 1: Run Ansible
echo "Running Ansible playbook..."
ansible-playbook -i "$INVENTORY_FILE" "$ANSIBLE_PLAYBOOK"


echo "Ansible completed successfully! The setup is done."



echo '[*]Use Command: ssh -i .ssh/id_rsa -L 7443:127.0.0.1:7443 ubuntu@$ip'
echo "[*]To get the mythic_admin password"
echo "cd /opt/Mythic"
echo "sudo ./mythic-cli config get MYTHIC_ADMIN_PASSWORD"
Echo "Visit https://127.0.0.1:7443"


# Exit script
exit 0
