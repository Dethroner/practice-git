output "ansible_external_ip" {
  value = "${module.ansible.ansible_external_ip}"
}

output "deb_external_ip" {
  value = "${module.deb.deb_external_ip}"
}

output "rh_external_ip" {
  value = "${module.rh.rh_external_ip}"
}