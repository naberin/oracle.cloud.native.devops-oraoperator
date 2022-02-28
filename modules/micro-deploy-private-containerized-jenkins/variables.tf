variable region {
  description = "Tenancy region to provision resources in"
}
variable compartment_id {
  description = "OCID of compartment to provision resources in"
}
variable availability_domain_name {
  description = "Availability Domain to provision the compute instance in"
  default = null
}
variable vcn_name {
  default = "jenkins-vcn"
}
variable vcn_cidr {
  description = "VCN CIDR IP Block"
  default     = "10.0.0.0/16"
}
variable vcn_dns {
  description = "VCN subnet DNS record"
  default = "jnknsvcn"
}
