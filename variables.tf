variable "aws_region" { default = "eu-west-3" }
variable "key_name" { default = "mykey" }
variable "public_key_path" { default = "~/.ssh/mykey.pub" }
variable "private_key_path" { default = "~/.ssh/mykey.pem" }
variable "security_group_name" { default = "app_sg" }
variable "ami_id" { default = "ami-0c45f766e099f6f4e" }
variable "instance_type" { default = "t2.medium" }
variable "ssh_user" { default = "debian" }