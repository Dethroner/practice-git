#---------------------------------------------------
# Create VPC
#---------------------------------------------------
resource "aws_vpc" "vpc" {
    cidr_block                          = cidrsubnet(var.vpc_cidr, 0, 0)
    #cidr_block                          = var.vpc_cidr
    instance_tenancy                    = var.instance_tenancy
    enable_dns_support                  = var.enable_dns_support
    enable_dns_hostnames                = var.enable_dns_hostnames
    assign_generated_ipv6_cidr_block    = var.assign_generated_ipv6_cidr_block
    enable_classiclink                  = var.enable_classiclink

    tags = {
        Name                            = "${var.name}-sg-${var.environment}"
        Environment                     = var.environment
        Orchestration                   = var.orchestration
        Createdby                       = var.createdby
    }
}