#deb

resource "google_compute_instance" "deb" {
  name         = "deb"
  machine_type = "g1-small"
  tags         = ["deb"]
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.ansible_disk_image}"
    }
  }
  
  network_interface {
    network = "default"
    access_config {}
  }
  
  metadata {
    # Путь до публичного ключа
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}