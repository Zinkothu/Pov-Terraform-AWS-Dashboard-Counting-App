variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "dashboard-counting-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "dashboard_az" {
  description = "AZ for public (dashboard) subnet"
  type        = string
  default     = "ap-southeast-1a"
}

variable "counting_az" {
  description = "AZ for private (counting) subnet"
  type        = string
  default     = "ap-southeast-1b"
}

variable "public_subnet_cidr" {
  description = "CIDR for public (dashboard) subnet"
  type        = string
  default     = "172.16.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private (counting) subnet"
  type        = string
  default     = "172.16.2.0/24"
}


variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is `false`"
  type        = bool
  default     = false
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`"
  type        = bool
  default     = false
}


########
## Security Group variables
#########
# variable "dashboard_sg" {
#   description = "Whether to create security group"
#   type        = bool
#   default     = true
# }
# ###
variable "create_security_group" {
  description = "Determines whether a security group will be created"
  type        = bool
  default     = false
}
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
####
# variable "counting_sg" {
#   description = "Whether to create security group"
#   type        = bool
#   default     = true
# }
# ###
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
  description = "TCP protocol identifier"
  type        = string
  default     = "tcp"
}

variable "anywhere" {
  description = "Open CIDR block for public access"
  type        = string
  default     = "0.0.0.0/0"
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


####
###EC 2
####


variable "ec2_ami" {
  description = "AMI ID for EC2 instances"
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

####
##ssh-key
####

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "dashboard-counting-key-pair"
}

variable "filepath" {
  description = "Local path to save the private key"
  type        = string
  default     = "/home/zinko/.ssh/dashboard-counting-key-pair.pem"
}