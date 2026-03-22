variable "name_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
  default     = "dashboard-counting-app"
}

variable "vpc_cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "172.16.0.0/16"
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "dashboard_az" {
  description = "AZ for the private Dashboard subnet"
  type        = string
  default     = "ap-southeast-1a"
}

variable "dashboard_subnet_cidr" {
  description = "A list of public subnets inside the VPC"
  type        = string
  default     = "172.16.1.0/24"
}

variable "counting_az" {
  description = "AZ for the private Counting subnet"
  type        = string
  default     = "ap-southeast-1b"
}

variable "counting_subnet_cidr" {
  description = "A list of private subnets inside the VPC"
  type        = string
  default     = "172.16.2.0/24"
}

variable "destination_cidr_block" {
  description = "Default route destination (usually 0.0.0.0/0)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "map_public_ip_on_launch_dashboard" {
  description = "Whether instances launched in the dashboard subnet get public IPs by default"
  type        = bool
  default     = true
 }