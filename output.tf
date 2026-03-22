output "dashboard_public_ip" {
  description = "Public IP to access Dashboard EC2 from your laptop"
  value       = aws_instance.dashboard_ec2.public_ip
}

output "counting_private_ip" {
  description = "Private IP of Counting EC2"
  value       = aws_instance.counting_ec2.private_ip
}