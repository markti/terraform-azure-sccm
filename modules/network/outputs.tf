output "mtg_subnet_id" {
  value = "${azurerm_subnet.subnet-mtg.id}"
}

output "mad_subnet_id" {
  value = "${azurerm_subnet.subnet-mad.id}"
}

output "msc_subnet_id" {
  value = "${azurerm_subnet.subnet-msc.id}"
}