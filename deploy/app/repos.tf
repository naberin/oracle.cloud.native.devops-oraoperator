//------- Create repos End  ------------------------------------------

resource "oci_artifacts_container_repository" "frontend_helidon_container_repository" {
  #Required
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.repository}/frontend-helidon"
  is_public = true
}
resource "oci_artifacts_container_repository" "order-helidon_container_repository" {
  #Required
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.repository}/order-helidon"
  is_public = true
}
resource "oci_artifacts_container_repository" "supplier-helidon-se_container_repository" {
  #Required
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.repository}/supplier-helidon-se"
  is_public = true
}
resource "oci_artifacts_container_repository" "inventory-helidon_container_repository" {
  #Required
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.repository}/inventory-helidon"
  is_public = true
}
