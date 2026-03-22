# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

# Public Subnet (Dashboard)
resource "aws_subnet" "dashboard" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.dashboard_subnet_cidr
  availability_zone       = var.dashboard_az
  map_public_ip_on_launch = var.map_public_ip_on_launch_dashboard

  tags = {
    Name = "${var.name_prefix}-dashboard-public-subnet"
  }
}

# Private Subnet (Counting)
resource "aws_subnet" "counting" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.counting_subnet_cidr
  availability_zone = var.counting_az

  tags = {
    Name = "${var.name_prefix}-counting-private-subnet"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name_prefix}-public-rt"
  }
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.dashboard.id
  route_table_id = aws_route_table.public.id
}

# EIP + NAT Gateway (in public subnet)
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.name_prefix}-nat-eip"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.dashboard.id

  tags = {
    Name = "${var.name_prefix}-nat"
  }

  depends_on = [aws_internet_gateway.this]
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name_prefix}-private-rt"
  }
}

resource "aws_route" "private_default" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id         = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.counting.id
  route_table_id = aws_route_table.private.id
}