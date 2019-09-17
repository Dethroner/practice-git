# Terraform variables
variable "project" {
  type        = "string"
  description = "Project ID"
}

variable "region" {
  type        = "string"
  description = "region"
  default     = "europe-west1"
}

variable "zone" {
  type        = "string"
  description = "region zone"
  default     = "europe-west1-b"
}

variable "public_key_path" {
  type        = "string"
  description = "Path to thee public key used for ssh access"
}

variable "privat_key_path" {
  type        = "string"
  description = "Path to privat key used for provisioner connection"
}

variable "disk_image" {
  type = "string"
  description = "Disk image"
  default = "ubuntu-1604-xenial-v20190628"
}