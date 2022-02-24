terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74.3"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

# data "aws_ami" "img-ami" {
#     most_recent = true

#     filter {
#         name   = "name"
#         values = ["ubuntu-focal-20.04-amd64-server-*"]
#     }

#     filter {
#         name   = "virtualization-type"
#         values = ["hvm"]
#     }

#     owners = ["418480801570"] # Canonical
# }

resource "aws_instance" "app-server" {
  ami                    = "ami-0d527b8c289b4af7f"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.securitygroup.id}"]
  tags = {
    Name = var.instance_name
  }

}

resource "aws_security_group" "securitygroup" {
  description = "Instance Inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
