#!/bin/bash

# Set variables
ANSIBLE_PLAYBOOK="ansible/mythic.yml" # Path to the Ansible playbook
INVENTORY_FILE="ansible/inventory.ini" # Path to the Ansible inventory file


# Step 1: Run Ansible
echo "Running Ansible playbook..."
ansible-playbook -i "$INVENTORY_FILE" "$ANSIBLE_PLAYBOOK"
check_error "Ansible playbook"

echo "Ansible completed successfully! The setup is done."

# Creating local port forward
ip=`cat ansible/.ip`
ssh -i .ssh/id_rsa 7443:127.0.0.1:7443 ubuntu@$ip


# Exit script
exit 0
