

resource "azurerm_application_security_group" "mad-asg" {
  name                = "${var.prefix}-mad-asg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}



resource "azurerm_network_security_group" "mad-nsg" {

	name                = "${var.prefix}-mad-nsg"
	location            = "${var.location}"
	resource_group_name = "${var.resource_group_name}"

}

