# AWS C2 Server Setup

This repository automates the provisioning and deployment of a Command and Control (C2) server on AWS using Terraform and Ansible.

## Setup and Run Instructions

### Prerequisites
Ensure the following tools are installed on your local machine:
- **Terraform**: [Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- **Ansible**: [Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
- **AWS CLI**: [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- **Git**: [Installation Guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

Configure your AWS CLI with valid credentials:
```bash
aws configure
```

## Steps to Run the Setup
### Clone the Repository
```bash
git clone https://github.com/G37SYS73M/AWS_C2_SETUP.git
cd AWS_C2_SETUP
```

### Modify as needed
>> Modify run_infra_setup.sh to change the email address for id_rsa keypair
>> Modify the main.tf to change the Source IPs and EC2 AMI

### Run the Setup Script Execute the script to provision the AWS infrastructure and deploy the C2 server:
```bash
./run_infra_setup.sh

#Wait for the Ec2 instance to spinup and then run

./run_ansible_setup.sh
```

## Tear Down Instructions
### To destroy the infrastructure and clean up resources, run:
```bash
./destroy_infra.sh

This will terminate the EC2 instance and remove any associated resources.
```