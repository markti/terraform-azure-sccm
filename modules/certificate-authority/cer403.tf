locals {
  cer403_name = "${var.prefix}CER403"
  cer403_fqdn = "${local.cer403_name}.${var.active_directory_domain}"
}

resource "azurerm_network_interface" "primary_sub_nic" {
	name                    = "${local.cer403_name}-nic"
	location                = "${var.location}"
	resource_group_name     = "${var.resource_group_name}"
	internal_dns_name_label = "${local.cer403_name}"
	network_security_group_id = "${azurerm_network_security_group.cer-nsg.id}"

	ip_configuration {
		name                          = "primary_ca"
		subnet_id                     = "${var.subnet_id}"
		private_ip_address_allocation = "static"
		private_ip_address            = "172.18.4.8"
		application_security_group_ids = ["${azurerm_application_security_group.cer-asg.id}"]
	}
}


resource "azurerm_virtual_machine" "cer403" {

	name                          = "${local.cer403_name}"
	location                      = "${var.location}"
	resource_group_name           = "${var.resource_group_name}"
	network_interface_ids         = ["${azurerm_network_interface.primary_sub_nic.id}"]
	vm_size                       = "Standard_DS1_v2"
	delete_os_disk_on_termination = true

	storage_image_reference {
		id = "${data.azurerm_image.cer_search.id}"
	}

	storage_os_disk {
		name              = "${local.cer403_name}-disk1"
		caching           = "ReadWrite"
		create_option     = "FromImage"
		managed_disk_type = "Standard_LRS"
	}

	os_profile {
		computer_name  = "${local.cer403_name}"
		admin_username = "${var.admin_username}"
		admin_password = "${var.admin_password}"
	}

	os_profile_windows_config {
		provision_vm_agent        = true
		enable_automatic_upgrades = true
	}
}