variable "provider" {}
variable "cidr_block" { default = "10.0.0.0/16" }

provider "aws" { region = "us-east-1" }
provider "google" { project = var.project_id }

resource "aws_vpc" "main" {
  count      = var.provider == "aws" ? 1 : 0
  cidr_block = var.cidr_block
}

resource "google_compute_network" "main" {
  count       = var.provider == "gcp" ? 1 : 0
  name        = "main-network"
  auto_create_subnetworks = false
}

output "vpc_id" {
  value = var.provider == "aws" ? aws_vpc.main[0].id : google_compute_network.main[0].id
}