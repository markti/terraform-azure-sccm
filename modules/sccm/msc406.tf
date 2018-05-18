locals {
  msc406_name = "${var.prefix}MSC406"
  msc406_fqdn = "${local.msc406_name}.${var.active_directory_domain}"
}

resource "azurerm_network_interface" "msc406_nic" {
	name                    = "${local.msc406_name}-nic"
	location                = "${var.location}"
	resource_group_name     = "${var.resource_group_name}"
	internal_dns_name_label = "${local.msc406_name}"
	network_security_group_id = "${azurerm_network_security_group.msc-nsg.id}"

	ip_configuration {
		name                          = "primary"
		subnet_id                     = "${var.subnet_id}"
		private_ip_address_allocation = "dynamic"
		application_security_group_ids = ["${azurerm_application_security_group.msc-asg.id}"]
	}
}


resource "azurerm_virtual_machine" "msc406" {

	name                          = "${local.msc406_name}"
	location                      = "${var.location}"
	resource_group_name           = "${var.resource_group_name}"
	network_interface_ids         = ["${azurerm_network_interface.msc406_nic.id}"]
	vm_size                       = "Standard_DS1_v2"
	delete_os_disk_on_termination = true

	storage_image_reference {
		publisher = "MicrosoftWindowsServer"
		offer     = "WindowsServer"
		sku       = "2016-Datacenter"
		version   = "latest"
	}

	storage_os_disk {
		name              = "${local.msc406_name}-disk1"
		caching           = "ReadWrite"
		create_option     = "FromImage"
		managed_disk_type = "Standard_LRS"
	}

	os_profile {
		computer_name  = "${local.msc406_name}"
		admin_username = "${var.admin_username}"
		admin_password = "${var.admin_password}"
	}

	os_profile_windows_config {
		provision_vm_agent        = true
		enable_automatic_upgrades = true
	}
}