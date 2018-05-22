
resource "azurerm_virtual_network" "vnet" {

	name = "${var.resource_group_name}-vnet"
	address_space = ["172.18.5.0/24"]
	location = "${var.location}"
	resource_group_name = "${var.resource_group_name}"
	dns_servers = ["172.18.5.4", "172.18.5.5"]
}

resource "azurerm_subnet" "subnet-mad" {
	name                 = "subnet-mad"
	virtual_network_name = "${azurerm_virtual_network.vnet.name}"
	resource_group_name  = "${var.resource_group_name}"
	address_prefix       = "172.18.5.0/28"
}

resource "azurerm_subnet" "subnet-mtg" {
	name                 = "subnet-mtg"
	virtual_network_name = "${azurerm_virtual_network.vnet.name}"
	resource_group_name  = "${var.resource_group_name}"
	address_prefix       = "172.18.5.16/28"
}

resource "azurerm_subnet" "subnet-msc" {
	name                 = "subnet-msc"
	virtual_network_name = "${azurerm_virtual_network.vnet.name}"
	resource_group_name  = "${var.resource_group_name}"
	address_prefix       = "172.18.5.32/27"
}
