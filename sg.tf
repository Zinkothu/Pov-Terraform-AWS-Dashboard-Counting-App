# -------------------------
# Security Group - Dashboard (Public)
# -------------------------
module "dashboard_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"
#   dashboard_sg = var.dashboard_sg
  name        = var.dashboard_sg_name
  description = var.dashboard_sg_description
  vpc_id      = module.dashboard_counting_vpc.vpc_id

  # -----------------------
  # Ingress Rules
  # -----------------------
  ingress_with_cidr_blocks = [
    {
      description = "SSH from anywhere"
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = var.tcp_protocol
      cidr_blocks = var.anywhere
    },
    {
      description = "HTTP from anywhere"
      from_port   = var.http_port
      to_port     = var.http_port
      protocol    = var.tcp_protocol
      cidr_blocks = var.anywhere
    },
    {
      description = "Dashboard port from anywhere"
      from_port   = var.dashboard_port
      to_port     = var.dashboard_port
      protocol    = var.tcp_protocol
      cidr_blocks = var.anywhere
    }
  ]

  # -----------------------
  # Egress Rules
  # -----------------------
  egress_with_cidr_blocks = [
    {
      description = "Allow all outbound"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = var.anywhere
    }
  ]

  tags = {
    Name = var.dashboard_sg_name
  }
}

# -------------------------
# Security Group - Counting (Private)
# -------------------------
module "counting_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

#   counting_sg = var.counting_sg
  name        = var.counting_sg_name
  description = var.counting_sg_description
  vpc_id      = module.dashboard_counting_vpc.vpc_id

  # -----------------------
  # Ingress Rules
  # -----------------------
  ingress_with_cidr_blocks = [
    {
      description = "SSH from Dashboard subnet only"
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = var.tcp_protocol
      cidr_blocks = var.public_subnet_cidr
    },
    {
      description = "HTTP from Dashboard subnet only"
      from_port   = var.http_port
      to_port     = var.http_port
      protocol    = var.tcp_protocol
      cidr_blocks = var.public_subnet_cidr
    },
    {
      description = "Counting port from Dashboard subnet only"
      from_port   = var.counting_port
      to_port     = var.counting_port
      protocol    = var.tcp_protocol
      cidr_blocks = var.public_subnet_cidr
    }
  ]

  # -----------------------
  # Egress Rules
  # -----------------------
  egress_with_cidr_blocks = [
    {
      description = "Allow all outbound"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = var.anywhere
    }
  ]

  tags = {
    Name = var.counting_sg_name
  }
}