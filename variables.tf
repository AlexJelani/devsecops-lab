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

variable "compartment_id" {
  description = "The OCID of the compartment where resources will be created"
  type        = string
}