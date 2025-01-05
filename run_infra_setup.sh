#!/bin/bash

# Set variables
TERRAFORM_DIR="terraform" # Path to the directory containing Terraform files
ANSIBLE_PLAYBOOK="ansible/mythic.yml" # Path to the Ansible playbook
INVENTORY_FILE="ansible/inventory.ini" # Path to the Ansible inventory file
SSH_KEY_PATH=".ssh/id_rsa"

# Function to check for errors
check_error() {
  if [ $? -ne 0 ]; then
    echo "Error occurred during $1. Exiting..."
    exit 1
  fi
}

# Step 1: Create SSH Key Pair
if [ ! -f "$SSH_KEY_PATH" ]; then
  echo "Generating SSH key pair..."
  ssh-keygen -t rsa -b 4096 -f "$SSH_KEY_PATH" -C "your_email@example.com" -N ""
  check_error "SSH key generation"
  echo "SSH key pair generated successfully!"
else
  echo "SSH key pair already exists. Skipping generation..."
fi

# Step 2: Run Terraform
echo "Initializing Terraform..."
cd "$TERRAFORM_DIR" || exit
terraform init
check_error "Terraform init"

echo "Applying Terraform configuration..."
terraform apply -auto-approve
check_error "Terraform apply"

echo "Terraform completed successfully!"

# Step 3: Extract IP for Ansible Inventory
echo "Extracting public IP for Ansible inventory..."
PUBLIC_IP=$(terraform output -raw mythic_instance_public_ip)
check_error "Extracting IP"

echo "[mythic]" > "../$INVENTORY_FILE"
echo "$PUBLIC_IP ansible_user=ubuntu ansible_ssh_private_key_file=../$SSH_KEY_PATH" >> "../$INVENTORY_FILE"
check_error "Writing inventory file"

echo "Inventory file created successfully!"

# Step 4: Run Ansible
cd ".." || exit
echo "Running Ansible playbook..."
ansible-playbook -i "$INVENTORY_FILE" "$ANSIBLE_PLAYBOOK"
check_error "Ansible playbook"

echo "Ansible completed successfully! The setup is done."

# Exit script
exit 0
