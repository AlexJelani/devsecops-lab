resource "oci_identity_compartment" "devsecops_lab" {
  name          = "devsecops-lab"
  description   = "Compartment for DevSecOps home lab setup"
  enable_delete = true
}