# General vCenter data
# vCenter / ESXi Username
variable "user" {}
# vCenter / ESXi Password
variable "password" {}
# vCenter / ESXi Endpoint
variable "vsphere_server" {}
variable "vsphere_host" {}
# vCenter / ESXi Datacenter
variable "datacenter" {}
# vCenter / ESXi Datastore
variable "datastore" {}
# vCenter / ESXi ResourcePool
variable "resource_pool" {}
# Virtual Machine configuration

# VM Name
#variable "name" {}
# Name of OVA template (chosen in import process)
#variable "template" {}
# VM Network
variable "outside_network" {}
variable "inside_network" {}
variable "publicdefaultgateway" {}
variable "dnsservers" {}
# VM Number of CPU's
variable "cpus" {}
# VM Memory in MB
variable "memory" {}

## XCS Values
variable "xcsovapath" {}
variable "certifiedhardware" {}
variable "publicinterfaceaddress" {}
variable "publicdefaultroute" {}
variable "sitelatitude" {}
variable "sitelongitude" {}
variable "nodenames" {}
variable "clustername" {}
variable "sitetoken" {}
variable "guest_type" {}
