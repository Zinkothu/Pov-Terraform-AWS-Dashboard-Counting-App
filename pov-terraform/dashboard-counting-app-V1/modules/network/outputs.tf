output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "dashboard_subnet_id" {
  description = "The ID of the public Dashboard subnet"
  value       = aws_subnet.dashboard.id
}

output "counting_subnet_id" {
  description = "The ID of the private Counting subnet"
  value       = aws_subnet.counting.id
}

output "dashboard_subnet_cidr" {
  description = "The CIDR of the public Dashboard subnet"
  value       = aws_subnet.dashboard.cidr_block
}

output "counting_subnet_cidr" {
  description = "The CIDR of the private Counting subnet"
  value       = aws_subnet.counting.cidr_block
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}