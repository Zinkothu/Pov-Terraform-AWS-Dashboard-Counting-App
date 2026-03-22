network  ──► outputs vpc_id, subnet IDs
                │
security ──► uses vpc_id from network
                │
compute  ──► uses subnet IDs from network
             uses sg IDs from security



First Network Module

[Sun Mar 22]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V1/modules$ cd network/


touch main.tf outputs.tf variables.tf



[Mon Mar 23]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V1$ terraform init
Initializing the backend...
Initializing modules...
- compute in modules/compute
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Finding latest version of hashicorp/tls...
- Finding latest version of hashicorp/local...
- Using previously-installed hashicorp/aws v6.37.0
- Installing hashicorp/tls v4.2.1...
- Installed hashicorp/tls v4.2.1 (signed by HashiCorp)
- Installing hashicorp/local v2.7.0...
- Installed hashicorp/local v2.7.0 (signed by HashiCorp)
Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[Mon Mar 23]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V1$ terraform init
Initializing the backend...
Initializing modules...
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/tls from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file
- Using previously-installed hashicorp/tls v4.2.1
- Using previously-installed hashicorp/local v2.7.0
╷
│ Error: Failed to query available provider packages
│ 
│ Could not retrieve the list of available versions for provider hashicorp/aws: locked provider registry.terraform.io/hashicorp/aws 6.37.0 does not match configured version constraint ~> 5.0; must use terraform
│ init -upgrade to allow selection of new versions
│ 
│ To see which modules are currently depending on hashicorp/aws and what versions are specified, run the following command:
│     terraform providers
╵
[Mon Mar 23]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V1$ terraform init -upgrade
Initializing the backend...
Upgrading modules...
- compute in modules/compute
- network in modules/network
- security in modules/security
Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 5.0"...
- Finding hashicorp/tls versions matching "~> 4.0"...
- Finding hashicorp/local versions matching "~> 2.0"...
- Using previously-installed hashicorp/local v2.7.0
- Installing hashicorp/aws v5.100.0...
- Installed hashicorp/aws v5.100.0 (signed by HashiCorp)
- Using previously-installed hashicorp/tls v4.2.1
Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[Mon Mar 23]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V1$ terraform validate
Success! The configuration is valid.

[Mon Mar 23]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V1$ terraform plan
module.network.aws_eip.nat: Refreshing state... [id=eipalloc-0670ac688d075180b]
module.network.aws_vpc.this: Refreshing state... [id=vpc-0541890c989301218]
module.network.aws_route_table.public: Refreshing state... [id=rtb-0494aaed0b2e39907]
module.network.aws_subnet.dashboard: Refreshing state... [id=subnet-03fa2deb4e076da0f]
module.network.aws_subnet.counting: Refreshing state... [id=subnet-0beca770312ce4417]
module.network.aws_route_table.private: Refreshing state... [id=rtb-06b9631fe64019b97]
module.security.aws_security_group.dashboard_sg: Refreshing state... [id=sg-0110b861dc2ab8207]
module.network.aws_internet_gateway.this: Refreshing state... [id=igw-03a1bcc7400709f2f]
module.network.aws_route_table_association.private_assoc: Refreshing state... [id=rtbassoc-0e24448a42821d14c]
module.network.aws_route.public_default: Refreshing state... [id=r-rtb-0494aaed0b2e399071080289494]
module.network.aws_route_table_association.public_assoc: Refreshing state... [id=rtbassoc-0723a67a72abb667d]
module.network.aws_nat_gateway.this: Refreshing state... [id=nat-00ca6435d9bc3e791]
module.security.aws_security_group.counting_sg: Refreshing state... [id=sg-02d58dcef2c7c9d33]
module.network.aws_route.private_default: Refreshing state... [id=r-rtb-06b9631fe64019b971080289494]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.compute.aws_instance.counting will be created
  + resource "aws_instance" "counting" {
      + ami                                  = "ami-0e7ff22101b84bcff"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = false
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
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
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-0beca770312ce4417"
      + tags                                 = {
          + "Name" = "dashboard-counting-counting-ec2"
        }
      + tags_all                             = {
          + "Name" = "dashboard-counting-counting-ec2"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "ad7bf95c64158fd10590a20a172ea4fb93c2774c"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = [
          + "sg-02d58dcef2c7c9d33",
        ]

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # module.compute.aws_instance.dashboard will be created
  + resource "aws_instance" "dashboard" {
      + ami                                  = "ami-0e7ff22101b84bcff"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
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
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-03fa2deb4e076da0f"
      + tags                                 = {
          + "Name" = "dashboard-counting-dashboard-ec2"
        }
      + tags_all                             = {
          + "Name" = "dashboard-counting-dashboard-ec2"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (sensitive value)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = [
          + "sg-0110b861dc2ab8207",
        ]

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # module.compute.aws_key_pair.this will be created
  + resource "aws_key_pair" "this" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "dashboard-counting-key-pair"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = (known after apply)
      + tags_all        = (known after apply)
    }

  # module.compute.local_file.private_key will be created
  + resource "local_file" "private_key" {
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

  # module.compute.tls_private_key.this will be created
  + resource "tls_private_key" "this" {
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

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + counting_private_ip = (known after apply)
  + dashboard_url       = (known after apply)
  + ssh_command         = (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
[Mon Mar 23]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V1$ terraform apply --auto-approve
module.network.aws_vpc.this: Refreshing state... [id=vpc-0541890c989301218]
module.network.aws_eip.nat: Refreshing state... [id=eipalloc-0670ac688d075180b]
module.network.aws_route_table.public: Refreshing state... [id=rtb-0494aaed0b2e39907]
module.network.aws_route_table.private: Refreshing state... [id=rtb-06b9631fe64019b97]
module.network.aws_internet_gateway.this: Refreshing state... [id=igw-03a1bcc7400709f2f]
module.network.aws_subnet.dashboard: Refreshing state... [id=subnet-03fa2deb4e076da0f]
module.network.aws_subnet.counting: Refreshing state... [id=subnet-0beca770312ce4417]
module.security.aws_security_group.dashboard_sg: Refreshing state... [id=sg-0110b861dc2ab8207]
module.network.aws_route.public_default: Refreshing state... [id=r-rtb-0494aaed0b2e399071080289494]
module.network.aws_route_table_association.public_assoc: Refreshing state... [id=rtbassoc-0723a67a72abb667d]
module.network.aws_nat_gateway.this: Refreshing state... [id=nat-00ca6435d9bc3e791]
module.security.aws_security_group.counting_sg: Refreshing state... [id=sg-02d58dcef2c7c9d33]
module.network.aws_route_table_association.private_assoc: Refreshing state... [id=rtbassoc-0e24448a42821d14c]
module.network.aws_route.private_default: Refreshing state... [id=r-rtb-06b9631fe64019b971080289494]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.compute.aws_instance.counting will be created
  + resource "aws_instance" "counting" {
      + ami                                  = "ami-0e7ff22101b84bcff"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = false
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
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
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-0beca770312ce4417"
      + tags                                 = {
          + "Name" = "dashboard-counting-counting-ec2"
        }
      + tags_all                             = {
          + "Name" = "dashboard-counting-counting-ec2"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "ad7bf95c64158fd10590a20a172ea4fb93c2774c"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = [
          + "sg-02d58dcef2c7c9d33",
        ]

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # module.compute.aws_instance.dashboard will be created
  + resource "aws_instance" "dashboard" {
      + ami                                  = "ami-0e7ff22101b84bcff"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
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
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-03fa2deb4e076da0f"
      + tags                                 = {
          + "Name" = "dashboard-counting-dashboard-ec2"
        }
      + tags_all                             = {
          + "Name" = "dashboard-counting-dashboard-ec2"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (sensitive value)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = [
          + "sg-0110b861dc2ab8207",
        ]

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # module.compute.aws_key_pair.this will be created
  + resource "aws_key_pair" "this" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "dashboard-counting-key-pair"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = (known after apply)
      + tags_all        = (known after apply)
    }

  # module.compute.local_file.private_key will be created
  + resource "local_file" "private_key" {
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

  # module.compute.tls_private_key.this will be created
  + resource "tls_private_key" "this" {
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

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + counting_private_ip = (known after apply)
  + dashboard_url       = (known after apply)
  + ssh_command         = (known after apply)
module.compute.tls_private_key.this: Creating...
module.compute.tls_private_key.this: Creation complete after 4s [id=be70c6659511cdb8e9928b1f9feb2dc107c75e52]
module.compute.local_file.private_key: Creating...
module.compute.local_file.private_key: Creation complete after 0s [id=032facc7959e50daecf1d5f3702cb65dc0d58d17]
module.compute.aws_key_pair.this: Creating...
module.compute.aws_key_pair.this: Creation complete after 0s [id=dashboard-counting-key-pair]
module.compute.aws_instance.counting: Creating...
module.compute.aws_instance.counting: Still creating... [00m10s elapsed]
module.compute.aws_instance.counting: Creation complete after 13s [id=i-0662bc569b33f4f9b]
module.compute.aws_instance.dashboard: Creating...
module.compute.aws_instance.dashboard: Still creating... [00m10s elapsed]
module.compute.aws_instance.dashboard: Creation complete after 14s [id=i-0d35682fdb4b8f4d4]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

counting_private_ip = "172.16.2.236"
counting_sg_id = "sg-02d58dcef2c7c9d33"
dashboard_sg_id = "sg-0110b861dc2ab8207"
dashboard_url = "http://47.129.252.70:9002"
private_subnet = "subnet-0beca770312ce4417"
public_subnet = "subnet-03fa2deb4e076da0f"
ssh_command = "ssh -i /home/zinko/.ssh/dashboard-counting-key-pair.pem ubuntu@47.129.252.70"
vpc_id = "vpc-0541890c989301218"


[Mon Mar 23]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V1$ terraform state list
module.compute.aws_instance.counting
module.compute.aws_instance.dashboard
module.compute.aws_key_pair.this
module.compute.local_file.private_key
module.compute.tls_private_key.this
module.network.aws_eip.nat
module.network.aws_internet_gateway.this
module.network.aws_nat_gateway.this
module.network.aws_route.private_default
module.network.aws_route.public_default
module.network.aws_route_table.private
module.network.aws_route_table.public
module.network.aws_route_table_association.private_assoc
module.network.aws_route_table_association.public_assoc
module.network.aws_subnet.counting
module.network.aws_subnet.dashboard
module.network.aws_vpc.this
module.security.aws_security_group.counting_sg
module.security.aws_security_group.dashboard_sg
[Mon Mar 23]zinko@zinko-svr:~/pov-terraform/dashboard-counting-app-V1$ 




![alt text](https://github.com/Zinkothu/Pov-Terraform-AWS-Dashboard-Counting-App/blob/2368e9f7802833262b32b3c60a151dfca3558ef4/pov-terraform/dashboard-counting-app-V1/Assigment2.png)
