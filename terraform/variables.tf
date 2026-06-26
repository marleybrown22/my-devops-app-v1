# variables.tf
variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair used for SSH access"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to connect over SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "env" {
  description = "Deployment environment (dev/staging/prod)"
  type        = string
  default     = "test"
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Owner = "Team DevOps"
  }
}
