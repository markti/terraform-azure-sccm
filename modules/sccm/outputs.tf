output "msc_asg_id" {
  value = "${azurerm_application_security_group.msc-asg.id}"
}

output "msc_nsg_id" {
  value = "${azurerm_network_security_group.msc-nsg.id}"
}
output "sql_asg_id" {
  value = "${azurerm_application_security_group.sql-asg.id}"
}

output "sql_nsg_id" {
  value = "${azurerm_network_security_group.sql-nsg.id}"
}
