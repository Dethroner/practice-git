terraform {
  # версия terraform
  required_version = "<= 0.12.25"
}

provider "aws" {
  # Версия провайдера
  version 			= "~> 2.8"

  access_key 		= var.akey
  secret_key 		= var.skey
  region 			= var.region
}

resource "aws_key_pair" "aws" {
  key_name			= "key"
  public_key 		= var.aws_key_pair
}

resource "aws_instance" "AWS_linux" {
  ami 				= var.ami
  instance_type 	= "t2.micro"
  
  key_name			= aws_key_pair.aws.key_name
  security_groups	= [aws_security_group.allow_ssh.name]

  tags = {
   Name = "AWSLinux"
  }

}

resource "aws_security_group" "allow_ssh" {
  name				= "allow_ssh"
  description 		= "Allow SSH inbound traffic"
  vpc_id			= var.vpc_id

  ingress {
    description 	= "SSH from VPC"
    from_port		= 22
    to_port			= 22
    protocol		= "tcp"
    cidr_blocks 	= ["0.0.0.0/0"]
  }

  egress {
    from_port		= 0
    to_port			= 0
    protocol		= "-1"
    cidr_blocks 	= ["0.0.0.0/0"]
  }

  tags = {
    Name 			= "allow_ssh"
  }
}
