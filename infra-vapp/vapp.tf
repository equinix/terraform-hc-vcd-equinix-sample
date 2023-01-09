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


///////////////////////////////////////////////////
//Creating Hybrid Cloud VApp Infrastructure////////
///////////////////////////////////////////////////

#Creating a new VApp on Hybrid Cloud
resource "vcd_vapp" "my_vapp" {
  name = var.vapp_name
  power_on = true
}

#Provides capability to attach an existing Org VDC Network to a vApp and toggle network features.
resource "vcd_vapp_org_network" "networks" {
  vapp_name = vcd_vapp.my_vapp.name
  org_network_name = var.vapp_network

  depends_on = [vcd_vapp.my_vapp]
}


///////////////////////////////////////////////////
//Catalog Steps////////////////////////////////////
///////////////////////////////////////////////////

#Gathering Hybrid Cloud VCloud Director Image Catalog
data "vcd_catalog" "hc-catalog" {
  org = var.vcd_org
  name = var.vapp_catalog
}

#Gathering Hybrid Cloud VCloud Director Image Template from discovered Catalog
data "vcd_catalog_vapp_template" "vapp-catalog-template" {
  org = var.vcd_org
  catalog_id = data.vcd_catalog.hc-catalog.id
  name = var.template_image
}


///////////////////////////////////////////////////
//Creating Virtual Machines inside the vApp////////
///////////////////////////////////////////////////


#Creating a new VApp VM using selected Image Template from Catalog
resource "vcd_vapp_vm" "my_new_vapp" {
  count = var.vm_numbers
  vapp_name = vcd_vapp.my_vapp.name
  computer_name = format("%s-%g", var.vapp_name, count.index)
  name = format("%s-%g", var.vapp_name, count.index) //The VM display name will be composed by the vApp Name plus an index counter.

  vapp_template_id = data.vcd_catalog_vapp_template.vapp-catalog-template.id //Calling the Template ID

  
//Setting VM shape
  memory = 2048
  cpus = 2
  cpu_cores = 1
  power_on = true
  vdc = var.vdc_name


//Setting VM Network link
network {
  type = "org"
  name = vcd_vapp_org_network.networks.org_network_name
  ip_allocation_mode = "POOL"
  is_primary = true
}

//Post Setup Customization
  customization {
      force                      = var.force_customization
      enabled                    = true
      allow_local_admin_password = true
      auto_generate_password     = true
  }
}