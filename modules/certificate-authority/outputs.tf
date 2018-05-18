output "cer_asg_id" {
  value = "${azurerm_application_security_group.cer-asg.id}"
}

output "cer_nsg_id" {
  value = "${azurerm_network_security_group.cer-nsg.id}"
}
