resource "google_compute_instance" "ci" {
  name         			= "server-ci"
  machine_type 			= "custom-1-3840"
  zone         			= "${var.zone}"
  tags         			= ["server-ci"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
	  size  = "100"
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    user  = "appuser"
    agent = false
    private_key = "${file(var.privat_key_path)}"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
  
  provisioner "file" {
    source      = "files/docker-compose.yml"
    destination = "/srv/gitlab/docker-compose.yml"
  }

}
