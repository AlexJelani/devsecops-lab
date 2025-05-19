variable "tenancy_ocid" {
  description = "The OCID of the OCI tenancy"
  type        = string
}

variable "user_ocid" {
  description = "The OCID of the OCI user"
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint of the OCI API key"
  type        = string
}

variable "private_key_path" {
  description = "Path to the OCI API key private key file"
  type        = string
}

variable "region" {
  description = "OCI region identifier (e.g. us-ashburn-1)"
  type        = string
}

variable "root_compartment_id" {
  description = "OCID of the parent compartment in which devsecops-lab lives"
  type        = string
}

variable "vcn_id" {
  description = "OCI VCN OCID"
  type        = string
}
variable "compartment_id" {

  description = "OCID of the compartment in which devsecops-lab lives"
  type        = string
}
