terraform {
  # версия terraform
  required_version = "~> 0.11.11"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"
  # id проекта
  project = "project_id"
  region = "europe-west1-b"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  metadata {
    sshKeys = "appuser:${file("~/.ssh/appuser.pub")}"
  }
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "reddit-base-1565159335"
    }
  }
  tags = ["reddit-app"]
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
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

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешать доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применения для инстансов с перечисленными тегами
  target_tags = ["reddit-app"]
}
