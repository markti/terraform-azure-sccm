

data "azurerm_image" "sql401_search" {
  name                = "sqlserver-2012-sp4-baseline_v1_0"
  resource_group_name = "${var.image_resource_group}"
}

data "azurerm_image" "msc401_search" {
  name                = "sccm-primarysite_v1_0"
  resource_group_name = "${var.image_resource_group}"
}

data "azurerm_image" "msc402_search" {
  name                = "windows-baseline_v1_0"
  resource_group_name = "${var.image_resource_group}"
}

data "azurerm_image" "msc403_search" {
  name                = "windows-baseline_v1_0"
  resource_group_name = "${var.image_resource_group}"
}
data "azurerm_image" "msc404_search" {
  name                = "windows-baseline_v1_0"
  resource_group_name = "${var.image_resource_group}"
}
data "azurerm_image" "msc405_search" {
  name                = "windows-baseline_v1_0"
  resource_group_name = "${var.image_resource_group}"
}
data "azurerm_image" "msc406_search" {
  name                = "windows-baseline_v1_0"
  resource_group_name = "${var.image_resource_group}"
}