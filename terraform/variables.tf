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

variable "ansible_disk_image" {
  type        = "string"
  description = "Path to image for ansible"
}

variable "source_ranges" {
  type        = "list"
  description = "Source ranges for ssh firewall rule"
  default     = ["0.0.0.0/0"]
}