//Copyright (c) 2021 Oracle and/or its affiliates.
//Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
variable "ociTenancyOcid" {}
variable "ociUserOcid" {}
variable "ociCompartmentOcid" {}
variable "ociRegionIdentifier" {}
variable "runName" {}
variable "orderDbName" {}
variable "inventoryDbName" {}

variable "autonomous_database_db_workload" { default = "OLTP" }
variable "autonomous_database_defined_tags_value" { default = "value" }
variable "autonomous_database_license_model" { default = "BRING_YOUR_OWN_LICENSE" }
variable "autonomous_database_is_dedicated" { default = false }