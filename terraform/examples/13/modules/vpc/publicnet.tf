#---------------------------------------------------
# Add AWS subnets (public)
#---------------------------------------------------
resource "aws_subnet" "public_subnets" {
    #count                   = length(var.public_subnet_cidrs)
    count                   = length(var.availability_zones)

    cidr_block              = element(var.public_subnet_cidrs, count.index)
    vpc_id                  = "aws_vpc.vpc.id"
    map_public_ip_on_launch = var.map_public_ip_on_launch
    availability_zone       = element(var.availability_zones, count.index)
    #availability_zone       = element(var.availability_zones, 0)

    tags = {
        Name                = "public_subnet-${element(var.availability_zones, count.index)}"
        Environment         = var.environment
        Orchestration       = var.orchestration
        Createdby           = var.createdby
    }

    depends_on              = [aws_vpc.vpc]
}
