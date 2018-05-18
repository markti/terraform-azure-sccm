### APPLICATION SECURITY GROUPS ###

# SCCM Component Servers #
resource "azurerm_application_security_group" "msc-asg" {
  name                = "${var.prefix}-msc-asg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

# SCCM SQL Server #
resource "azurerm_application_security_group" "sql-asg" {
  name                = "${var.prefix}-sql-asg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_network_security_group" "msc-nsg" {

	name                = "${var.prefix}-msc-nsg"
	location            = "${var.location}"
	resource_group_name = "${var.resource_group_name}"

}

resource "azurerm_network_security_group" "sql-nsg" {

	name                = "${var.prefix}-sql-nsg"
	location            = "${var.location}"
	resource_group_name = "${var.resource_group_name}"

}

resource "azurerm_network_security_rule" "sql_rule_in_mssql" {
	name                        				= "MSSQL"
	priority                    				= 1000
	direction                   				= "Inbound"
	access                      				= "Allow"
	protocol                    				= "Tcp"
	source_port_range           				= "*"
	destination_port_range      				= "1433"
	source_application_security_group_ids 		= ["${azurerm_application_security_group.msc-asg.id}"]
	destination_application_security_group_ids	= ["${azurerm_application_security_group.sql-asg.id}"]
	resource_group_name         				= "${var.resource_group_name}"
	network_security_group_name 				= "${azurerm_network_security_group.sql-nsg.name}"
}

