data "vsphere_host" "host_two" {
  name          = var.vsphere_host_two
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore_two" {
  name          = var.datastore_two
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm2" {
  count            = var.cluster_size == 3 ? 1 : 0
  name             = var.nodenames["nodetwo"]
  datacenter_id    = data.vsphere_datacenter.dc.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore_two.id
  host_system_id   = data.vsphere_host.host_two.id

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

output "vm2" {
  value = vsphere_virtual_machine.vm2[*].id
}
