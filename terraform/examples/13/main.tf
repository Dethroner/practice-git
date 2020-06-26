
terraform {
  # версия terraform
  required_version  = "<= 0.12.25"
}

module "vpc" {
    source                              = "./modules/vpc"
    name                                = var.name
    environment                         = var.environment
    instance_tenancy                    = var.instance_tenancy
    enable_dns_support                  = var.enable_dns_support
    enable_dns_hostnames                = var.enable_dns_hostnames
    assign_generated_ipv6_cidr_block    = var.assign_generated_ipv6_cidr_block
    enable_classiclink                  = var.enable_classiclink
    vpc_cidr                            = var.vpc_cidr
    private_subnet_cidrs                = var.private_subnet_cidrs
    public_subnet_cidrs                 = var.public_subnet_cidrs
    availability_zones                  = var.availability_zones
    allowed_ports                       = var.allowed_ports
    enable_internet_gateway             = var.enable_internet_gateway
    enable_nat_gateway                  = var.enable_nat_gateway
    single_nat_gateway                  = var.single_nat_gateway
    enable_vpn_gateway                  = var.enable_vpn_gateway
    enable_dhcp_options                 = var.enable_dhcp_options
    enable_eip                          = var.enable_eip
}

#resource "aws_vpc" "eu-central-1" {
#    provider                            = var.region
#    enable_dns_support                  = var.enable_dns_support
#    enable_dns_hostnames                = var.enable_dns_hostnames
#    assign_generated_ipv6_cidr_block    = var.assign_generated_ipv6_cidr_block
#    cidr_block                          = var.vpc_cidr
#}