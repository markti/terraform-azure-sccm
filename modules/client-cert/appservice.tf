locals {
  app_service_plan_name = "${var.prefix}MSC-plan"
  aia_cdp_app_name = "wentestpfx"
  certreq_app_name = "wenuse1clientr"
  app_service_plan_sku_tier = "Standard"
  app_service_plan_sku_size = "S1"
}

resource "azurerm_app_service_plan" "default" {
  name                = "${local.app_service_plan_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  sku {
    tier = "${local.app_service_plan_sku_tier}"
    size = "${local.app_service_plan_sku_size}"
  }
}

resource "azurerm_app_service" "aia-cdp-app" {
	name                = "${local.aia_cdp_app_name}"
	location            = "${var.location}"
	resource_group_name = "${var.resource_group_name}"
	app_service_plan_id = "${azurerm_app_service_plan.default.id}"

	site_config {
		dotnet_framework_version = "v4.0"
		remote_debugging_enabled = true
		remote_debugging_version = "VS2015"
	}

	app_settings {
		"SOME_KEY" = "some-value"
	}
}
resource "azurerm_app_service" "certreq-app" {
	name                = "${local.certreq_app_name}"
	location            = "${var.location}"
	resource_group_name = "${var.resource_group_name}"
	app_service_plan_id = "${azurerm_app_service_plan.default.id}"

	site_config {
		dotnet_framework_version = "v4.0"
		remote_debugging_enabled = true
		remote_debugging_version = "VS2015"
	}

	app_settings {
		"SOME_KEY" = "some-value"
	}
}

resource "azurerm_servicebus_namespace" "service-bus" {
  name                = "${var.prefix}-certreq-relay"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "basic"
}