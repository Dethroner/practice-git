resource "aws_key_pair" "aws" {
  key_name          = "key"
  public_key        = var.aws_key_pair
}