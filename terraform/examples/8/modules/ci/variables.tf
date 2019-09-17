variable "public_key_path" {
  type = "string"
  description = "Path to the public key used to connect to instance"
}

variable "privat_key_path" {
  type        = "string"
  description = "Path to privat key used for provisioner connection"
}

variable "zone" {
  type = "string"
  description = "Zone"
}

variable "disk_image" {
  type = "string"
  description = "Disk image"
  default = "ubuntu-1604-xenial-v20190628"
}
