variable "aws_region" {
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "dashboard_az" {
  default = "ap-southeast-1a"
}

variable "dashboard_subnet_cidr" {
  default = "172.16.1.0/24"
}

variable "counting_az" {
  default = "ap-southeast-1b"
}

variable "counting_subnet_cidr" {
  default = "172.16.2.0/24"
}

# --- Add these for Security & Compute ---

variable "ec2_ami" {
  description = "Ubuntu AMI ID"
  type        = string
  default     = "ami-0e7ff22101b84bcff" # Ensure this is correct for your region
}

variable "ec2_instance_type" {
  default = "t3.micro"
}

variable "dashboard_port" {
  default = 9002
}

variable "counting_port" {
  default = 9003
}

variable "key_name" {
  default = "dashboard-counting-key-pair"
}