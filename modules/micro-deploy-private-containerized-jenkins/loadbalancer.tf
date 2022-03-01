
resource oci_load_balancer_load_balancer load_balancer {
    #Required
    compartment_id = var.compartment_id
    display_name = "jenkins-load-balancer"
    shape = var.load_balancer_shape
    subnet_ids = [oci_core_subnet.pub_jenkins_lb_subnet.id]

    reserved_ips {
        id = oci_core_public_ip.jenkins_public_ip.id
    }
    shape_details {
        maximum_bandwidth_in_mbps = var.load_balancer_shape_details_maximum_bandwidth_in_mbps
        minimum_bandwidth_in_mbps = var.load_balancer_shape_details_minimum_bandwidth_in_mbps
    }

    defined_tags = {}
    freeform_tags = {}
}

resource oci_load_balancer_backend_set backend_set {
    #Required
    health_checker {
        #Required
        protocol = "TCP"
        port = var.backend_set_health_checker_port
    }

    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    name = var.backend_set_name
    policy = "ROUND_ROBIN"

}

resource oci_load_balancer_backend backend {
    backendset_name = oci_load_balancer_backend_set.backend_set.name
    ip_address = oci_core_instance.jenkins_vm.private_ip
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    port = 80
}


#resource "oci_load_balancer_certificate" jenkins_lb_cert {
#  load_balancer_id   = oci_load_balancer_load_balancer.load_balancer.id
#  ca_certificate     = var.listener_ca_certificate == "" ? tls_self_signed_cert.certificate.cert_pem : var.listener_ca_certificate
#  certificate_name   = "jenkinscertificate"
#  private_key        = var.listener_private_key == "" ? tls_private_key.jenkins_lb_tls_key_pair.private_key_pem : var.listener_private_key
#  public_certificate = var.listener_public_certificate == "" ? tls_self_signed_cert.certificate.cert_pem : var.listener_public_certificate
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}

resource "oci_load_balancer_listener" jenkins_lb_listener_with_ssl {
  load_balancer_id         = oci_load_balancer_load_balancer.load_balancer.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.backend_set.name
  port                     = 80
  protocol                 = "HTTP"

#  ssl_configuration {
#    certificate_name        = oci_load_balancer_certificate.jenkins_lb_cert.certificate_name
#    verify_peer_certificate = false
#  }
}