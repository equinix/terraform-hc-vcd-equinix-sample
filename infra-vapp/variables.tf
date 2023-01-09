variable "vcd_org" {
    description = "Vcd Organization Name"
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

variable "vdc_name" {
  description = "Virtual Datacenter Name"
}

variable "force_customization" {
  default = false
}

variable "vm_numbers" {
  description = "VApp Desired VM quantity"
  default = 1
}
variable "template_image" {
  description = "Image Template Name from Catalog"
}