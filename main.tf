#Equinix Hybrid Cloud Infrasctructure Sample Code
#Created by: Carlos Azevedo - Brazil Managed Services Architecture
#Version   : 1.0
#This code itends to demonstrate how to create a basic infrastructure inside Equinix Hybrid Cloud environment using IaC and Terraform Codes
#Hybrid Cloud uses VMWare VCloud Director Technologies

#Provider Initialization
#Here you tell to the code which kind of provider you want to connect
#If you were using modules, for vCloud Director, the provider initialization must be done in each module

terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = ">=3.4.0"
    }
  }
}

#Provider Credentials
#In this code block you define the correct credentials to be used
#as well the organization, vcd and appliance URL
#The security best practices tell us that credentials MUST be secured and never hardcoded
#In this case, it's only a sample test, so, in production deployments, ALWAYS USE ENCRYPTED VARIABLES AND VAULTS FOR CREDENTIALS

provider "vcd" {
  user                 = var.vcd_user
  password             = var.vcd_pass
  org                  = var.vcd_org
  vdc                  = var.vdc_name
  url                  = var.vcd_url
  allow_unverified_ssl = var.vcd_allow_unverified_ssl
  max_retry_timeout    = var.vcd_max_retry_timeout
}

#Calling the vApp module to create the infrastructure
module "vapp" {
  source         = "./infra-vapp"
  vcd_org        = var.vcd_org
  vapp_name      = var.vapp_name
  vapp_network   = var.vapp_network
  vapp_catalog   = var.vapp_catalog
  vdc_name       = var.vdc_name
  vm_numbers     = var.vm_numbers
  template_image = var.template_image
}