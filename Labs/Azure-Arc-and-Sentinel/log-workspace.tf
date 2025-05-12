resource "azurerm_log_analytics_workspace" "MyLogWorkspace" {
  name                = var.log-workspace-name
  location            = var.rg-location
  resource_group_name = var.rg-name
  sku                 = "PerGB2018"
}