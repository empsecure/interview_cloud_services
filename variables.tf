#----------
# variables
#----------
variable "location" {
  type        = string
  description = "Azure region to deploy all resources"
  default     = "westeurope"
  validation {
    condition     = var.location == "westeurope" || var.location == "northeurope"
    error_message = "Accepted locations are West Europe and North Europe only."
  }
}

variable resource_group_name {
    type = string
    description = "resource group to deploy Azure sql server and dbs"
    default = "emps-int-we-rg-01"
}

# Tags
variable environment {
  default = "D"
}
variable project_name {
    default = "Interview Assessment"
}
