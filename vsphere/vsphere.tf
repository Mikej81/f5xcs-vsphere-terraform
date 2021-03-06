provider "vsphere" {
  user           = var.user
  password       = var.password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "outside" {
  name          = var.outside_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "inside" {
  name          = var.inside_network
  datacenter_id = data.vsphere_datacenter.dc.id
}
