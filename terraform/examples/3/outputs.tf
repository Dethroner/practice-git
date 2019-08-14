output "app_external_ip" {
  value = "${google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip}"
}
output "db_external_ip" {
  value = "${google_compute_instance.db.*.network_interface.0.access_config.0.nat_ip}"
}

# output "app2_external_ip" {
#   value = "${google_compute_instance.app2.network_interface.0.access_config.0.nat_ip}"
# }

#output "lb_external_ip" {
#  value = "${google_compute_global_forwarding_rule.reddit-forward.ip_address}"
#}
