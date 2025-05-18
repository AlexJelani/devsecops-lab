output "instance_public_ip" {
  description = "The public IP of the DevSecOps lab instance"
  value       = oci_core_instance.lab_instance.public_ip
}

output "instance_ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh ubuntu@${oci_core_instance.lab_instance.public_ip}"
}