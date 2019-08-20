# Terraform variables
variable "public_key_path" {
  type        = "string"
  description = "Path to thee public key used for ssh access"
}

variable "privat_key_path" {
  type        = "string"
  description = "Path to privat key used for provisioner connection"
}

variable "ansible_disk_image" {
  type        = "string"
  description = "Path to image for ansible"
}