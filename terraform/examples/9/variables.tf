# Terraform variables
variable "project" {
  type        = "string"
  description = "Project ID"
}

variable "region" {
  type        = "string"
  description = "region"
  default     = "us-west1"
}

variable "zone" {
  type        = "string"
  description = "region zone"
  default     = "us-west1-c"
}

variable "node_count" {
  type = "string"
  description = "Count of kubernetes cluster nodes"
  default = "2"
}

variable "node_machine_type" {
  type = "string"
  description = "type of GCP machine for nodes"
  default = "g1-small"
}

variable "node_disk_size" {
  type = "string"
  description = "size of node disk"
  default = "20"
}
