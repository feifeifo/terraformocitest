variable "db_system_database_edition" {
  default = "ENTERPRISE_EDITION"
}
variable "db_system_db_home_database_admin_password" {}
variable "db_system_db_home_database_db_name" {}
variable "db_system_db_home_db_version" {}
variable "db_system_db_home_display_name" {}
variable "db_system_display_name" {}
variable "db_system_hostname" {}
variable "db_system_shape" {
  default = "VM.Standard2.1"
}
variable "db_system_data_storage_size_in_gb" {
  default = "256"
}
variable "db_system_ssh_public_keys" {}
variable "db_system_cpu_core_count" {
  default = "2"
}
variable "db_system_node_count" {
  default = "1"
}
