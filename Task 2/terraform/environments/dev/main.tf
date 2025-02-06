module "vpc" {
  source     = "../../modules/vpc"
  provider   = "aws"
  cidr_block = "10.1.0.0/16"
}

module "security_group" {
  source         = "../../modules/security-group"
  vpc_id         = module.vpc.vpc_id
  allowed_ports  = [22, 80, 443]
}

module "iam" {
  source    = "../../modules/iam"
  role_name = "dev-role"
  secrets   = { "DB_PASSWORD" = "secure123" }
}

module "vm" {
  source            = "../../modules/vm"
  provider          = "aws"
  instance_type     = "t3.micro"
  vpc_id           = module.vpc.vpc_id
  security_group_id = module.security_group.sg_id
}