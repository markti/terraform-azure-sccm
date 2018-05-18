

data "azurerm_image" "mad_search" {
  name                = "windows-baseline_v1_0"
  resource_group_name = "${var.image_resource_group}"
}