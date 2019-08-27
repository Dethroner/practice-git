###Ansible infrastructure
terraform {
  # версия terraform
  required_version	  = "~> 0.11.11"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"

  # id проекта
  project = "${var.project}"
  region  = "${var.region}"
  zone    = "${var.zone}"
}

module "ansible" {
  source          	 = "./modules/ansible"
  ansible_disk_image = "${var.ansible_disk_image}"
  public_key_path 	 = "${var.public_key_path}"
  privat_key_path 	 = "${var.privat_key_path}"
}

module "deb" {
  source          	 = "./modules/deb"
  ansible_disk_image = "${var.ansible_disk_image}"
  public_key_path 	 = "${var.public_key_path}"
}

module "rh" {
  source          	 = "./modules/rh"
  public_key_path 	 = "${var.public_key_path}"
}

module "vpc" {
  source			 = "./modules/vpc"
  source_ranges		 = "${var.source_ranges}"
}