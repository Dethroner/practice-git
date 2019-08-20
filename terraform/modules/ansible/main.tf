#ansible

resource "google_compute_instance" "ansible" {
  name         = "ansible"
  machine_type = "g1-small"
  tags         = ["ansible"]
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.ansible_disk_image}"
    }
  }
  
  network_interface {
    network = "default"

    access_config {
      nat_ip = "${google_compute_address.ansible_ip.address}"
    }
  }
  
  metadata {
    # Путь до публичного ключа
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  # Подключение провиженоров к ВМ
  connection {
    type  = "ssh"
    user  = "appuser"
    agent = false

    # путь до приватного ключа
    private_key = "${file(var.privat_key_path)}"
  }

  provisioner "remote-exec" {
    script = "./files/ansible.sh"
  }
  
  provisioner "file" {
    source      = "${var.privat_key_path}"
    destination = "/home/appuser/.ssh/appuser"
  }
  
  provisioner "file" {
    source      = "../ansible"
    destination = "/home/appuser"
  }
 
provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/appuser/.ssh/appuser"
    ]
  } 
}
resource "google_compute_address" "ansible_ip" {
  name = "ansible-ip"
}