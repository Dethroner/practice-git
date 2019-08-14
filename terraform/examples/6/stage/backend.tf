#stage terraform backend
terraform {
  backend "gcs" {
    bucket = "dethroner-terraform-stage"
    prefix = "reddit-stage"
  }
}