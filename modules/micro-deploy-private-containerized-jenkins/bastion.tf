
resource oci_bastion_bastion bastion {
    #Required
    name = var.bastion_name
    bastion_type = "STANDARD"
    compartment_id = var.compartment_id
    target_subnet_id = oci_core_subnet.prv_jenkins_controller_subnet.id

    defined_tags = {}
    freeform_tags = {}
}

resource oci_bastion_session bastion_session {
    #Required
    bastion_id = oci_bastion_bastion.bastion.id

    key_details {
        public_key_content = tls_private_key.tls_key_pair.public_key_openssh
    }

    target_resource_details {
        session_type = "MANAGED_SSH"
        target_resource_id = oci_core_instance.jenkins_vm.id
        target_resource_operating_system_user_name = opc
        target_resource_port = 22
        target_resource_private_ip_address = oci_core_instance.jenkins_vm.private_ip
    }

    display_name = var.session_display_name
}