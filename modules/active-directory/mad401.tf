locals {
  mad401_name = "${var.prefix}MAD401"
  mad401_fqdn = "${local.mad401_name}.${var.active_directory_domain}"
}

resource "azurerm_network_interface" "mad401_nic" {
	name                    = "${local.mad401_name}-nic"
	location                = "${var.location}"
	resource_group_name     = "${var.resource_group_name}"
	internal_dns_name_label = "${local.mad401_name}"
	network_security_group_id = "${azurerm_network_security_group.mad-nsg.id}"

	ip_configuration {
		name                          = "primary_dc"
		subnet_id                     = "${var.subnet_id}"
		private_ip_address_allocation = "static"
		private_ip_address            = "172.18.4.4"
		application_security_group_ids = ["${azurerm_application_security_group.mad-asg.id}"]
	}
}


resource "azurerm_virtual_machine" "mad401" {
  name                          = "${local.mad401_name}"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  network_interface_ids         = ["${azurerm_network_interface.mad401_nic.id}"]
  vm_size                       = "Standard_B2s"
  delete_os_disk_on_termination = true

	storage_image_reference {
		id = "${data.azurerm_image.mad_search.id}"
	}

  storage_os_disk {
    name              = "${local.mad401_name}-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${local.mad401_name}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }
}