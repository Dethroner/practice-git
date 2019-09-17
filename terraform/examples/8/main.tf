terraform {
  required_version = "~> 0.11.11"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region = "${var.region}"
}

module "ci" {
  source = "modules/ci"
  public_key_path = "${var.public_key_path}"
  privat_key_path = "${var.privat_key_path}"
  zone = "${var.zone}"
  disk_image = "${var.disk_image}"
}

module "vpc" {
  source = "modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}