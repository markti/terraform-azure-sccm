
resource "azurerm_virtual_network" "vnet" {

	name = "${var.resource_group_name}-vnet"
	address_space = ["172.18.4.0/24"]
	location = "${var.location}"
	resource_group_name = "${var.resource_group_name}"
	dns_servers = ["172.18.4.4", "172.18.4.5"]
}

resource "azurerm_subnet" "subnet-mad" {
	name                 = "subnet-mad"
	virtual_network_name = "${azurerm_virtual_network.vnet.name}"
	resource_group_name  = "${var.resource_group_name}"
	address_prefix       = "172.18.4.0/28"
}

resource "azurerm_subnet" "subnet-mtg" {
	name                 = "subnet-mtg"
	virtual_network_name = "${azurerm_virtual_network.vnet.name}"
	resource_group_name  = "${var.resource_group_name}"
	address_prefix       = "172.18.4.16/28"
}

resource "azurerm_subnet" "subnet-msc" {
	name                 = "subnet-msc"
	virtual_network_name = "${azurerm_virtual_network.vnet.name}"
	resource_group_name  = "${var.resource_group_name}"
	address_prefix       = "172.18.4.32/27"
}
