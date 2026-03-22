# -------------------------
# NAT Gateway for Counting Subnet (Private)
# -------------------------

# NAT Gateway needs an Elastic IP (in the public subnet's AZ is fine)
resource "aws_eip" "counting_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "Counting-NAT-EIP"
  }
}

# NAT Gateway MUST be in the public subnet (Dashboard-Subnet)
resource "aws_nat_gateway" "counting_nat_gw" {
  allocation_id = aws_eip.counting_nat_eip.id
  subnet_id     = aws_subnet.dashboard_subnet.id

  tags = {
    Name = "Counting-NAT-Gateway"
  }

  depends_on = [aws_internet_gateway.dashboard_counting_igw]
}

# Private route: send internet-bound traffic to NAT GW
resource "aws_route" "counting_default_to_nat" {
  route_table_id         = aws_route_table.counting_subnet_rt.id
  destination_cidr_block = var.destination_cidr_block # "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.counting_nat_gw.id
}