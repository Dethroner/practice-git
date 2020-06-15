# Terraform variables
variable "akey" {
  description = "access_key"
}

variable "skey" {
  description = "secret_key"
}

variable "region" {
  default     = "us-west1"
}

variable "ami" {
  description = "ami image"
}

variable "aws_key_pair" {
  description = "SSH publik key"
}

variable "keypath" {
  description = "Path to SSH private key"
}

variable "vpc_id" {
  description = "vpc-ID"
}

variable "allowed_ports" {
    description = "Allowed ports from/to host"
    default     = ["80", "443"]
}