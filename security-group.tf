# -------------------------
# Security Group - Dashboard (Public)
# -------------------------
resource "aws_security_group" "dashboard_sg" {
  name        = var.dashboard_sg_name
  description = var.dashboard_sg_description
  vpc_id      = aws_vpc.dashboard_counting_vpc.id

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
    description = "dashboard from anywhere"
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
    Name = var.dashboard_sg_name
  }
}

# -------------------------
# Security Group - Counting (Private)
# -------------------------
resource "aws_security_group" "counting_sg" {
  name        = var.counting_sg_name
  description = var.counting_sg_description
  vpc_id      = aws_vpc.dashboard_counting_vpc.id

  ingress {
    description = "SSH from Dashboard Subnet only"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.dashboard_subnet_cidr]
  }

  ingress {
    description = "HTTP from Dashboard Subnet only"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.dashboard_subnet_cidr]
  }
  ingress {
    description = "counting port from Dashboard Subnet only"
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
    Name = var.counting_sg_name
  }
}