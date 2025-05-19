resource "oci_identity_compartment" "devsecops_lab" {
  name          = "devsecops-lab"
  description   = "Compartment for DevSecOps home lab setup"
  compartment_id = var.root_compartment_id # Specify the parent compartment
  enable_delete = true
}