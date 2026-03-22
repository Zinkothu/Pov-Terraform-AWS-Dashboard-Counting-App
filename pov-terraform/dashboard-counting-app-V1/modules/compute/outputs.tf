output "dashboard_public_ip" {
  description = "Public IP of the Dashboard EC2"
  value       = aws_instance.dashboard.public_ip
}

output "counting_private_ip" {
  description = "Private IP of the Counting EC2"
  value       = aws_instance.counting.private_ip
}

output "key_pair_name" {
  description = "Name of the SSH Key Pair"
  value       = aws_key_pair.this.key_name
}

output "private_key_path" {
  description = "Local path where the private key was saved"
  value       = var.filepath
}