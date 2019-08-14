#app variables
variable "public_key_path" {
  type = "string"
  description = "Path to the public key used to connect to instance"
}

variable "zone" {
  type = "string"
  description = "Zone"
}

variable "app_disk_image" {
  type = "string"
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}

variable "instance_count" {
  type = "string"
  description = "Count instances"
  default = "1"
}