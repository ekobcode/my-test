variable "provider" {}
variable "instance_type" {}
variable "vpc_id" {}
variable "security_group_id" {}

resource "aws_instance" "vm" {
  count         = var.provider == "aws" ? 1 : 0
  ami           = "ami-12345678"
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
}

resource "google_compute_instance" "vm" {
  count        = var.provider == "gcp" ? 1 : 0
  name         = "vm-instance"
  machine_type = var.instance_type
  network_interface {
    network = var.vpc_id
  }
}

output "vm_id" {
  value = var.provider == "aws" ? aws_instance.vm[0].id : google_compute_instance.vm[0].id
}