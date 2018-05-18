

resource "azurerm_application_security_group" "mtg-asg" {
  name                = "${var.prefix}-mtg-asg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}


resource "azurerm_network_security_group" "mtg-nsg" {

	name                = "${var.prefix}-mtg-nsg"
	location            = "${var.location}"
	resource_group_name = "${var.resource_group_name}"

}

resource "azurerm_network_security_rule" "mtg_mark_home" {
	name                        = "RDP_Mark_Home"
	priority                    = 1101
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "3389"
	source_address_prefix       = "24.208.228.169"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.mtg-asg.id}"]
	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${azurerm_network_security_group.mtg-nsg.name}"
}


resource "azurerm_network_security_rule" "mtg_arun_home" {
	name                        = "RDP_Arun_Home"
	priority                    = 1102
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "3389"
	source_address_prefix       = "49.206.113.44"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.mtg-asg.id}"]
	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${azurerm_network_security_group.mtg-nsg.name}"
}
resource "azurerm_network_security_rule" "mtg_boz_home" {
	name                        = "RDP_Boz_Home"
	priority                    = 1103
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "3389"
	source_address_prefix       = "107.221.42.75"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.mtg-asg.id}"]
	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${azurerm_network_security_group.mtg-nsg.name}"
}
resource "azurerm_network_security_rule" "mtg_wendys_office" {
	name                        = "RDP_wendys_Office"
	priority                    = 1104
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "3389"
	source_address_prefix       = "216.87.247.7"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.mtg-asg.id}"]
	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${azurerm_network_security_group.mtg-nsg.name}"
}

resource "azurerm_network_security_rule" "mtg_mifi_office" {
	name                        = "RDP_mifi_Office"
	priority                    = 1105
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "3389"
	source_address_prefix       = "173.154.246.209"
	destination_application_security_group_ids	= ["${azurerm_application_security_group.mtg-asg.id}"]
	resource_group_name         = "${var.resource_group_name}"
	network_security_group_name = "${azurerm_network_security_group.mtg-nsg.name}"
}
