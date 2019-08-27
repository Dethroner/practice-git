#rh

resource "google_compute_instance" "rh" {
  name         = "rh"
  machine_type = "g1-small"
  tags         = ["rh"]
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "rhel-7-v20190813"
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