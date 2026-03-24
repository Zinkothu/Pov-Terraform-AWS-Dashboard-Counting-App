module "dashboard_counting_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  # -----------------------
  # VPC
  # -----------------------
  name = var.vpc_name
  cidr = var.vpc_cidr

  # -----------------------
  # Subnets
  # -----------------------
  azs             = [var.dashboard_az, var.counting_az]
  public_subnets  = [var.public_subnet_cidr]  # Dashboard subnet
  private_subnets = [var.private_subnet_cidr] # Counting subnet

  # Auto assign public IP to instances in public subnet
  map_public_ip_on_launch = var.map_public_ip_on_launch

  # -----------------------
  # Internet Gateway
  # Created automatically when public_subnets is defined
  # -----------------------
  igw_tags = {
    Name = var.igw_tags["Name"]
  }

  # -----------------------
  # NAT Gateway
  # Placed in public subnet, used by private subnet
  # -----------------------
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  nat_gateway_tags = {
    Name = "dashboard-counting-nat-gw"
  }

  nat_eip_tags = {
    Name = "dashboard-counting-nat-eip"
  }

  # -----------------------
  # Public Route Table
  # Route: 0.0.0.0/0 -> IGW (auto-created)
  # Association: dashboard-public-subnet (auto-created)
  # -----------------------
  public_route_table_tags = {
    Name = "dashboard-public-rt"
  }

  public_subnet_tags = {
    Name = "dashboard-public-subnet"
    Tier = "Public"
  }

  # -----------------------
  # Private Route Table
  # Route: 0.0.0.0/0 -> NAT GW (auto-created)
  # Association: counting-private-subnet (auto-created)
  # -----------------------
  private_route_table_tags = {
    Name = "counting-private-rt"
  }

  private_subnet_tags = {
    Name = "counting-private-subnet"
    Tier = "Private"
  }

  # -----------------------
  # DNS
  # -----------------------
  enable_dns_support   = true
  enable_dns_hostnames = true

  # -----------------------
  # VPC Tags
  # -----------------------
  tags = {
    Name    = var.vpc_name
    Project = "Dashboard Counting App"
  }
}