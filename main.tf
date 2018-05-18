provider "azurerm" 
{
	subscription_id = "${var.subscription_id}"
	client_id = "${var.client_id}"
	client_secret = "${var.client_secret}"
	tenant_id = "${var.tenant_id}"
}

locals {
  prefix = "WT"
  resource_group = "SCCM"
  active_directory_name = "AZRCORPFRANT.wendys.com"
  active_directory_netbios_name = "AZRCORPT"
}

resource "azurerm_resource_group" "rg" {

	name = "${local.prefix}-${local.resource_group}"
	location = "Central US"

}

resource "azurerm_recovery_services_vault" "vault" {
    name                = "${local.prefix}-recovery-vault"
    location            = "${azurerm_resource_group.rg.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    sku                 = "standard"
}

module "network" {

	source = 				"./modules/network"
	prefix = 				"${local.prefix}"
	resource_group_name = 	"${azurerm_resource_group.rg.name}"
	location = 				"${azurerm_resource_group.rg.location}"

}

module "jumpbox" {

	source                        = "./modules/jumpbox"
	prefix                        = "${local.prefix}"
	resource_group_name           = "${azurerm_resource_group.rg.name}"
	location                      = "${azurerm_resource_group.rg.location}"
	subnet_id                     = "${module.network.mtg_subnet_id}"
	active_directory_domain       = "${local.active_directory_name}"
	active_directory_netbios_name = "${local.active_directory_netbios_name}"
	admin_username                = "${var.admin_username}"
	admin_password                = "${var.admin_password}"
	image_resource_group			= "${var.image_resource_group}"
	
}

module "active-directory" {

	source                        = "./modules/active-directory"
	prefix                        = "${local.prefix}"
	resource_group_name           = "${azurerm_resource_group.rg.name}"
	location                      = "${azurerm_resource_group.rg.location}"
	subnet_id                     = "${module.network.mad_subnet_id}"
	active_directory_domain       = "${local.active_directory_name}"
	active_directory_netbios_name = "${local.active_directory_netbios_name}"
	admin_username                = "${var.admin_username}"
	admin_password                = "${var.admin_password}"
	image_resource_group			= "${var.image_resource_group}"

}

module "certificate-authority" {

	source                        = "./modules/certificate-authority"
	prefix                        = "${local.prefix}"
	resource_group_name           = "${azurerm_resource_group.rg.name}"
	location                      = "${azurerm_resource_group.rg.location}"
	subnet_id                     = "${module.network.mad_subnet_id}"
	active_directory_domain       = "${local.active_directory_name}"
	active_directory_netbios_name = "${local.active_directory_netbios_name}"
	admin_username                = "${var.admin_username}"
	admin_password                = "${var.admin_password}"
	image_resource_group			= "${var.image_resource_group}"

}

module "sccm" {

	source							= "./modules/sccm"
	prefix							= "${local.prefix}"
	resource_group_name				= "${azurerm_resource_group.rg.name}"
	location						= "${azurerm_resource_group.rg.location}"
	subnet_id						= "${module.network.msc_subnet_id}"
	active_directory_domain			= "${local.active_directory_name}"
	active_directory_netbios_name	= "${local.active_directory_netbios_name}"
	admin_username					= "${var.admin_username}"
	admin_password					= "${var.admin_password}"
	image_resource_group			= "${var.image_resource_group}"
	
}



module "client-cert" {

	source							= "./modules/client-cert"
	prefix							= "${local.prefix}"
	resource_group_name				= "${azurerm_resource_group.rg.name}"
	location						= "${azurerm_resource_group.rg.location}"
	admin_username					= "${var.admin_username}"
	admin_password					= "${var.admin_password}"
	
}
