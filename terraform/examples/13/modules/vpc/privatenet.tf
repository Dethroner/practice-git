#---------------------------------------------------
# Add AWS subnets (private)
#---------------------------------------------------
resource "aws_subnet" "private_subnets" {
    #count                   = length(var.private_subnet_cidrs)
    count                   = length(var.availability_zones)
    cidr_block              = element(var.private_subnet_cidrs, count.index)
    vpc_id                  = "aws_vpc.vpc.id"
    map_public_ip_on_launch = "false"
    
    availability_zone       = element(var.availability_zones, count.index)
    #availability_zone       = element(var.availability_zones, 0)
    #availability_zone		 = element(split(",", var.availability_zones), count.index)

    tags = {
        Name                = "private_subnet-${element(var.availability_zones, count.index)}"
        Environment         = var.environment
        Orchestration       = var.orchestration
        Createdby           = var.createdby
    }

    depends_on              = [aws_vpc.vpc]
}
