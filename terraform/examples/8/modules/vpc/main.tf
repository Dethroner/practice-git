#vpc module
#vpc.tf
resource "google_compute_firewall" "firewall_ssh" {
  name = "default-allow-ssh"
  description = "Allow ssh to instances"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = "${var.source_ranges}"

}

resource "google_compute_firewall" "allow-http" {  
    name = "default-allow-http"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["80"]
    }

    source_ranges = "${var.source_ranges}"
    target_tags = ["http-server"]
}

resource "google_compute_firewall" "allow-https" {  
    name = "default-allow-https"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["443"]
    }

    source_ranges = "${var.source_ranges}"
    target_tags = ["https-server"]
}