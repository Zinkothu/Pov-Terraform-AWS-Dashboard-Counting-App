module "network" {
  source                = "./modules/network"
  vpc_cidr              = var.vpc_cidr
  dashboard_az          = var.dashboard_az
  dashboard_subnet_cidr = var.dashboard_subnet_cidr
  counting_az           = var.counting_az
  counting_subnet_cidr  = var.counting_subnet_cidr
}

module "security" {
  source                = "./modules/security"
  vpc_id                = module.network.vpc_id
  # Use the output from the network module, not the variable directly!
  dashboard_subnet_cidr = module.network.dashboard_subnet_cidr 
  
  # Optional: if you want to change ports from root
  dashboard_port        = var.dashboard_port
  counting_port         = var.counting_port
}

module "compute" {
  source              = "./modules/compute"
  ec2_ami             = var.ec2_ami
  ec2_instance_type   = var.ec2_instance_type
  key_name            = var.key_name
  dashboard_subnet_id = module.network.dashboard_subnet_id
  counting_subnet_id  = module.network.counting_subnet_id
  dashboard_sg_id     = module.security.dashboard_sg_id
  counting_sg_id      = module.security.counting_sg_id
  dashboard_port      = var.dashboard_port
  counting_port       = var.counting_port
}