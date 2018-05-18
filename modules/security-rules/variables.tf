variable "resource_group_name" {
  description = "The name of the Resource Group where the Domain Controllers resources will be created"
}

variable "location" {
  description = "The Azure Region in which the Resource Group exists"
}

variable "prefix" {
  description = "The Prefix used for the Domain Controller's resources"
}

variable "admin_username" {
  description = "The username associated with the local administrator account on the virtual machine"
}

variable "admin_password" {
  description = "The password associated with the local administrator account on the virtual machine"
}

variable "mad_nsg_id" { }
variable "cer_nsg_id" { }
variable "mtg_nsg_id" { }
variable "msc_nsg_id" { }
variable "sql_nsg_id" { }

variable "mad_asg_id" { }
variable "cer_asg_id" { }
variable "mtg_asg_id" { }
variable "msc_asg_id" { }
variable "sql_asg_id" { }

