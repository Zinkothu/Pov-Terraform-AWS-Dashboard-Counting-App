
###
Initialization the backednd
###
Terraform init

###
format the code
###
#terraform fmt


###
Validate the code
###
terraform validate


###
check code what will happen before apply using plan
###
terraform plan

[Sun Mar 22]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V0$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.counting_nat_eip will be created
  + resource "aws_eip" "counting_nat_eip" {
      + allocation_id        = (known after apply)
      + arn                  = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = "vpc"
      + id                   = (known after apply)
      + instance             = (known after apply)
      + ipam_pool_id         = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + ptr_record           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + region               = "ap-southeast-1"
      + tags                 = {
          + "Name" = "Counting-NAT-EIP"
        }
      + tags_all             = {
          + "Name" = "Counting-NAT-EIP"
        }
    }

  # aws_instance.counting_ec2 will be created
  + resource "aws_instance" "counting_ec2" {
      + ami                                  = "ami-0e7ff22101b84bcff"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = false
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "dashboard-counting-key-pair"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "ap-southeast-1"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "Counting-EC2"
        }
      + tags_all                             = {
          + "Name" = "Counting-EC2"
        }
      + tenancy                              = (known after apply)
      + user_data                            = <<-EOT
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
            Environment="PORT=9003"
            ExecStart=/usr/local/bin/counting-service
            Restart=always
            RestartSec=5
            
            [Install]
            WantedBy=multi-user.target
            SERVICE
            
            systemctl daemon-reload
            systemctl enable --now counting
        EOT
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)

      + secondary_network_interface (known after apply)
    }

  # aws_instance.dashboard_ec2 will be created
  + resource "aws_instance" "dashboard_ec2" {
      + ami                                  = "ami-0e7ff22101b84bcff"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "dashboard-counting-key-pair"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "ap-southeast-1"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "Dashboard-EC2"
        }
      + tags_all                             = {
          + "Name" = "Dashboard-EC2"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (sensitive value)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)

      + secondary_network_interface (known after apply)
    }

  # aws_internet_gateway.dashboard_counting_igw will be created
  + resource "aws_internet_gateway" "dashboard_counting_igw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + region   = "ap-southeast-1"
      + tags     = {
          + "Name" = "Dashboard-Counting-IGW"
        }
      + tags_all = {
          + "Name" = "Dashboard-Counting-IGW"
        }
      + vpc_id   = (known after apply)
    }

  # aws_key_pair.dashboard_counting_key_pair will be created
  + resource "aws_key_pair" "dashboard_counting_key_pair" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "dashboard-counting-key-pair"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = (known after apply)
      + region          = "ap-southeast-1"
      + tags            = {
          + "Name" = "dashboard-counting-key-pair"
        }
      + tags_all        = {
          + "Name" = "dashboard-counting-key-pair"
        }
    }

  # aws_nat_gateway.counting_nat_gw will be created
  + resource "aws_nat_gateway" "counting_nat_gw" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + auto_provision_zones               = (known after apply)
      + auto_scaling_ips                   = (known after apply)
      + availability_mode                  = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + region                             = "ap-southeast-1"
      + regional_nat_gateway_address       = (known after apply)
      + regional_nat_gateway_auto_mode     = (known after apply)
      + route_table_id                     = (known after apply)
      + secondary_allocation_ids           = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags                               = {
          + "Name" = "Counting-NAT-Gateway"
        }
      + tags_all                           = {
          + "Name" = "Counting-NAT-Gateway"
        }
      + vpc_id                             = (known after apply)
    }

  # aws_route.counting_default_to_nat will be created
  + resource "aws_route" "counting_default_to_nat" {
      + destination_cidr_block = "0.0.0.0/0"
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + nat_gateway_id         = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + region                 = "ap-southeast-1"
      + route_table_id         = (known after apply)
      + state                  = (known after apply)
    }

  # aws_route.dashboard_default_to_igw will be created
  + resource "aws_route" "dashboard_default_to_igw" {
      + destination_cidr_block = "0.0.0.0/0"
      + gateway_id             = (known after apply)
      + id                     = (known after apply)
      + instance_id            = (known after apply)
      + instance_owner_id      = (known after apply)
      + network_interface_id   = (known after apply)
      + origin                 = (known after apply)
      + region                 = "ap-southeast-1"
      + route_table_id         = (known after apply)
      + state                  = (known after apply)
    }

  # aws_route_table.counting_subnet_rt will be created
  + resource "aws_route_table" "counting_subnet_rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + region           = "ap-southeast-1"
      + route            = (known after apply)
      + tags             = {
          + "Name" = "Counting-Subnet-RT"
        }
      + tags_all         = {
          + "Name" = "Counting-Subnet-RT"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.dashboard_subnet_rt will be created
  + resource "aws_route_table" "dashboard_subnet_rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + region           = "ap-southeast-1"
      + route            = (known after apply)
      + tags             = {
          + "Name" = "Dashboard-Subnet-RT"
        }
      + tags_all         = {
          + "Name" = "Dashboard-Subnet-RT"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.counting_subnet_assoc will be created
  + resource "aws_route_table_association" "counting_subnet_assoc" {
      + id             = (known after apply)
      + region         = "ap-southeast-1"
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.dashboard_subnet_association will be created
  + resource "aws_route_table_association" "dashboard_subnet_association" {
      + id             = (known after apply)
      + region         = "ap-southeast-1"
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.counting_sg will be created
  + resource "aws_security_group" "counting_sg" {
      + arn                    = (known after apply)
      + description            = "Security group for Counting EC2 in private subnet"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow all outbound"
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "172.16.1.0/24",
                ]
              + description      = "HTTP from Dashboard Subnet only"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "172.16.1.0/24",
                ]
              + description      = "SSH from Dashboard Subnet only"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "172.16.1.0/24",
                ]
              + description      = "counting port from Dashboard Subnet only"
              + from_port        = 9003
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 9003
            },
        ]
      + name                   = "counting-security-group"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-southeast-1"
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "counting-security-group"
        }
      + tags_all               = {
          + "Name" = "counting-security-group"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.dashboard_sg will be created
  + resource "aws_security_group" "dashboard_sg" {
      + arn                    = (known after apply)
      + description            = "Security group for Dashboard EC2 in public subnet"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow all outbound"
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTP from anywhere"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "SSH from anywhere"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "dashboard from anywhere"
              + from_port        = 9002
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 9002
            },
        ]
      + name                   = "dashboard-security-group"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-southeast-1"
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "dashboard-security-group"
        }
      + tags_all               = {
          + "Name" = "dashboard-security-group"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.counting_subnet will be created
  + resource "aws_subnet" "counting_subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "172.16.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block                                = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "ap-southeast-1"
      + tags                                           = {
          + "Name" = "Counting-Subnet"
        }
      + tags_all                                       = {
          + "Name" = "Counting-Subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.dashboard_subnet will be created
  + resource "aws_subnet" "dashboard_subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "172.16.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block                                = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "ap-southeast-1"
      + tags                                           = {
          + "Name" = "Dashboard-Subnet"
        }
      + tags_all                                       = {
          + "Name" = "Dashboard-Subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.dashboard_counting_vpc will be created
  + resource "aws_vpc" "dashboard_counting_vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "172.16.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + region                               = "ap-southeast-1"
      + tags                                 = {
          + "Name" = "Dashboard-Counting-VPC"
        }
      + tags_all                             = {
          + "Name" = "Dashboard-Counting-VPC"
        }
    }

  # local_file.ssh_private_key will be created
  + resource "local_file" "ssh_private_key" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0600"
      + filename             = "/home/zinko/.ssh/dashboard-counting-key-pair.pem"
      + id                   = (known after apply)
    }

  # tls_private_key.dashboard_counting_key will be created
  + resource "tls_private_key" "dashboard_counting_key" {
      + algorithm                     = "RSA"
      + ecdsa_curve                   = "P224"
      + id                            = (known after apply)
      + private_key_openssh           = (sensitive value)
      + private_key_pem               = (sensitive value)
      + private_key_pem_pkcs8         = (sensitive value)
      + public_key_fingerprint_md5    = (known after apply)
      + public_key_fingerprint_sha256 = (known after apply)
      + public_key_openssh            = (known after apply)
      + public_key_pem                = (known after apply)
      + rsa_bits                      = 4096
    }

Plan: 19 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + counting_private_ip = (known after apply)
  + dashboard_public_ip = (known after apply)

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.


###
plan and check code
###
terraform apply --auto-approve

[Sun Mar 22]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V0$ terraform state list 
aws_eip.counting_nat_eip
aws_instance.counting_ec2
aws_instance.dashboard_ec2
aws_internet_gateway.dashboard_counting_igw
aws_key_pair.dashboard_counting_key_pair
aws_nat_gateway.counting_nat_gw
aws_route.counting_default_to_nat
aws_route.dashboard_default_to_igw
aws_route_table.counting_subnet_rt
aws_route_table.dashboard_subnet_rt
aws_route_table_association.counting_subnet_assoc
aws_route_table_association.dashboard_subnet_association
aws_security_group.counting_sg
aws_security_group.dashboard_sg
aws_subnet.counting_subnet
aws_subnet.dashboard_subnet
aws_vpc.dashboard_counting_vpc
local_file.ssh_private_key
tls_private_key.dashboard_counting_key
[Sun Mar 22]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V0$ 

After that out put will show like this

Apply complete! Resources: 19 added, 0 changed, 0 destroyed.
####
Outputs:
####
counting_private_ip = "172.16.2.71"
dashboard_public_ip = "18.143.146.227"

copy dashboard Public ip and go to browser and test 

http://18.143.146.227:9002/


![image alt](https://github.com/Zinkothu/Pov-Terraform-AWS-Dashboard-Counting-App/blob/17bcb5f6db7bd4a987add4369a01c40d82627bf1/Assigment_1.png)

https://github.com/Zinkothu/Pov-Terraform-AWS-Dashboard-Counting-App/blob/17bcb5f6db7bd4a987add4369a01c40d82627bf1/Assigment_1.png

