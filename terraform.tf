#----------------------------------------
# terraform providers and configurations
#----------------------------------------
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    http = {
      source = "hashicorp/http"
      version = "3.4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "TerraformStateRG"
    storage_account_name = "tfstate1395347666"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

#----Tell terraform to use Az cli auth
provider "azurerm" {
  features {
  }
}
