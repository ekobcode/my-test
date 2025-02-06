variable "vpc_id" {}
variable "allowed_ports" { type = list(number) }

resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

output "sg_id" {
  value = aws_security_group.sg.id
}