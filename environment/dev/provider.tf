terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.47.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "todoapp_rg"
    storage_account_name = "toapptodostorageapp"
    container_name       = "todoappcontainer"
    key                  = "todo.terraform_state"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "25a6e005-402a-4c5b-a3a1-cdc394039a6d"
}
