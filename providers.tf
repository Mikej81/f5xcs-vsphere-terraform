terraform {
  required_version = ">= 0.13"
  required_providers {
    volterrarm = {
      source  = "volterraedge/volterra"
      version = "0.11.7"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.1.1"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
}

provider "volterrarm" {
  api_p12_file = var.api_p12_file
  api_cert     = var.api_p12_file != "" ? "" : var.api_cert
  api_key      = var.api_p12_file != "" ? "" : var.api_key
  url          = var.api_url
}

provider "http" {
}


provider "vsphere" {
  user           = var.user
  password       = var.password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}
