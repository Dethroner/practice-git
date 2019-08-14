### PROD ###
terraform {
  # версия terraform
  required_version = "~> 0.11.11"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"

  # id проекта
  project = "${var.project}"

  region = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  instance_count  = "${var.instance_count}"
  db_hostname = "${module.db.db_internal_ip}"
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
