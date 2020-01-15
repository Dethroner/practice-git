### KUBERNETES GCP###
terraform {
  # версия terraform
  required_version = "~> 0.11.7"
}

provider "google" {
  # Версия провайдера
  version = "2.16.0"

  # id проекта
  project = "${var.project}"

  region = "${var.region}"
}

resource "google_container_cluster" "cluster" {
  name     = "cluster"
  location = "${var.zone}"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count = 1

  # temporary nodes
  node_config {
    machine_type = "g1-small"
    disk_size_gb = "10"
    preemptible = "true"
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  addons_config {
    kubernetes_dashboard {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "reddit-pool" {
  name = "reddit-pool"
  location = "${var.zone}"
  cluster = "${google_container_cluster.cluster.name}"
  node_count = "${var.node_count}"

  node_config {
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_compute_firewall" "kubernetes-cluster" {
  name = "kube-cluster-allow"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}
