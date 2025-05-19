resource "oci_core_virtual_network" "vcn" {
  compartment_id = oci_identity_compartment.devsecops_lab.id
  cidr_block     = "10.0.0.0/16"
  display_name   = "devsecops-vcn"
  dns_label      = "devsecops" # ✱ enable DNS on the VCN ✱
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = oci_identity_compartment.devsecops_lab.id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "devsecops-igw"
  enabled        = true
}

resource "oci_core_route_table" "route_table" {
  compartment_id = oci_identity_compartment.devsecops_lab.id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "devsecops-route"

  route_rules {
    destination       = "0.0.0.0/0" # ← use `destination` now
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_security_list" "ssh" {
  compartment_id = oci_identity_compartment.devsecops_lab.id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "devsecops-ssh-sl"

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "subnet" {
  compartment_id             = oci_identity_compartment.devsecops_lab.id
  vcn_id                     = oci_core_virtual_network.vcn.id
  cidr_block                 = "10.0.1.0/24"
  display_name               = "devsecops-subnet"
  route_table_id             = oci_core_route_table.route_table.id
  prohibit_public_ip_on_vnic = false
  dns_label                  = "devsecops" # now valid because VCN has dns_label
  security_list_ids          = [oci_core_security_list.ssh.id]
}