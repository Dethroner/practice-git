resource "aws_instance" "web" {
  ami               = var.ami
  instance_type     = "t2.micro"
  
  key_name          = aws_key_pair.aws.key_name
  security_groups   = [aws_security_group.firewall.name]

  tags = {
   Name = "web"
  }

}