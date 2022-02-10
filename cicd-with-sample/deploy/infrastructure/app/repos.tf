resource "oci_artifacts_container_repository" "frontend_helidon_container_repository" {
  #Required
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.repository}/frontend-react"
  is_public = true
}