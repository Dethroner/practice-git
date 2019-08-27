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

resource "google_compute_firewall" "firewall_html" {
  name = "default-allow-html"
  description = "Allow html to instances"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags = ["deb","rh"]


}