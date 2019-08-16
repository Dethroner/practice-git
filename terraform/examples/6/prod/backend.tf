#prod terraform backend
terraform {
  backend "gcs" {
    bucket = "dethroner-terraform-prod"
    prefix = "reddit-prod"
  }
}
