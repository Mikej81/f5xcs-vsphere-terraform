# VMWare vSphere Terraform to Deploy 3 Node AppStack Cluster

<!--TOC-->

- [VMWare vSphere Terraform to Deploy 3 Node AppStack Cluster](#vmware-vsphere-terraform-to-deploy-3-node-appstack-cluster)
  - [VMWare & VMWare Provider Configuration(s)](#vmware--vmware-provider-configurations)
  - [F5 Distributed Cloud Configuration(s)](#f5-distributed-cloud-configurations)
    - [API Certificate](#api-certificate)
  - [Terraform](#terraform)

<!--TOC-->

## VMWare & VMWare Provider Configuration(s)

First, we need the VMWare environment configured.  You will need a datacenter, a cluster, and a resource pool.

![Screen Shot 1](/img/vsphereclient1.png)

We will be using the VMWare Terraform Provider to create a [vsphere_virtual_machine resource](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/virtual_machine).

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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
