#---------------------------------------------------
# Add AWS internet gateway
#---------------------------------------------------
resource "aws_internet_gateway" "internet_gw" {
    count                  = length(var.public_subnet_cidrs) > 0 ? 1 : 0

    vpc_id                 = "aws_vpc.vpc.id"

    tags = {
        Name               = "internet-gateway to ${var.name}-vpc-${var.environment}"
        Environment        = var.environment
        Orchestration      = var.orchestration
        Createdby          = var.createdby
    }

    depends_on             = [aws_vpc.vpc]
}

#---------------------------------------------------
# CREATE NAT
#---------------------------------------------------
resource "aws_nat_gateway" "nat_gw" {
    count                  = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.availability_zones)) : 0

    allocation_id          = element(aws_eip.nat_eip.*.id, (var.single_nat_gateway ? 0 : count.index))
    subnet_id              = element(aws_subnet.public_subnets.*.id, (var.single_nat_gateway ? 0 : count.index))

    depends_on             = [aws_internet_gateway.internet_gw, aws_subnet.public_subnets]
}

#---------------------------------------------------
# CREATE VPN
#---------------------------------------------------
resource "aws_vpn_gateway" "vpn_gw" {
    count                  = var.enable_vpn_gateway ? 1 : 0

    vpc_id                 = "aws_vpc.vpc.id"

    tags = {
        Name               = "vpn_gateway"
        Environment        = var.environment
        Orchestration      = var.orchestration
        Createdby          = var.createdby
    }

    depends_on             = [aws_vpc.vpc]
}