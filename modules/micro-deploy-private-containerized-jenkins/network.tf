resource oci_core_virtual_network jenkins_vcn {
  compartment_id = var.compartment_id
  cidr_block = var.vcn_cidr
  display_name = var.vcn_name
  dns_label = var.vcn_dns
}

resource oci_core_internet_gateway igw {
  compartment_id = var.compartment_id
  vcn_id = oci_core_virtual_network.jenkins_vcn.id
  display_name = "${var.vcn_name}-igw"
}
