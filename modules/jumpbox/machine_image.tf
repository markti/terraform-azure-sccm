

data "azurerm_image" "mtg_search" {
  name                = "windows-security-tools_v1_0"
  resource_group_name = "${var.image_resource_group}"
}