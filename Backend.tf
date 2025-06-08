terraform {
  backend "gcs" {
    bucket = "terraform-state-bootcamp-bucket"
    prefix = "terraform/state"
  }
}
