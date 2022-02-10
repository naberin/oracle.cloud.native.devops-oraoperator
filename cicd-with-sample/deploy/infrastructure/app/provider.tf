terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
      version = "4.42.0"
    }
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.current_user_ocid
  region = var.region
}