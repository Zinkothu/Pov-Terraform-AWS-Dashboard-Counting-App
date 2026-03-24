# -------------------------
# Dashboard EC2 Outputs
# -------------------------
output "dashboard_public_ip" {
  description = "Public IP to access the Dashboard service"
  value       = module.dashboard_ec2.public_ip
}

# -------------------------
# Counting EC2 Outputs
# -------------------------
output "counting_private_ip" {
  description = "Private IP of the Counting service (Internal only)"
  value       = module.counting_ec2.private_ip
}

# -------------------------
# VPC Outputs (Optional but helpful)
# -------------------------
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.dashboard_counting_vpc.vpc_id
}