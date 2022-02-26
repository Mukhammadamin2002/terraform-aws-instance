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
  region  = var.region
}

data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "ubuntu-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SecurityGroup.id]
  subnet_id              = aws_subnet.public-subnet.id
  user_data              = file("./scripts/setup.sh")
  key_name = "accesser"
  tags = {
    Name = var.instance_name
  }
}

# Get latest Red Hat Enterprise Linux 8.x AMI
data "aws_ami" "redhat-linux-8" {
  most_recent = true
  owners      = ["309956199498"]
  filter {
    name   = "name"
    values = ["RHEL-8.*"]
  }
}
resource "aws_instance" "rhel-server" {
  ami                    = data.aws_ami.redhat-linux-8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SecurityGroup.id]
  subnet_id              = aws_subnet.private-subnet.id
  key_name = "accesser"
  tags = {
    Name = var.rhel_name
  }
}

resource "aws_security_group" "SecurityGroup" {
  description = "Instance Inbound traffic"
  vpc_id = aws_vpc.exadel-vpc.id
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
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
