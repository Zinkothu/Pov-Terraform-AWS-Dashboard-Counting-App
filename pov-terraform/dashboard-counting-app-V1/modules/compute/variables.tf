variable "name_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
  default     = "dashboard-counting"
}

variable "ec2_ami" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "dashboard_subnet_id" {
  description = "Public subnet ID for Dashboard EC2"
  type        = string
}

variable "counting_subnet_id" {
  description = "Private subnet ID for Counting EC2"
  type        = string
}

variable "dashboard_sg_id" {
  description = "Security Group ID for Dashboard EC2"
  type        = string
}

variable "counting_sg_id" {
  description = "Security Group ID for Counting EC2"
  type        = string
}

variable "dashboard_port" {
  description = "Port for Dashboard service"
  type        = number
  default     = 9002
}

variable "counting_port" {
  description = "Port for Counting service"
  type        = number
  default     = 9003
}

variable "filepath" {
  description = "Local path to save the private key .pem file"
  type        = string
  default     = "/home/zinko/.ssh/dashboard-counting-key-pair.pem"
}