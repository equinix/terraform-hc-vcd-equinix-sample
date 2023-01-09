#Here we can define our variables for the main file, giving some descriptions and default values.
variable "vcd_user" {
  description = "vCloud Director Username"
  sensitive   = true
}
variable "vcd_pass" {
  description = "vCloud Director User Password"
  sensitive   = true
}
variable "vcd_url" {
  description = "vCloud URL"
}
variable "vcd_max_retry_timeout" {
  default = 60
}
variable "vcd_allow_unverified_ssl" {
  default = true
}
variable "vcd_org" {
  description = "vCloud Director organization"
}
variable "vdc_name" {
  description = "Virtual Datacenter Name"
}
variable "vapp_name" {
  description = "vApp Name"
}
variable "vapp_network" {
  description = "VApp Network - Org Type"
}
variable "vapp_catalog" {
  description = "VApp Catalog Name to search Images"
}
variable "vm_numbers" {
  description = "VApp Desired VM quantity"
}
variable "template_image" {
  description = "Image Template Name from Catalog"
}