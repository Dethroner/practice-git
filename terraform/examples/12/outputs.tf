output "public-ip" {
  description = "A public IP address."
  value = aws_instance.web.*.public_ip
}