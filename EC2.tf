# -------------------------
# Counting EC2 (Private Subnet)
# -------------------------
module "counting_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"
  create_security_group = var.create_security_group
  name          = var.counting_ec2_name
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id                   = module.dashboard_counting_vpc.private_subnets[0]
  vpc_security_group_ids      = [module.counting_sg.security_group_id]
  key_name                    = aws_key_pair.dashboard_counting_key_pair.key_name
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
    Name = var.counting_ec2_name
  }
}

# -------------------------
# Dashboard EC2 (Public Subnet)
# -------------------------
module "dashboard_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"
  create_security_group = var.create_security_group
  name          = var.dashboard_ec2_name
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id                   = module.dashboard_counting_vpc.public_subnets[0]
  vpc_security_group_ids      = [module.dashboard_sg.security_group_id]
  key_name                    = aws_key_pair.dashboard_counting_key_pair.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -e
    apt-get update -y
    apt-get install -y unzip curl
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
    Environment="COUNTING_SERVICE_URL=http://${module.counting_ec2.private_ip}:${var.counting_port}"
    ExecStart=/usr/local/bin/dashboard-service
    Restart=always
    RestartSec=5
    [Install]
    WantedBy=multi-user.target
    SERVICE
    systemctl daemon-reload
    systemctl enable --now dashboard
    mkdir -p /home/ubuntu/.ssh
    echo "${tls_private_key.dashboard_counting_key.private_key_pem}" \
      > /home/ubuntu/.ssh/counting-access-key.pem
    chmod 600 /home/ubuntu/.ssh/counting-access-key.pem
    chown ubuntu:ubuntu /home/ubuntu/.ssh/counting-access-key.pem
  EOF

  depends_on = [module.counting_ec2]

  tags = {
    Name = var.dashboard_ec2_name
  }
}