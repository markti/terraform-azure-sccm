locals {
  primary_virtual_machine_name = "${var.prefix}MTG401"
  primary_virtual_machine_fqdn = "${local.primary_virtual_machine_name}.${var.active_directory_domain}"
}

resource "azurerm_public_ip" "mtg401_ip" {
  name                         = "${local.primary_virtual_machine_name}-ppip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "static"
}

resource "azurerm_network_interface" "mtg401_nic" {
	name                    = "${local.primary_virtual_machine_name}-nic"
	location                = "${var.location}"
	resource_group_name     = "${var.resource_group_name}"
	internal_dns_name_label = "${local.primary_virtual_machine_name}"
	network_security_group_id = "${azurerm_network_security_group.mtg-nsg.id}"

	ip_configuration {
		name                          = "primary"
		subnet_id                     = "${var.subnet_id}"
		private_ip_address_allocation = "dynamic"
		public_ip_address_id          = "${azurerm_public_ip.mtg401_ip.id}"
		application_security_group_ids = ["${azurerm_application_security_group.mtg-asg.id}"]
	}
}


resource "azurerm_virtual_machine" "client" {

	name                          = "${local.primary_virtual_machine_name}"
	location                      = "${var.location}"
	resource_group_name           = "${var.resource_group_name}"
	network_interface_ids         = ["${azurerm_network_interface.mtg401_nic.id}"]
	vm_size                       = "Standard_DS1_v2"
	delete_os_disk_on_termination = true


	storage_image_reference {
		id = "${data.azurerm_image.mtg_search.id}"
	}

	storage_os_disk {
		name              = "${local.primary_virtual_machine_name}-disk1"
		caching           = "ReadWrite"
		create_option     = "FromImage"
		managed_disk_type = "Standard_LRS"
	}

	os_profile {
		computer_name  = "${local.primary_virtual_machine_name}"
		admin_username = "${var.admin_username}"
		admin_password = "${var.admin_password}"
	}

	os_profile_windows_config {
		provision_vm_agent        = true
		enable_automatic_upgrades = true
	}
}