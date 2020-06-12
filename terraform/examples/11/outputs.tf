output "external-ip" {
  value = aws_instance.AWS_linux.*.public_ip
}