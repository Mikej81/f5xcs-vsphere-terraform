variable "user" {
  type        = string
  description = "REQUIRED:  Provide a vpshere username.  [admin@vsphere.local]"
}
variable "password" {
  type        = string
  description = "REQUIRED:  Provide a vsphere password."
}
variable "vsphere_server" {
  type        = string
  description = "REQUIRED:  Provide a vsphere server or appliance. [vSphere URL (IP, hostname or FQDN)]"
}
variable "vsphere_host" {
  type        = string
  description = "REQUIRED:  Provide a vcenter host. [vCenter URL (IP, hostname or FQDN)]"
}
variable "datacenter" {
  type        = string
  description = "REQUIRED:  Provide a Datacenter Name."
}
variable "datastore" {
  type        = string
  description = "REQUIRED:  Provide a Datastore Name."
}
# vCenter / ESXi ResourcePool
variable "resource_pool" {
  type        = string
  description = "REQUIRED:  Provide a Resource Pool Name."

}
# Virtual Machine configuration

# VM Network
variable "outside_network" {
  type        = string
  description = "REQUIRED:  Provide a Name for the Outside Interface Network. [ SLO ]"
}
variable "inside_network" {
  type        = string
  description = "REQUIRED:  Provide a Name for the Inside Interface Network. [ SLI ]"
}
# VM Number of CPU's
variable "cpus" {
  type        = number
  description = "REQUIRED:  Provide a vCPU count.  [ Not Less than 4, and do not limit each instance less than 2.9GHz ]"
  default     = 4
}
# VM Memory in MB
variable "memory" {
  type        = number
  description = "REQUIRED:  Provide RAM.  [ Not Less than 14336Mb / 14Gb ]"
  default     = 14336
}
variable "xcsovapath" {
  type        = string
  description = "REQUIRED: Path to XCS OVA"
  default     = "/home/michael/Downloads/centos-7.2009.10-202107041731.ova"
}
variable "guest_type" {
  type        = string
  description = "Guest OS Type: centos7_64Guest, other3xLinux64Guest"
  default     = "other3xLinux64Guest"
}

## XCS Values
// Required Variable
variable "projectName" {
  type        = string
  description = "REQUIRED:  Provide a Prefix for use in F5 XCS created resources"
  default     = "project-name"
}
variable "tenant" {
  type        = string
  description = "REQUIRED:  Provide the F5 XCS Tenant name."
  default     = "xc tenant id"
}


variable "certifiedhardware" {
  type        = string
  description = "REQUIRED: XCS Certified Hardware Type: vmware-voltmesh, vmware-voltstack-combo, vmware-regular-nic-voltmesh, vmware-multi-nic-voltmesh, vmware-multi-nic-voltstack-combo"
  default     = "vmware-voltstack-combo"
}
variable "public_addresses" {
  type        = map(string)
  description = "REQUIRED: XCS Node Public Interfaces Addresses"
  default = {
    nodeone   = "192.168.125.66/24"
    nodetwo   = "192.168.125.67/24"
    nodethree = "192.168.125.68/24"
  }
}

variable "publicinterfaceaddress" {
  type        = string
  description = "REQUIRED: XCS Public interface Address.  Must include CIDR notation."
  default     = "192.168.125.66/24"
}

variable "publicdefaultroute" {
  type        = string
  description = "REQUIRED: XCS Public default route.  Must include CIDR notation."
  default     = "0.0.0.0/0"
}

variable "publicdefaultgateway" {
  type        = string
  description = "REQUIRED: XCS Public default route.  Must include CIDR notation."
  default     = "192.168.125.1"
}

variable "sitelatitude" {
  type        = string
  description = "REQUIRED: Site Physical Location Latitude."
  default     = "30"
}
variable "sitelongitude" {
  type        = string
  description = "REQUIRED: Site Physical Location Longitude."
  default     = "-75"
}

variable "dnsservers" {
  description = "REQUIRED: XCS Site DNS Servers."
  type        = map(string)
  default = {
    primary   = "8.8.8.8"
    secondary = "8.8.4.4"
  }
}
variable "nodenames" {
  description = "REQUIRED: XCS Node Names."
  type        = map(string)
  default = {
    nodeone   = "edgesite-0"
    nodetwo   = "edgesite-1"
    nodethree = "edgesite-2"
  }
}
variable "clustername" {
  type        = string
  description = "REQUIRED: Site Cluster Name."
  default     = "coleman-vsphere-cluster"
}
variable "sitetoken" {
  type        = string
  description = "REQUIRED: Site Registration Token."
  default     = "12345678910"
}

variable "sitename" {
  type        = string
  description = "REQUIRED:  This is name for your deployment"
  default     = "adrastea"
}

variable "sshPublicKey" {
  type        = string
  description = "OPTIONAL: ssh public key for instances"
  default     = ""
}
variable "sshPublicKeyPath" {
  type        = string
  description = "OPTIONAL: ssh public key path for instances"
  default     = "~/.ssh/id_rsa.pub"
}
// Required Variable
variable "api_p12_file" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api-creds.p12"
}
variable "namespace" {
  type        = string
  description = "REQUIRED:  This is your volterra App Namespace"
  default     = "namespace"
}
variable "api_cert" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api2.cer"
}
variable "api_key" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api.key"
}
variable "api_url" {
  type        = string
  description = "REQUIRED:  This is your volterra API url"
  default     = "https://playground.console.ves.volterra.io/api"
}
