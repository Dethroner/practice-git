#---------------------------------------------------
# CREATE DHCP
#---------------------------------------------------
resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
    count                = var.enable_dhcp_options ? 1 : 0

    domain_name          = var.dhcp_options_domain_name
    domain_name_servers  = var.dhcp_options_domain_name_servers
    ntp_servers          = var.dhcp_options_ntp_servers
    netbios_name_servers = var.dhcp_options_netbios_name_servers
    netbios_node_type    = var.dhcp_options_netbios_node_type

    tags = {
        Name             = "dhcp"
        Environment      = var.environment
        Orchestration    = var.orchestration
        Createdby        = var.createdby
    }
}
