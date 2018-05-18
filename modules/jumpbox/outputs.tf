output "mtg_asg_id" {
  value = "${azurerm_application_security_group.mtg-asg.id}"
}

output "mtg_nsg_id" {
  value = "${azurerm_network_security_group.mtg-nsg.id}"
}
