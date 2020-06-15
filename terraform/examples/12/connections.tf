provider "aws" {
  version           = "~> 2.8"

  access_key        = var.akey
  secret_key        = var.skey
  region            = var.region
}