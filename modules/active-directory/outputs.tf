output "mad_asg_id" {
  value = "${azurerm_application_security_group.mad-asg.id}"
}

output "mad_nsg_id" {
  value = "${azurerm_network_security_group.mad-nsg.id}"
}
