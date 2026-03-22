variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "enable_dns_support" {
  type        = bool
  description = "Whether to enable DNS support"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Whether to enable DNS hostnames"
  default     = true
}

variable "dashboard_az" {
  description = "AZ for the public Dashboard subnet"
  type        = string
  default     = "ap-southeast-1a"
}

variable "dashboard_subnet_cidr" {
  description = "CIDR for the public (Dashboard) subnet"
  type        = string
  default     = "172.16.1.0/24"
}

variable "map_public_ip_on_launch_for_dashboard" {
  type        = bool
  description = "Whether to map public IP on launch"
  default     = false
}


variable "counting_az" {
  description = "AZ for the private Counting subnet"
  type        = string
  default     = "ap-southeast-1b"
}

variable "counting_subnet_cidr" {
  description = "CIDR for the private (Counting) subnet"
  type        = string
  default     = "172.16.2.0/24"
}

variable "map_public_ip_on_launch_for_counting" {
  type        = bool
  description = "Whether to map public IP on launch"
  default     = false
}

variable "destination_cidr_block" {
  type        = string
  description = "default route"
  default     = "0.0.0.0/0"
}

#ssh Key
variable "key_name" {
  type        = string
  description = "description"
  default     = "dashboard-counting-key-pair"
}

variable "filepath" {
  type        = string
  description = "description"
  default     = "/home/zinko/.ssh/dashboard-counting-key-pair.pem"
}


#security group

# -------------------------
# Security Group - Names & Descriptions
# -------------------------
variable "dashboard_sg_name" {
  description = "Name of the Dashboard security group"
  type        = string
  default     = "dashboard-security-group"
}

variable "dashboard_sg_description" {
  description = "Description of the Dashboard security group"
  type        = string
  default     = "Security group for Dashboard EC2 in public subnet"
}

variable "counting_sg_name" {
  description = "Name of the Counting security group"
  type        = string
  default     = "counting-security-group"
}

variable "counting_sg_description" {
  description = "Description of the Counting security group"
  type        = string
  default     = "Security group for Counting EC2 in private subnet"
}

# -------------------------
# Security Group - Ports & Protocols
# -------------------------
variable "ssh_port" {
  description = "SSH port"
  type        = number
  default     = 22
}

variable "http_port" {
  description = "HTTP port"
  type        = number
  default     = 80
}


variable "tcp_protocol" {
  description = "TCP protocol"
  type        = string
  default     = "tcp"
}

variable "anywhere" {
  description = "Open CIDR block for public access"
  type        = string
  default     = "0.0.0.0/0"
}

# -------------------------
# Security Group - Egress
# -------------------------
variable "egress_from_port" {
  description = "Egress from port (0 = all)"
  type        = number
  default     = 0
}

variable "egress_to_port" {
  description = "Egress to port (0 = all)"
  type        = number
  default     = 0
}

variable "egress_protocol" {
  description = "Egress protocol (-1 = all)"
  type        = string
  default     = "-1"
}


# -------------------------
# EC2 Variables
# -------------------------
variable "ec2_ami" {
  description = "AMI ID - Amazon Linux 2 ap-southeast-1"
  type        = string
  default     = "ami-0e7ff22101b84bcff"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "dashboard_ec2_name" {
  description = "Name tag for Dashboard EC2"
  type        = string
  default     = "Dashboard-EC2"
}

variable "counting_ec2_name" {
  description = "Name tag for Counting EC2"
  type        = string
  default     = "Counting-EC2"
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

###Nat Gateway