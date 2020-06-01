terraform {
  # версия terraform
  required_version = "<= 0.12.25"
}

provider "aws" {
  # Версия провайдера
  version = "~> 2.8"

  # id проекта
  access_key = var.akey
  secret_key = var.skey
  region = var.region
}

resource "aws_instance" "AWS_linux" {
  ami = var.ami
  instance_type = "t2.micro"
}