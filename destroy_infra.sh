!/bin/bash

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set variables
TERRAFORM_DIR="terraform"    # Path to the Terraform directory
ANSIBLE_DIR="ansible"        # Path to the Ansible directory
INVENTORY_FILE="$ANSIBLE_DIR/inventory.ini" # Path to the Ansible inventory file
SSH_KEY_PATH=".ssh/id_rsa"

# Function to check for errors
check_error() {
  if [ $? -ne 0 ]; then
    echo "Error occurred during $1. Exiting..."
    exit 1
  fi
}

# Step 1: Destroy the Terraform-managed infrastructure
echo "Destroying Terraform-managed infrastructure..."
cd "$TERRAFORM_DIR" || exit
terraform destroy -auto-approve
check_error "Terraform destroy"
cd .. || exit

echo "Terraform infrastructure destroyed successfully!"

# Step 2: Clean up generated files
echo "Cleaning up generated files..."

# Remove Ansible inventory file
if [ -f "$INVENTORY_FILE" ]; then
  rm -f "$INVENTORY_FILE"
  echo "Removed inventory file: $INVENTORY_FILE"
else
  echo "No inventory file found. Skipping..."
fi

# Optionally remove Terraform state files
if [ -d "$TERRAFORM_DIR" ]; then
  rm -f "$TERRAFORM_DIR/terraform.tfstate"
  rm -f "$TERRAFORM_DIR/terraform.tfstate.backup"
  echo "Removed Terraform state files."
fi

# Optionally remove SSH key pair
if [ -f "$SSH_KEY_PATH" ]; then
  rm -f "$SSH_KEY_PATH" "$SSH_KEY_PATH.pub"
  echo "Removed SSH key pair: $SSH_KEY_PATH"
else
  echo "No SSH key pair found. Skipping..."
fi

echo "Cleanup completed!"

# Step 3: Confirm destruction
echo "Infrastructure and associated files have been destroyed."
exit 0