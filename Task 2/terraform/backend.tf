terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}