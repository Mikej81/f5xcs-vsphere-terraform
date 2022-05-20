# VMWare vSphere Terraform to Deploy 3 Node AppStack Cluster

-------

<!--TOC-->

- [VMWare vSphere Terraform to Deploy 3 Node AppStack Cluster](#vmware-vsphere-terraform-to-deploy-3-node-appstack-cluster)
  - [VMWare & VMWare Provider Configuration(s)](#vmware--vmware-provider-configurations)
  - [F5 Distributed Cloud Configuration(s)](#f5-distributed-cloud-configurations)
    - [API Certificate](#api-certificate)
  - [Terraform](#terraform)
  - [Requirements](#requirements)
  - [Providers](#providers)
  - [Modules](#modules)
  - [Resources](#resources)
  - [Inputs](#inputs)
  - [Outputs](#outputs)
  - [Install](#install)
  - [Support](#support)

<!--TOC-->

-------

## VMWare & VMWare Provider Configuration(s)

First, we need the VMWare environment configured.  You will need a datacenter, a cluster, and a resource pool.

![Screen Shot 1](/img/vsphereclient1.png)

We will be using the VMWare Terraform Provider to create a [vsphere_virtual_machine resource](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine).

-------

## F5 Distributed Cloud Configuration(s)

Within F5 Distributed Cloud (F5XCS) you will need to create yourself an API Certificate.  Which we will then map for our Terraform to use to create the objects in F5XCS.

### API Certificate

1. Log in to your F5 XCS Console.
2. In the Upper Right hand corner, click the User Account Icon.
3. Then click "Account Settings."
4. Click Add Credentials.
5. Enter a Credential Name.
6. Set a password.
7. Set an Expiration date.
8. Download your Key Pair.

![Screen Shot 2](/img/xcconsole.png)

![Screen Shot 3](/img/credentials.png)

-------

## Terraform

#### OPTIONAL

Before we get to the Terraform variables, there is an example prep script provided, this CAN be used to map API Certificate and password to ENV Vars, but you can use whatever method you are comfortable with for secrets.

Set VOLT_API_P12_FILE and VES_P12_PASSWORD.

```bash
export VOLT_API_P12_FILE=/creds/.api-creds.p12
export VES_P12_PASSWORD=12345678
```

Run the script to map creds.

```bash
. ./prep.sh
```

#### Required

We need to set our variables, you can change the variables.tf file directly, create and override.tf or use tfvars, whichever method you are comfortable with.  In this document we will cover variables.tf and override.tf.

##### Terraform Variables

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 2.1.0 |
| <a name="requirement_volterrarm"></a> [volterrarm](#requirement\_volterrarm) | 0.11.7 |
| <a name="requirement_vsphere"></a> [vsphere](#requirement\_vsphere) | 2.1.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_util"></a> [util](#module\_util) | ./util | n/a |
| <a name="module_vsphere"></a> [vsphere](#module\_vsphere) | ./vsphere | n/a |
| <a name="module_xcs"></a> [xcs](#module\_xcs) | ./xcs | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_cert"></a> [api\_cert](#input\_api\_cert) | REQUIRED:  This is the path to the Volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials | `string` | `"./creds/api2.cer"` | no |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | REQUIRED:  This is the path to the Volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials | `string` | `"./creds/api.key"` | no |
| <a name="input_api_p12_file"></a> [api\_p12\_file](#input\_api\_p12\_file) | REQUIRED:  This is the path to the Volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials | `string` | `"./creds/f5-sa.console.ves.volterra.io.api-creds.p12"` | no |
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | REQUIRED:  This is your Volterra Namespace | `string` | `"https://f5-sa.console.ves.volterra.io/api"` | no |
| <a name="input_certifiedhardware"></a> [certifiedhardware](#input\_certifiedhardware) | REQUIRED: XCS Certified Hardware Type: vmware-voltmesh, vmware-voltstack-combo, vmware-regular-nic-voltmesh, vmware-multi-nic-voltmesh, vmware-multi-nic-voltstack-combo | `string` | `"vmware-voltstack-combo"` | no |
| <a name="input_clustername"></a> [clustername](#input\_clustername) | REQUIRED: Site Cluster Name. | `string` | `"coleman-vsphere-cluster"` | no |
| <a name="input_cpus"></a> [cpus](#input\_cpus) | REQUIRED:  Provide a vCPU count.  [ Not Less than 4, and do not limit each instance less than 2.9GHz ] | `number` | `4` | no |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | REQUIRED:  Provide a Datacenter Name. | `string` | `"HOME"` | no |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | REQUIRED:  Provide a Datastore Name. | `string` | `"nvme-datastore-5i-1"` | no |
| <a name="input_dnsservers"></a> [dnsservers](#input\_dnsservers) | REQUIRED: XCS Site DNS Servers. | `map(string)` | <pre>{<br>  "primary": "8.8.8.8",<br>  "secondary": "8.8.4.4"<br>}</pre> | no |
| <a name="input_guest_type"></a> [guest\_type](#input\_guest\_type) | Guest OS Type: centos7\_64Guest, other3xLinux64Guest | `string` | `"other3xLinux64Guest"` | no |
| <a name="input_inside_network"></a> [inside\_network](#input\_inside\_network) | REQUIRED:  Provide a Name for the Inside Interface Network. [ SLI ] | `string` | `"Internal Only"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | REQUIRED:  Provide RAM.  [ Not Less than 14336Mb / 14Gb ] | `number` | `14336` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | REQUIRED:  This is your volterra App Namespace | `string` | `"namespace"` | no |
| <a name="input_nodenames"></a> [nodenames](#input\_nodenames) | REQUIRED: XCS Node Names. | `map(string)` | <pre>{<br>  "nodeone": "edgesite-0",<br>  "nodethree": "edgesite-2",<br>  "nodetwo": "edgesite-1"<br>}</pre> | no |
| <a name="input_outside_network"></a> [outside\_network](#input\_outside\_network) | REQUIRED:  Provide a Name for the Outside Interface Network. [ SLO ] | `string` | `"Default"` | no |
| <a name="input_password"></a> [password](#input\_password) | REQUIRED:  Provide a vsphere password. | `string` | `"B@llerhat1"` | no |
| <a name="input_projectName"></a> [projectName](#input\_projectName) | REQUIRED:  Provide a Prefix for use in F5 XCS created resources | `string` | `"project-name"` | no |
| <a name="input_public_addresses"></a> [public\_addresses](#input\_public\_addresses) | REQUIRED: XCS Node Public Interfaces Addresses | `map(string)` | <pre>{<br>  "nodeone": "192.168.125.66/24",<br>  "nodethree": "192.168.125.68/24",<br>  "nodetwo": "192.168.125.67/24"<br>}</pre> | no |
| <a name="input_publicdefaultgateway"></a> [publicdefaultgateway](#input\_publicdefaultgateway) | REQUIRED: XCS Public default route.  Must include CIDR notation. | `string` | `"192.168.125.1"` | no |
| <a name="input_publicdefaultroute"></a> [publicdefaultroute](#input\_publicdefaultroute) | REQUIRED: XCS Public default route.  Must include CIDR notation. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_publicinterfaceaddress"></a> [publicinterfaceaddress](#input\_publicinterfaceaddress) | REQUIRED: XCS Public interface Address.  Must include CIDR notation. | `string` | `"192.168.125.66/24"` | no |
| <a name="input_resource_pool"></a> [resource\_pool](#input\_resource\_pool) | REQUIRED:  Provide a Resource Pool Name. | `string` | `"XC Limited-Low"` | no |
| <a name="input_sitelatitude"></a> [sitelatitude](#input\_sitelatitude) | REQUIRED: Site Physical Location Latitude. | `string` | `"40"` | no |
| <a name="input_sitelongitude"></a> [sitelongitude](#input\_sitelongitude) | REQUIRED: Site Physical Location Longitude. | `string` | `"-70"` | no |
| <a name="input_sitename"></a> [sitename](#input\_sitename) | REQUIRED:  This is name for your deployment | `string` | `"adrastea"` | no |
| <a name="input_sitetoken"></a> [sitetoken](#input\_sitetoken) | REQUIRED: Site Registration Token. | `string` | `"8adee1cf-33f6-47a6-b2e1-670394cc6483"` | no |
| <a name="input_sshPublicKey"></a> [sshPublicKey](#input\_sshPublicKey) | OPTIONAL: ssh public key for instances | `string` | `""` | no |
| <a name="input_sshPublicKeyPath"></a> [sshPublicKeyPath](#input\_sshPublicKeyPath) | OPTIONAL: ssh public key path for instances | `string` | `"./creds/id_rsa.pub"` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | REQUIRED:  This is your Volterra Tenant Name:  https://<tenant\_name>.console.ves.volterra.io/api | `string` | `"f5-sa"` | no |
| <a name="input_user"></a> [user](#input\_user) | REQUIRED:  Provide a vpshere username.  [admin@vsphere.local] | `string` | `"administrator@vsphere.local"` | no |
| <a name="input_vsphere_host"></a> [vsphere\_host](#input\_vsphere\_host) | REQUIRED:  Provide a vcenter host. [vCenter URL (IP, hostname or FQDN)] | `string` | `"vcenter2.f5lab.com"` | no |
| <a name="input_vsphere_server"></a> [vsphere\_server](#input\_vsphere\_server) | REQUIRED:  Provide a vsphere server or appliance. [vSphere URL (IP, hostname or FQDN)] | `string` | `"vsphere.f5lab.com"` | no |
| <a name="input_xcsovapath"></a> [xcsovapath](#input\_xcsovapath) | REQUIRED: Path to XCS OVA | `string` | `"/home/michael/Downloads/centos-7.2009.10-202107041731.ova"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_completion_time"></a> [completion\_time](#output\_completion\_time) | Outputs the time of script completion.  Just for auditing purposes. |
<!-- END_TF_DOCS -->

## Install

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

-------

## Support

Bugs and enhancements can be made by opening an `issue`_within the `GitHub`_ repository.

-------
