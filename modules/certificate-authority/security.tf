

resource "azurerm_application_security_group" "cer-asg" {
  name                = "${var.prefix}-cer-asg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_network_security_group" "cer-nsg" {

	name                = "${var.prefix}-cer-nsg"
	location            = "${var.location}"
	resource_group_name = "${var.resource_group_name}"

}
