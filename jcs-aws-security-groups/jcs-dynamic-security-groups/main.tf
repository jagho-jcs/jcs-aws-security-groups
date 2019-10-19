# provider "aws" {
#   region                      = "eu-west-2"
#   shared_credentials_file     = "/../../.aws/credentials"
#   profile                     = "dev-jcs"
# }

#############################################################
# Data sources to get VPC and default security group details
#############################################################

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.this.id
}
data "aws_vpc" "this" {
  filter {
    name = "tag:Name"
    values = ["jcs-demo"]
  }
}

###########################
# Security groups examples
###########################

#######
# HTTP
#######
module "http_sg" {
  source = "../../modules/http-80"

  name                    = "web-instance-sg"
  use_name_prefix         = false

  description             = "Security groups required for JCS Base Infrastructure"
  vpc_id                  = data.aws_vpc.this.id

  ingress_cidr_blocks     = ["94.197.121.158/32"]
  ingress_rules           = ["https-443-tcp", "http-8080-tcp", "ssh-tcp"]

  tags = {

          Provisionedby   = "Terraform"
          Project         = "aws-devops-terraform"
  }
}

module "hsbc_sg" {
  source = "../../modules/http-80"

  name                    = "alb_hsbc_sg"
  use_name_prefix         = false

  description             = "Security group with HTTP port open for everyone, and HTTPS open just for the default security group"
  vpc_id                  = data.aws_vpc.this.id

  ingress_cidr_blocks     = [ "0.0.0.0/0" ]
  ingress_rules           = [ "http-8080-tcp" ]

  tags = {

          Provisionedby   = "Terraform"
          Project         = "aws-devops-terraform"
  }
}

module "bastion_sg" {
  source = "../../modules/http-80"

  name                    = "bastion_sg"
  use_name_prefix         = false

  description             = "Bastion Jump Box"
  vpc_id                  = data.aws_vpc.this.id

  ingress_cidr_blocks     = [ "0.0.0.0/0" ]
  ingress_rules           = [ "ssh-tcp" ]

  tags = {

          Provisionedby   = "Terraform"
          Project         = "aws-devops-terraform"
  }
}

module "private_sg" {
  source = "../../modules/http-80"

  name                    = "private_sg"
  use_name_prefix         = false

  description             = "Access to instances through Bastion"
  vpc_id                  = data.aws_vpc.this.id

  ingress_cidr_blocks     = [ "0.0.0.0/0" ]
  ingress_rules           = [ "rdp-tcp", "rdp-udp" ]
 
  tags = {

          Provisionedby   = "Terraform"
          Project         = "aws-devops-terraform"
  }
}
