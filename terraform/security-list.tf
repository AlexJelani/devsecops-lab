variable "compartment_id" {
  description = "OCI compartment OCID"
  type        = string
}

variable "vcn_id" {
  description = "OCI VCN OCID"
  type        = string
}

resource "oci_core_security_list" "lab_public" {
  compartment_id = var.compartment_id
  display_name   = "lab-public-sg"
  vcn_id         = var.vcn_id

  # Ingress rules for all your service ports
  ingress_security_rules {
    protocol = "6"                  # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
  }
  ingress_security_rules {
    protocol = "6"                  # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 3000
      max = 3000
    }
  }
  ingress_security_rules {
    protocol = "6"                  # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 8080
      max = 8080
    }
  }
  ingress_security_rules {
    protocol = "6"                  # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 50000
      max = 50000
    }
  }
  ingress_security_rules {
    protocol = "6"                  # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 9000
      max = 9000
    }
  }
  ingress_security_rules {
    protocol = "6"                  # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 8081
      max = 8081
    }
  }
  ingress_security_rules {
    protocol = "6"                  # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 9090
      max = 9090
    }
  }
  ingress_security_rules {
    protocol = "6"                  # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 3001
      max = 3001
    }
  }
  # Allow all outbound traffic
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}