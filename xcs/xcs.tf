terraform {
  required_version = ">= 0.12"
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.7"
    }
  }
}

resource "volterra_k8s_cluster" "cluster" {
  name      = format("%s-k8s", var.sitename)
  namespace = "system"

  no_cluster_wide_apps              = true
  use_default_cluster_role_bindings = true

  use_default_cluster_roles = true

  cluster_scoped_access_permit = true
  global_access_enable         = true
  no_insecure_registries       = true

  local_access_config {
    local_domain = format("%s.local", var.sitename)
    default_port = true
  }
  use_default_psp = true
}

resource "volterra_virtual_site" "vsite" {
  name = format("%s-vsite", var.sitename)
  #name      = "${var.sitename}-vsite"
  namespace = "shared"

  site_selector {
    expressions = ["${var.sitename} in (true)"]
  }

  site_type = "CUSTOMER_EDGE"
}

resource "volterra_voltstack_site" "vsphere_cluster" {
  name      = format("%s-cluster", var.sitename)
  namespace = "system"

  no_bond_devices = true
  disable_gpu     = true

  k8s_cluster {
    namespace = "system"
    name      = volterra_k8s_cluster.cluster.name
  }

  master_nodes = [var.nodenames["nodeone"], var.nodenames["nodetwo"], var.nodenames["nodethree"]]

  logs_streaming_disabled = true
  default_network_config  = true
  default_storage_config  = true
  deny_all_usb            = true
  volterra_certified_hw   = "vmware-voltstack-combo"
}

resource "volterra_registration_approval" "approvalone" {
  depends_on = [
    volterra_voltstack_site.vsphere_cluster
  ]
  cluster_name = format("%s-cluster", var.sitename)
  hostname     = var.nodenames["nodeone"]
  cluster_size = 3
  retry        = 5
  wait_time    = 300
  latitude     = var.sitelatitude
  longitude    = var.sitelongitude
}
resource "volterra_registration_approval" "approvaltwo" {
  depends_on = [
    volterra_voltstack_site.vsphere_cluster, volterra_registration_approval.approvalone
  ]
  cluster_name = format("%s-cluster", var.sitename)
  hostname     = var.nodenames["nodetwo"]
  cluster_size = 3
  retry        = 5
  wait_time    = 480
  latitude     = var.sitelatitude
  longitude    = var.sitelongitude
}
resource "volterra_registration_approval" "approvalthree" {
  depends_on = [
    volterra_voltstack_site.vsphere_cluster, volterra_registration_approval.approvalone, volterra_registration_approval.approvaltwo
  ]
  cluster_name = format("%s-cluster", var.sitename)
  hostname     = var.nodenames["nodethree"]
  cluster_size = 3
  retry        = 5
  wait_time    = 600
  latitude     = var.sitelatitude
  longitude    = var.sitelongitude
}
