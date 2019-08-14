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

variable "app_disk_image" {
  type = "string"
  description = "Reddit-app disk image"
  default = "reddit-app-base"
}

variable "db_disk_image" {
  type = "string"
  description = "Reddit-db disk image"
  default = "reddit-db-base"
}

variable "instance_count" {
  type = "string"
  description = "Count instances"
  default = "1"
}