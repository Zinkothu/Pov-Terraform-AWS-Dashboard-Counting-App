# -------------------------
# Security Group - Dashboard (Public)
# -------------------------
resource "aws_security_group" "dashboard_sg" {
  name        = "${var.name_prefix}-dashboard-sg"
  description = "Security group for Dashboard EC2 in public subnet"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.anywhere]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.anywhere]
  }

  ingress {
    description = "Dashboard service port from anywhere"
    from_port   = var.dashboard_port
    to_port     = var.dashboard_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.anywhere]
  }

  egress {
    description = "Allow all outbound"
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = [var.anywhere]
  }

  tags = {
    Name = "${var.name_prefix}-dashboard-sg"
  }
}

# -------------------------
# Security Group - Counting (Private)
# -------------------------
resource "aws_security_group" "counting_sg" {
  name        = "${var.name_prefix}-counting-sg"
  description = "Security group for Counting EC2 in private subnet"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from Dashboard subnet only"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.dashboard_subnet_cidr]
  }

  ingress {
    description = "HTTP from Dashboard subnet only"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.dashboard_subnet_cidr]
  }

  ingress {
    description = "Counting service port from Dashboard subnet only"
    from_port   = var.counting_port
    to_port     = var.counting_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.dashboard_subnet_cidr]
  }

  egress {
    description = "Allow all outbound"
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = [var.anywhere]
  }

  tags = {
    Name = "${var.name_prefix}-counting-sg"
  }
}