module "vpc" {
  source = "./VPC"
}

module "ec2_instance" {
  source = "./ec2instance"
  web_app_subnet_id = module.vpc.subnet_id
  web_app_vpc_id = module.vpc.vpc_id
}