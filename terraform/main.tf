provider "aws" {
  region = "us-east-1" # Replace with your preferred region
}

# Create a Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "mythic-key"
  public_key = file(".ssh/id_rsa.pub") #Create a id_rsa keypair in the .ssh folder
}

# Create a Security Group
resource "aws_security_group" "mythic_sg" {
  name        = "mythic-security-group"
  description = "Allow SSH and HTTP/HTTPS traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Change this to Your IP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 Instance
resource "aws_instance" "mythic_instance" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (replace with your region-specific AMI)
  instance_type = "t2.medium"
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.mythic_sg.name]

  tags = {
    Name = "MythicServer"
  }

  provisioner "local-exec" {
    command = "echo '${aws_instance.mythic_instance.public_ip}' > inventory.ini"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Ansible installation placeholder" > /tmp/ansible.txt
              EOF
}

# Output the Public IP
output "mythic_instance_public_ip" {
  value = aws_instance.mythic_instance.public_ip
}