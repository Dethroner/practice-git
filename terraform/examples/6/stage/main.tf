### STAGE ###
terraform {
  required_version = "~> 0.11.11"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region = "${var.region}"
}

#module "storage_bucket" {
#    source                     = "../modules/storage_bucket"
#    name                       = "dethroner-terraform-stage"
#
#    lifecycle_rule_action_type = "Delete"
#    versioning_enabled         = false
#}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  instance_count  = "${var.instance_count}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = "${var.source_ranges}"
}