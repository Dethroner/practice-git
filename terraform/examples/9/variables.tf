# Terraform variables
variable "project" {
  description = "Project ID"
}

variable "region" {
  default     = "us-west1"
}

variable "zone" {
  default     = "us-west1-c"
}

variable "node_count" {
  default = "2"
}

variable "node_machine_type" {
  default = "g1-small"
}

variable "node_disk_size" {
  default = "20"
}
