# -------------------------
# Generate SSH Key Pair
# -------------------------
resource "tls_private_key" "dashboard_counting_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Register Public Key with AWS
resource "aws_key_pair" "dashboard_counting_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.dashboard_counting_key.public_key_openssh

  tags = {
    Name = var.key_name
  }
}

# Save Private Key to your laptop
resource "local_file" "ssh_private_key" {
  filename        = var.filepath
  content         = tls_private_key.dashboard_counting_key.private_key_pem
  file_permission = "0600"
}