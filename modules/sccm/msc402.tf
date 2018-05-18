locals {
  msc402_name = "${var.prefix}MSC402"
  msc402_fqdn = "${local.msc402_name}.${var.active_directory_domain}"
}

resource "azurerm_network_interface" "msc402_nic" {
	name                    = "${local.msc402_name}-nic"
	location                = "${var.location}"
	resource_group_name     = "${var.resource_group_name}"
	internal_dns_name_label = "${local.msc402_name}"
	network_security_group_id = "${azurerm_network_security_group.msc-nsg.id}"

	ip_configuration {
		name                          = "primary"
		subnet_id                     = "${var.subnet_id}"
		private_ip_address_allocation = "dynamic"
		application_security_group_ids = ["${azurerm_application_security_group.msc-asg.id}"]
	}
}


resource "azurerm_virtual_machine" "msc402" {

	name                          = "${local.msc402_name}"
	location                      = "${var.location}"
	resource_group_name           = "${var.resource_group_name}"
	network_interface_ids         = ["${azurerm_network_interface.msc402_nic.id}"]
	vm_size                       = "Standard_DS2_v2"
	delete_os_disk_on_termination = true

	storage_image_reference {
		id = "${data.azurerm_image.msc402_search.id}"
	}

	storage_os_disk {
		name              = "${local.msc402_name}-disk1"
		caching           = "ReadWrite"
		create_option     = "FromImage"
		managed_disk_type = "Standard_LRS"
	}

	os_profile {
		computer_name  = "${local.msc402_name}"
		admin_username = "${var.admin_username}"
		admin_password = "${var.admin_password}"
	}

	os_profile_windows_config {
		provision_vm_agent        = true
		enable_automatic_upgrades = true
	}
}