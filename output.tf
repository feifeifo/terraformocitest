output "InstancePrivateIP" {
  value = ["${oci_core_instance.test_instance.*.private_ip}"]
}

output "InstancePublicIP" {
  value = ["${oci_core_instance.test_instance.*.public_ip}"]
}