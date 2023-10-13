#--------
# Locals 
#--------
locals {
  common_tags = {
    Environment     = var.environment
    ProjectName     = var.project_name
  }
}
