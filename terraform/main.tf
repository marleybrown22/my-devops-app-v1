terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Create a VPC
resource "aws_vpc" "app-v1" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Environment = var.env
    Name        = "test-to-verify-vpc"
  }
}

#create SUBNET
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.app-v1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

# this is to create security for a fixed port on the server
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.app-v1.id

  tags = {
    Name = "allow_tls"
  }
}

#create aws_instance
resource "aws_instance" "example" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = var.instance_type
  key_name      = var.key_name
  # tags         = var.tags
}

# Output the instance's public IP
output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.example.public_ip
}
