#---------------------------------------------------
# Route Table Associations
#---------------------------------------------------

#### DHCP
resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
    count                = var.enable_dhcp_options ? 1 : 0

    vpc_id               = "aws_vpc.vpc.id"
    dhcp_options_id      = "aws_vpc_dhcp_options.vpc_dhcp_options.id"

    depends_on           = [aws_vpc.vpc, aws_vpc_dhcp_options.vpc_dhcp_options]
}

### Gateway
resource "aws_route_table" "public_route_tables" {
    count                  = length(var.public_subnet_cidrs) > 0 ? 1 : 0

    vpc_id                 = "aws_vpc.vpc.id"
    propagating_vgws       = ["var.public_propagating_vgws"]

    tags = {
        Name               = "public_route_tables"
        Environment        = var.environment
        Orchestration      = var.orchestration
        Createdby          = var.createdby
    }

    depends_on             = [aws_vpc.vpc]
}
resource "aws_route" "public_internet_gateway" {
    count                  = length(var.public_subnet_cidrs) > 0 ? 1 : 0

    route_table_id         = "aws_route_table.public_route_tables.id"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "aws_internet_gateway.internet_gw.id"

    depends_on             = [aws_internet_gateway.internet_gw, aws_route_table.public_route_tables]
}

### Private network
resource "aws_route_table" "private_route_tables" {
    count                   = length(var.availability_zones)

    vpc_id                  = "aws_vpc.vpc.id"
    propagating_vgws        = ["var.private_propagating_vgws"]

    tags = {
        Name                = "private_route_tables"
        Environment         = var.environment
        Orchestration       = var.orchestration
        Createdby           = var.createdby
    }

    depends_on              = [aws_vpc.vpc]
}
resource "aws_route" "private_nat_gateway" {
    count                   = var.enable_nat_gateway ? length(var.availability_zones) : 0

    route_table_id          = element(aws_route_table.private_route_tables.*.id, count.index)
    destination_cidr_block  = "0.0.0.0/0"
    nat_gateway_id          = element(aws_nat_gateway.nat_gw.*.id, count.index)

    depends_on              = [aws_nat_gateway.nat_gw, aws_route_table.private_route_tables]
}
resource "aws_route_table_association" "private_route_table_associations" {
    count                   = length(var.private_subnet_cidrs)

    subnet_id               = element(aws_subnet.private_subnets.*.id, count.index)
    route_table_id          = element(aws_route_table.private_route_tables.*.id, count.index)

    depends_on              = [aws_route_table.private_route_tables, aws_subnet.private_subnets]
}

### Public network
resource "aws_route_table_association" "public_route_table_associations" {
    count                   = length(var.public_subnet_cidrs)

    subnet_id               = element(aws_subnet.public_subnets.*.id, count.index)
    route_table_id          = "aws_route_table.public_route_tables.id"

    depends_on              = [aws_route_table.public_route_tables, aws_subnet.public_subnets]
}

