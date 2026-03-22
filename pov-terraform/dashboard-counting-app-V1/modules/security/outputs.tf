output "dashboard_sg_id" {
  description = "Security Group ID for Dashboard EC2"
  value       = aws_security_group.dashboard_sg.id
}

output "counting_sg_id" {
  description = "Security Group ID for Counting EC2"
  value       = aws_security_group.counting_sg.id
}