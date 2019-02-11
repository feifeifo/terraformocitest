# リソースを作成する際は必ずコンパートメントを指定する必要があるので、宣言しておきます。
variable "compartment_ocid" {
  default = "xxxxxxxx"
}

# 多くのリソースでADを指定することがあるので、テナンシーのAD名をリストで取得しておきます
 data "oci_identity_availability_domains" "ADs" {
   compartment_id = "${var.tenancy_ocid}"
 }

# タグでリソースを管理するために、宣言をしてきます
data "oci_identity_tag_namespaces" "test_tag_namespaces" {
    compartment_id = "${var.compartment_ocid}"
}

variable "defined_tag" {
  default = "xxxxxxxx.xxxxxxxx"
}

variable "defined_tag_value" {
  default = "xxxxxxxx"
}
