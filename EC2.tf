# -------------------------
# Counting EC2 (Private Subnet - ap-southeast-1b)
# -------------------------
resource "aws_instance" "counting_ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.counting_subnet.id
  vpc_security_group_ids      = [aws_security_group.counting_sg.id]
  key_name                    = aws_key_pair.dashboard_counting_key_pair.key_name
  associate_public_ip_address = false

  user_data = <<-EOF
    #!/bin/bash
    set -e

    apt-get update -y
    apt-get install -y curl unzip

    # Download Counting binary
    curl -L https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/counting-service_linux_amd64.zip \
      -o /tmp/counting.zip
    cd /tmp && unzip -o counting.zip
    mv /tmp/counting-service_linux_amd64 /usr/local/bin/counting-service
    chmod +x /usr/local/bin/counting-service

    # Create systemd service
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
    Name = var.counting_ec2_name
  }
}

# -------------------------
# Dashboard EC2 (Public Subnet - ap-southeast-1a)
# -------------------------
resource "aws_instance" "dashboard_ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.dashboard_subnet.id
  vpc_security_group_ids      = [aws_security_group.dashboard_sg.id]
  key_name                    = aws_key_pair.dashboard_counting_key_pair.key_name
  associate_public_ip_address = true

# user_data = <<-EOF
#     #!/bin/bash
#     set -e

#     # AL2023 uses dnf; curl-minimal is already installed — do NOT install curl
#     dnf -y install unzip

#     # Download Dashboard binary
#     curl -L https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/dashboard-service_linux_amd64.zip \
#       -o /tmp/dashboard.zip
#     cd /tmp && unzip -o dashboard.zip
#     mv /tmp/dashboard-service_linux_amd64 /usr/local/bin/dashboard-service
#     chmod +x /usr/local/bin/dashboard-service

#     # Create systemd service
#     cat <<'SERVICE' > /etc/systemd/system/dashboard.service
#     [Unit]
#     Description=Dashboard Service
#     After=network.target

#     [Service]
#     Environment="PORT=${var.dashboard_port}"
#     Environment="COUNTING_SERVICE_URL=http://${aws_instance.counting_ec2.private_ip}:${var.counting_port}"
#     ExecStart=/usr/local/bin/dashboard-service
#     Restart=always
#     RestartSec=5

#     [Install]
#     WantedBy=multi-user.target
#     SERVICE

#     systemctl daemon-reload
#     systemctl enable --now dashboard

#     # Copy private key so Dashboard EC2 can SSH into Counting EC2
#     mkdir -p /home/ec2-user/.ssh
#     echo "${tls_private_key.dashboard_counting_key.private_key_pem}" \
#       > /home/ec2-user/.ssh/counting-access-key.pem
#     chmod 600 /home/ec2-user/.ssh/counting-access-key.pem
#     chown ec2-user:ec2-user /home/ec2-user/.ssh/counting-access-key.pem
#   EOF
  user_data = <<-EOF
    #!/bin/bash
    set -e

    # Ubuntu uses apt
    apt-get update -y
    apt-get install -y unzip curl

    # Download Dashboard binary
    curl -L https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/dashboard-service_linux_amd64.zip \
      -o /tmp/dashboard.zip
    cd /tmp && unzip -o dashboard.zip
    mv /tmp/dashboard-service_linux_amd64 /usr/local/bin/dashboard-service
    chmod +x /usr/local/bin/dashboard-service

    # Create systemd service
    cat <<'SERVICE' > /etc/systemd/system/dashboard.service
    [Unit]
    Description=Dashboard Service
    After=network.target

    [Service]
    Environment="PORT=${var.dashboard_port}"
    Environment="COUNTING_SERVICE_URL=http://${aws_instance.counting_ec2.private_ip}:${var.counting_port}"
    ExecStart=/usr/local/bin/dashboard-service
    Restart=always
    RestartSec=5

    [Install]
    WantedBy=multi-user.target
    SERVICE

    systemctl daemon-reload
    systemctl enable --now dashboard

    # Copy private key so Dashboard EC2 can SSH into Counting EC2
    mkdir -p /home/ubuntu/.ssh
    echo "${tls_private_key.dashboard_counting_key.private_key_pem}" \
      > /home/ubuntu/.ssh/counting-access-key.pem
    chmod 600 /home/ubuntu/.ssh/counting-access-key.pem
    chown ubuntu:ubuntu /home/ubuntu/.ssh/counting-access-key.pem
  EOF
  depends_on = [aws_instance.counting_ec2]

  tags = {
    Name = var.dashboard_ec2_name
  }
}