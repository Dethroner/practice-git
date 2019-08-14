#db variables
variable "public_key_path" {
  type = "string"
  description = "Path to the public key used to connect to instance"
}

variable "zone" {
  type = "string"
  description = "Zone"
}

variable "db_disk_image" {
  type = "string"
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}