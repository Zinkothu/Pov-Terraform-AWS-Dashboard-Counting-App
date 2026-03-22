# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "dashboard_counting_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "Dashboard-Counting-VPC"
  }
}

# -------------------------
# Internet Gateway (for public subnet only)
# -------------------------
resource "aws_internet_gateway" "dashboard_counting_igw" {
  vpc_id = aws_vpc.dashboard_counting_vpc.id

  tags = {
    Name = "Dashboard-Counting-IGW"
  }
}

# -------------------------
# Subnets
# -------------------------
resource "aws_subnet" "dashboard_subnet" {
  vpc_id                  = aws_vpc.dashboard_counting_vpc.id
  cidr_block              = var.dashboard_subnet_cidr
  availability_zone       = var.dashboard_az
  map_public_ip_on_launch = var.map_public_ip_on_launch_for_dashboard

  tags = {
    Name = "Dashboard-Subnet"
  }
}

resource "aws_subnet" "counting_subnet" {
  vpc_id                  = aws_vpc.dashboard_counting_vpc.id
  cidr_block              = var.counting_subnet_cidr
  availability_zone       = var.counting_az
  map_public_ip_on_launch = var.map_public_ip_on_launch_for_counting

  tags = {
    Name = "Counting-Subnet"
  }
}

# -------------------------
# Route Tables Dashboard Subnet (public)
# -------------------------
resource "aws_route_table" "dashboard_subnet_rt" {
  vpc_id = aws_vpc.dashboard_counting_vpc.id

  tags = {
    Name = "Dashboard-Subnet-RT"
  }
}

resource "aws_route" "dashboard_default_to_igw" {
  route_table_id         = aws_route_table.dashboard_subnet_rt.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.dashboard_counting_igw.id
}

resource "aws_route_table_association" "dashboard_subnet_association" {
  subnet_id      = aws_subnet.dashboard_subnet.id
  route_table_id = aws_route_table.dashboard_subnet_rt.id
}

# -------------------------
# Route Tables  Counting Subnet (private)
# -------------------------
resource "aws_route_table" "counting_subnet_rt" {
  vpc_id = aws_vpc.dashboard_counting_vpc.id

  tags = {
    Name = "Counting-Subnet-RT"
  }
}

# No default route for private subnet (no internet access)

resource "aws_route_table_association" "counting_subnet_assoc" {
  subnet_id      = aws_subnet.counting_subnet.id
  route_table_id = aws_route_table.counting_subnet_rt.id
}