# VCN
resource "oci_core_vcn" "test_vcn" {
    cidr_block = "${var.vcn_cidr_block}"          # 必須
    compartment_id = "${var.compartment_ocid}"      # 必須
    display_name = "${var.vcn_display_name}"
    dns_label = "${var.vcn_dns_label}"
    defined_tags = "${map("${var.defined_tag}",  "${var.defined_tag_value}")}"
}

# Internet Gateway
resource "oci_core_internet_gateway" "test_internet_gateway" {
    compartment_id = "${var.compartment_ocid}"      # 必須
    vcn_id = "${oci_core_vcn.test_vcn.id}"        # 必須(上で作成したVCNのidを利用)
    display_name = "${var.internet_gateway_display_name}"
    enabled = true
    defined_tags = "${map("${var.defined_tag}",  "${var.defined_tag_value}")}"
}

# route table
resource "oci_core_route_table" "test_route_table" {
    compartment_id = "${var.compartment_ocid}"      # 必須
    route_rules {
        network_entity_id = "${oci_core_internet_gateway.test_internet_gateway.id}" # 必須(上で作成したIGのidを利用)
        destination = "0.0.0.0/0"
    }
    vcn_id = "${oci_core_vcn.test_vcn.id}"
    display_name = "${var.route_table_display_name}"
    defined_tags = "${map("${var.defined_tag}",  "${var.defined_tag_value}")}"
}


# Security List(Web-Subnet用)
resource "oci_core_security_list" "test_security_list_web" {
    compartment_id = "${var.compartment_ocid}"     # 必須
    egress_security_rules {
        destination = "${var.sl_egress_destination_web}" # 必須
        protocol = "${var.sl_egress_protocol_web}"       # 必須
        stateless = false
        }
    ingress_security_rules {
        source = "${var.sl_ingress_source_web}"          # 必須
        protocol = "${var.sl_ingress_protocol_web}"      # 必須
        stateless = false
        tcp_options {
            max = "${var.sl_ingress_tcp_dest_port_max_web}"
            min = "${var.sl_ingress_tcp_dest_port_min_web}"
        }
    }
    vcn_id = "${oci_core_vcn.test_vcn.id}"
    display_name = "${var.sl_display_name_web}"
    defined_tags = "${map("${var.defined_tag}",  "${var.defined_tag_value}")}"
}



# Security List(DB-Subnet用)
resource "oci_core_security_list" "test_security_list_db" {
    compartment_id = "${var.compartment_ocid}"     # 必須
    egress_security_rules {
        destination = "${var.sl_egress_destination_db}" # 必須
        protocol = "${var.sl_egress_protocol_db}"       # 必須
        stateless = false
        }
    ingress_security_rules {
        source = "${var.sl_ingress_source_db}"          # 必須
        protocol = "${var.sl_ingress_protocol_db}"      # 必須
        stateless = false
        tcp_options {
            max = "${var.sl_ingress_tcp_dest_port_max_db1}"
            min = "${var.sl_ingress_tcp_dest_port_min_db1}"
        }
    }
    ingress_security_rules {
        source = "${var.sl_ingress_source_db}"          # 必須
        protocol = "${var.sl_ingress_protocol_db}"      # 必須
        stateless = false
        tcp_options {
            max = "${var.sl_ingress_tcp_dest_port_max_db2}"
            min = "${var.sl_ingress_tcp_dest_port_min_db2}"
        }
    }
    vcn_id = "${oci_core_vcn.test_vcn.id}"
    display_name = "${var.sl_display_name_db}"
    defined_tags = "${map("${var.defined_tag}",  "${var.defined_tag_value}")}"
}


# Subent(Web)
resource "oci_core_subnet" "test_web_subnet" {
    availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}" # 必須
    cidr_block = "${var.web_subnet_cidr_block}"                   # 必須
    compartment_id = "${var.compartment_ocid}"                    # 必須
    security_list_ids = ["${oci_core_security_list.test_security_list_web.id}"]       # 必須
    vcn_id = "${oci_core_vcn.test_vcn.id}"                        # 必須

    display_name = "${var.web_subnet_display_name}"
    dns_label = "${var.web_subnet_dns_label}"
    prohibit_public_ip_on_vnic = "${var.web_subnet_prohibit_public_ip_on_vnic}"
    route_table_id = "${oci_core_route_table.test_route_table.id}"
    defined_tags = "${map("${var.defined_tag}",  "${var.defined_tag_value}")}"
}


# Subent(db)
resource "oci_core_subnet" "test_db_subnet" {
    availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}" # 必須
    cidr_block = "${var.db_subnet_cidr_block}"                    # 必須
    compartment_id = "${var.compartment_ocid}"                    # 必須
    security_list_ids = ["${oci_core_security_list.test_security_list_db.id}"]       # 必須
    vcn_id = "${oci_core_vcn.test_vcn.id}"                        # 必須

    display_name = "${var.db_subnet_display_name}"
    dns_label = "${var.db_subnet_dns_label}"
    prohibit_public_ip_on_vnic = "${var.db_subnet_prohibit_public_ip_on_vnic}"
    defined_tags = "${map("${var.defined_tag}",  "${var.defined_tag_value}")}"
}
