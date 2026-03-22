variable "name_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
  default     = "dashboard-counting-app"
}

variable "vpc_id" {
  description = "VPC ID from the network module"
  type        = string
}

variable "dashboard_subnet_cidr" {
  description = "CIDR of the public Dashboard subnet (used to restrict Counting SG)"
  type        = string
}

# Ports
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

variable "dashboard_port" {
  description = "Dashboard service port"
  type        = number
  default     = 9002
}

variable "counting_port" {
  description = "Counting service port"
  type        = number
  default     = 9003
}

variable "tcp_protocol" {
  description = "TCP protocol"
  type        = string
  default     = "tcp"
}

variable "anywhere" {
  description = "Open CIDR for public access"
  type        = string
  default     = "0.0.0.0/0"
}

# Egress
variable "egress_from_port" {
  type    = number
  default = 0
}

variable "egress_to_port" {
  type    = number
  default = 0
}

variable "egress_protocol" {
  type    = string
  default = "-1"
}