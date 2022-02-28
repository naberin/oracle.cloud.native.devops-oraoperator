resource tls_private_key tls_key_pair {
  algorithm = "RSA"
}

resource tls_private_key jenkins_lb_tls_key_pair {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource tls_self_signed_cert certificate {
  key_algorithm   = tls_private_key.jenkins_lb_tls_key_pair.algorithm
  private_key_pem = tls_private_key.jenkins_lb_tls_key_pair.private_key_pem

  validity_period_hours = 26280
  early_renewal_hours   = 8760
  is_ca_certificate     = true
  allowed_uses          = ["cert_signing"]

  subject {
    common_name  = "*.example.com"
    organization = "Example, Inc"
  }
}