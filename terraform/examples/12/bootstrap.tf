resource "null_resource" "soft_install" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.keypath)
    host        = aws_instance.web.public_ip
    # port  = var.ssh_port
    # agent = true
  }

  provisioner "file" {
    source      = "conf/lemp.sh"
    destination = "/tmp/lemp.sh"
  }

    provisioner "file" {
    source      = "conf/default.conf"
    destination = "/tmp/default.conf"
  }

  provisioner "remote-exec" {
    inline = [
	  "chmod +x /tmp/lemp.sh",
      "/tmp/lemp.sh",
    ]
  }
}