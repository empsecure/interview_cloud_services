# Interview: Cloud Services

## Prerequisites

1. Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux) and [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) on your development machine.

2. Log in to Azure CLI and run the following command to set up a service principal for Terraform authentication to Azure:

```bash
subscription="aaaaaaaa-bbbb-bbbb-bbbb-bbbbbbbbbbbbbbbb"
az ad sp create-for-rbac -n "tfuser" --role contributor --scopes /subscriptions/$subscription
```

3. Set your environment variables using the values from the output of step 2:

```bash
export ARM_CLIENT_ID="xxx-xxx-xxx-xxx"
export ARM_CLIENT_SECRET="xxx-xxx-xxx-xxx"
export ARM_SUBSCRIPTION_ID="xxx-xxx-xxx-xxx"
export ARM_TENANT_ID="xxx-xxx-xxx-xxx"
```

4. Set up a Terraform backend to store the Terraform state file:

```bash
resource_group_name="TerraformStateRG"
location="westeurope"
storage_account_name="tfstate1395347666"
container_name="tfstate"

# Create Azure resource group
az group create --name $resource_group_name \
  --location $location --verbose

# Create Azure storage account
az storage account create --name $storage_account_name \
  --location $location \
  --resource-group $resource_group_name \
  --verbose

# Create Container in Azure storage account
az storage container create --account-name $storage_account_name \
  --name $container_name \
  --public-access off \
  --verbose
```

## Managing Azure Infrastructure via Terraform

* The subsequent commands are utilized to manage the lifecycle of Azure infrastructure through Terraform:

```bash
# Install the necessary providers, modules, and configure the Terraform backend
terraform init

# Terraform will plan the deployments and present them in advance (for confirmation)
terraform plan

# Deploy the resources, i.e., apply the plan
terraform apply #-auto-approve 

# Destroy the resources
terraform destroy #-auto-approve
```
* Sensitive strings in output can be retrieved using the following command:

```bash
# Example
terraform output -raw sql_server_admin_password
```