#---------------------------------------------------
# Create security group
#---------------------------------------------------
resource "aws_security_group" "sg" {
    name                      = "var.name-sg-var.environment"
    description               = "Security Group var.name-sg-var.environment"
    vpc_id                    = "aws_vpc.vpc.id"

    tags = {
        Name                  = "${var.name}-sg-${var.environment}"
        Environment           = var.environment
        Orchestration         = var.orchestration
        Createdby             = var.createdby
    }
    lifecycle {
        create_before_destroy = true
    }
    # allow traffic for TCP 22 to host
    ingress {
        from_port             = 22
        to_port               = 22
        protocol              = "tcp"
        cidr_blocks           = ["0.0.0.0/0"]
    }
    # allow traffic for TCP 22 from host
    egress {
        from_port             = 22
        to_port               = 22
        protocol              = "tcp"
        cidr_blocks           = ["0.0.0.0/0"]
    }

    depends_on  = [aws_vpc.vpc]
}
#---------------------------------------------------
# Add security group rules
#---------------------------------------------------
resource "aws_security_group_rule" "ingress_ports" {
    count                     = length(var.allowed_ports)

    type                      = "ingress"
    security_group_id         = "aws_security_group.sg.id"
    from_port                 = element(var.allowed_ports, count.index)
    to_port                   = element(var.allowed_ports, count.index)
    protocol                  = "tcp"
    cidr_blocks               = ["0.0.0.0/0"]

    depends_on                = [aws_security_group.sg]
}
resource "aws_security_group_rule" "egress_ports" {
    count                     = var.enable_all_egress_ports ? 0 : length(var.allowed_ports)

    type                      = "egress"
    security_group_id         = "aws_security_group.sg.id"
    from_port                 = element(var.allowed_ports, count.index)
    to_port                   = element(var.allowed_ports, count.index)
    protocol                  = "tcp"
    cidr_blocks               = ["0.0.0.0/0"]

    depends_on                = [aws_security_group.sg]
}
resource "aws_security_group_rule" "icmp-self" {
    security_group_id         = "aws_security_group.sg.id"
    type                      = "ingress"
    protocol                  = "icmp"
    from_port                 = -1
    to_port                   = -1
    self                      = true

    depends_on                = [aws_security_group.sg]
}
resource "aws_security_group_rule" "default_egress" {
    count                     = var.enable_all_egress_ports ? 1 : 0

    type                      = "egress"
    security_group_id         = "aws_security_group.sg.id"
    from_port                 = 0
    to_port                   = 0
    protocol                  = "-1"
    cidr_blocks               = ["0.0.0.0/0"]

    depends_on                = [aws_security_group.sg]
}