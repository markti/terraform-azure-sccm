locals {
  sql401_name = "${var.prefix}SQL401"
  sql401_fqdn = "${local.sql401_name}.${var.active_directory_domain}"
}

resource "azurerm_network_interface" "sql401_nic" {
	name                    = "${local.sql401_name}-nic"
	location                = "${var.location}"
	resource_group_name     = "${var.resource_group_name}"
	internal_dns_name_label = "${local.sql401_name}"
	network_security_group_id = "${azurerm_network_security_group.sql-nsg.id}"

	ip_configuration {
		name                          = "primary"
		subnet_id                     = "${var.subnet_id}"
		private_ip_address_allocation = "dynamic"
		application_security_group_ids = ["${azurerm_application_security_group.sql-asg.id}"]
	}
}

resource "azurerm_virtual_machine" "sql401" {

	name                          = "${local.sql401_name}"
	location                      = "${var.location}"
	resource_group_name           = "${var.resource_group_name}"
	network_interface_ids         = ["${azurerm_network_interface.sql401_nic.id}"]
	vm_size                       = "Standard_DS12_v2"
	delete_os_disk_on_termination = true

	storage_image_reference {
		id = "${data.azurerm_image.sql401_search.id}"
	}

	storage_os_disk {
		name              = "${local.sql401_name}-disk1"
		caching           = "ReadWrite"
		create_option     = "FromImage"
		managed_disk_type = "Standard_LRS"
	}

	os_profile {
		computer_name  = "${local.sql401_name}"
		admin_username = "${var.admin_username}"
		admin_password = "${var.admin_password}"
	}

	os_profile_windows_config {
		provision_vm_agent        = true
		enable_automatic_upgrades = true
	}
}