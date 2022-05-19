provider "vsphere" {
  user           = var.user
  password       = var.password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
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

data "vsphere_host" "host" {
  name          = var.vsphere_host
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.nodenames["nodeone"]
  datacenter_id    = data.vsphere_datacenter.dc.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id

  num_cpus = var.cpus
  memory   = var.memory
  guest_id = var.guest_type

  network_interface {
    network_id   = data.vsphere_network.outside.id
    adapter_type = "vmxnet3"
  }
  network_interface {
    network_id   = data.vsphere_network.inside.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 120
    eagerly_scrub    = false
    thin_provisioned = false
  }

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = var.xcsovapath

    disk_provisioning = "thick"

    ovf_network_map = {
      "OUTSIDE" = data.vsphere_network.outside.id
      "REGULAR" = data.vsphere_network.inside.id
    }
  }

  vapp {
    properties = {
      "guestinfo.ves.certifiedhardware"           = var.certifiedhardware,
      "guestinfo.interface.0.ip.0.address"        = var.publicinterfaceaddress["nodeone"],
      "guestinfo.interface.0.name"                = "eth0",
      "guestinfo.interface.0.route.0.destination" = var.publicdefaultroute,
      "guestinfo.interface.0.dhcp"                = "no",
      "guestinfo.interface.0.role"                = "public",
      "guestinfo.interface.0.route.0.gateway"     = var.publicdefaultgateway,
      "guestinfo.dns.server.0"                    = var.dnsservers["primary"],
      "guestinfo.dns.server.1"                    = var.dnsservers["secondary"],
      "guestinfo.ves.regurl"                      = "ves.volterra.io",
      "guestinfo.hostname"                        = var.nodenames["nodeone"],
      "guestinfo.ves.clustername"                 = var.clustername,
      "guestinfo.ves.latitude"                    = var.sitelatitude,
      "guestinfo.ves.longitude"                   = var.sitelongitude,
      "guestinfo.ves.token"                       = var.sitetoken
    }
  }

}

resource "vsphere_virtual_machine" "vm2" {
  name             = var.nodenames["nodetwo"]
  datacenter_id    = data.vsphere_datacenter.dc.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id

  num_cpus = var.cpus
  memory   = var.memory
  guest_id = var.guest_type

  network_interface {
    network_id   = data.vsphere_network.outside.id
    adapter_type = "vmxnet3"
  }
  network_interface {
    network_id   = data.vsphere_network.inside.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 120
    eagerly_scrub    = false
    thin_provisioned = false
  }

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = var.xcsovapath

    disk_provisioning = "thick"

    ovf_network_map = {
      "OUTSIDE" = data.vsphere_network.outside.id
      "REGULAR" = data.vsphere_network.inside.id
    }
  }

  vapp {
    properties = {
      "guestinfo.ves.certifiedhardware"           = var.certifiedhardware,
      "guestinfo.interface.0.ip.0.address"        = var.publicinterfaceaddress["nodetwo"],
      "guestinfo.interface.0.name"                = "eth0",
      "guestinfo.interface.0.route.0.destination" = var.publicdefaultroute,
      "guestinfo.interface.0.dhcp"                = "no",
      "guestinfo.interface.0.role"                = "public",
      "guestinfo.interface.0.route.0.gateway"     = var.publicdefaultgateway,
      "guestinfo.dns.server.0"                    = var.dnsservers["primary"],
      "guestinfo.dns.server.1"                    = var.dnsservers["secondary"],
      "guestinfo.ves.regurl"                      = "ves.volterra.io",
      "guestinfo.hostname"                        = var.nodenames["nodetwo"],
      "guestinfo.ves.clustername"                 = var.clustername,
      "guestinfo.ves.latitude"                    = var.sitelatitude,
      "guestinfo.ves.longitude"                   = var.sitelongitude,
      "guestinfo.ves.token"                       = var.sitetoken
    }
  }

}

resource "vsphere_virtual_machine" "vm3" {
  name             = var.nodenames["nodethree"]
  datacenter_id    = data.vsphere_datacenter.dc.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id

  num_cpus = var.cpus
  memory   = var.memory
  guest_id = var.guest_type

  network_interface {
    network_id   = data.vsphere_network.outside.id
    adapter_type = "vmxnet3"
  }
  network_interface {
    network_id   = data.vsphere_network.inside.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 120
    eagerly_scrub    = false
    thin_provisioned = false
  }

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = var.xcsovapath

    disk_provisioning = "thick"

    ovf_network_map = {
      "OUTSIDE" = data.vsphere_network.outside.id
      "REGULAR" = data.vsphere_network.inside.id
    }
  }

  vapp {
    properties = {
      "guestinfo.ves.certifiedhardware"           = var.certifiedhardware,
      "guestinfo.interface.0.ip.0.address"        = var.publicinterfaceaddress["nodethree"],
      "guestinfo.interface.0.name"                = "eth0",
      "guestinfo.interface.0.route.0.destination" = var.publicdefaultroute,
      "guestinfo.interface.0.dhcp"                = "no",
      "guestinfo.interface.0.role"                = "public",
      "guestinfo.interface.0.route.0.gateway"     = var.publicdefaultgateway,
      "guestinfo.dns.server.0"                    = var.dnsservers["primary"],
      "guestinfo.dns.server.1"                    = var.dnsservers["secondary"],
      "guestinfo.ves.regurl"                      = "ves.volterra.io",
      "guestinfo.hostname"                        = var.nodenames["nodethree"],
      "guestinfo.ves.clustername"                 = var.clustername,
      "guestinfo.ves.latitude"                    = var.sitelatitude,
      "guestinfo.ves.longitude"                   = var.sitelongitude,
      "guestinfo.ves.token"                       = var.sitetoken
    }
  }

}

output "vm1" {
  value = vsphere_virtual_machine.vm.id
}
output "vm2" {
  value = vsphere_virtual_machine.vm2.id
}
output "vm3" {
  value = vsphere_virtual_machine.vm3.id
}
