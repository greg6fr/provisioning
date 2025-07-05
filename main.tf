provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("${path.module}/${var.public_key_path}")
}

resource "aws_security_group" "app_sg" {
  name        = var.security_group_name
  description = "Allow SSH, Node.js, Angular, MongoDB"

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "devops_vm" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  tags = {
  Name = "jenkins-server"
  Environment = "dev" 
}
  provisioner "local-exec" {
    command = "bash provision.sh ${self.public_ip} ${var.ssh_user} ${var.private_key_path}"
  }

  user_data = <<-EOF
    #!/bin/bash
    apt update
    apt install -y curl wget
  EOF
}
