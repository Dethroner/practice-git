#---------------------------------------------------
# CREATE EIP
#---------------------------------------------------
resource "aws_eip" "nat_eip" {
    count       = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.availability_zones)) : 0

    vpc         = true

    depends_on  = [aws_internet_gateway.internet_gw]
}