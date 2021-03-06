terraform {
  required_version = "~> 0.11.11"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region = "${var.region}"
}
resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }
  tags = ["reddit-app"]
  network_interface {
    network = "default"
    access_config {}
  }
  connection {
    type     = "ssh"
    user     = "appuser"
    agent = false
    private_key = "${file("~/.ssh/appuser")}"
  }
  provisioner "file" {
   source      = "files/puma.service"
   destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["reddit-app"]
} 