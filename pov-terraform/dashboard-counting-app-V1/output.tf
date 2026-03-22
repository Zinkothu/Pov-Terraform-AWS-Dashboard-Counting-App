# Network outputs
output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet" {
  value = module.network.dashboard_subnet_id
}

output "private_subnet" {
  value = module.network.counting_subnet_id
}

# Security outputs
output "dashboard_sg_id" {
  value = module.security.dashboard_sg_id
}

output "counting_sg_id" {
  value = module.security.counting_sg_id
}

# Compute outputs
output "dashboard_url" {
  description = "URL to access the Dashboard"
  value       = "http://${module.compute.dashboard_public_ip}:${var.dashboard_port}"
}

output "counting_private_ip" {
  value = module.compute.counting_private_ip
}

output "ssh_command" {
  description = "SSH command to connect to Dashboard EC2"
  value       = "ssh -i ${module.compute.private_key_path} ubuntu@${module.compute.dashboard_public_ip}"
}