# VCN
variable "vcn_cidr_block" {}
variable "vcn_display_name" {}
variable "vcn_dns_label" {}

# internet gateway
variable "internet_gateway_display_name"  {}

# route table
variable "route_table_display_name" {}

# security list web
variable "sl_egress_destination_web" {}
variable "sl_egress_protocol_web" {}
variable "sl_ingress_source_web" {}
variable "sl_ingress_protocol_web" {}
variable "sl_ingress_tcp_dest_port_max_web" {}
variable "sl_ingress_tcp_dest_port_min_web" {}
variable "sl_display_name_web" {}

# security list db
variable "sl_egress_destination_db" {}
variable "sl_egress_protocol_db" {}
variable "sl_ingress_source_db" {}
variable "sl_ingress_protocol_db" {}
#variable "sl_ingress_tcp_dest_port_max_db" {}
#variable "sl_ingress_tcp_dest_port_min_db" {}
variable "sl_ingress_tcp_dest_port_max_db1" {}
variable "sl_ingress_tcp_dest_port_min_db1" {}
variable "sl_ingress_tcp_dest_port_max_db2" {}
variable "sl_ingress_tcp_dest_port_min_db2" {}

variable "sl_display_name_db" {}

# subnet web
variable "web_subnet_cidr_block" {}
variable "web_subnet_display_name" {}
variable "web_subnet_dns_label" {}
variable "web_subnet_prohibit_public_ip_on_vnic" {}

# subnet db
variable "db_subnet_cidr_block" {}
variable "db_subnet_display_name" {}
variable "db_subnet_dns_label" {}
variable "db_subnet_prohibit_public_ip_on_vnic" {}

