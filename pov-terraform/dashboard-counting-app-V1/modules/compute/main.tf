# -------------------------
# SSH Key Pair
# -------------------------
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = var.filepath
  file_permission = "0600"
}

# -------------------------
# Counting EC2 (Private Subnet)
# -------------------------
resource "aws_instance" "counting" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.counting_subnet_id
  vpc_security_group_ids      = [var.counting_sg_id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = false

  user_data = <<-EOF
    #!/bin/bash
    set -e

    apt-get update -y
    apt-get install -y curl unzip

    curl -L https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/counting-service_linux_amd64.zip \
      -o /tmp/counting.zip
    cd /tmp && unzip -o counting.zip
    mv /tmp/counting-service_linux_amd64 /usr/local/bin/counting-service
    chmod +x /usr/local/bin/counting-service

    cat <<'SERVICE' > /etc/systemd/system/counting.service
    [Unit]
    Description=Counting Service
    After=network.target

    [Service]
    Environment="PORT=${var.counting_port}"
    ExecStart=/usr/local/bin/counting-service
    Restart=always
    RestartSec=5

    [Install]
    WantedBy=multi-user.target
    SERVICE

    systemctl daemon-reload
    systemctl enable --now counting
  EOF

  tags = {
    Name = "${var.name_prefix}-counting-ec2"
  }
}

# -------------------------
# Dashboard EC2 (Public Subnet)
# -------------------------
resource "aws_instance" "dashboard" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.dashboard_subnet_id
  vpc_security_group_ids      = [var.dashboard_sg_id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -e

    apt-get update -y
    apt-get install -y curl unzip

    curl -L https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/dashboard-service_linux_amd64.zip \
      -o /tmp/dashboard.zip
    cd /tmp && unzip -o dashboard.zip
    mv /tmp/dashboard-service_linux_amd64 /usr/local/bin/dashboard-service
    chmod +x /usr/local/bin/dashboard-service

    cat <<'SERVICE' > /etc/systemd/system/dashboard.service
    [Unit]
    Description=Dashboard Service
    After=network.target

    [Service]
    Environment="PORT=${var.dashboard_port}"
    Environment="COUNTING_SERVICE_URL=http://${aws_instance.counting.private_ip}:${var.counting_port}"
    ExecStart=/usr/local/bin/dashboard-service
    Restart=always
    RestartSec=5

    [Install]
    WantedBy=multi-user.target
    SERVICE

    systemctl daemon-reload
    systemctl enable --now dashboard

    mkdir -p /home/ubuntu/.ssh
    echo "${tls_private_key.this.private_key_pem}" \
      > /home/ubuntu/.ssh/counting-access-key.pem
    chmod 600 /home/ubuntu/.ssh/counting-access-key.pem
    chown ubuntu:ubuntu /home/ubuntu/.ssh/counting-access-key.pem
  EOF

  depends_on = [aws_instance.counting]

  tags = {
    Name = "${var.name_prefix}-dashboard-ec2"
  }
}