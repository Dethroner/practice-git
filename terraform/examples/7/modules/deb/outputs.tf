#deb outputs

output "deb_external_ip" {
  value = "${google_compute_instance.deb.*.network_interface.0.access_config.0.nat_ip}"
}