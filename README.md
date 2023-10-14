# interview_cloud_services

## Prerequisites

1. Install [az cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux) and [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) on your developement machine

2. Login `az cli` and run below command to setup a service principal for terraform authentication to azure

```bash
subscription="aaaaaaaa-bbbb-bbbb-bbbb-bbbbbbbbbbbbbbbb"
az ad sp create-for-rbac -n "tfuser" --role contributor --scopes /subscriptions/$subscription
```

3. Set your environment variables using the values from output of the step 2

```bash
export ARM_CLIENT_ID="xxx-xxx-xxx-xxx"
export ARM_CLIENT_SECRET="xxx-xxx-xxx-xxx"
export ARM_SUBSCRIPTION_ID="xxx-xxx-xxx-xxx"
export ARM_TENANT_ID="xxx-xxx-xxx-xxx"
```

4. Setup a terraform backend to store the terraform state file

```bash
resource_group_name="TerraformStateRG"
location="westeurope"
storage_account_name="tfstate1395347666"
container_name="tfstate"

# create Azure resource group
az group create --name $resource_group_name \
  --location $location --verbose

# create Azure storage account
az storage account create --name $storage_account_name \
  --location $location \
  --resource-group $resource_group_name \
  --verbose

# create Container in Azure storage account
az storage container create --account-name $storage_account_name \
  --name $container_name \
  --public-access off \
  --verbose
```

## Managing Azure resources via `terraform`

* Below commands will manage the lifecycle of Azure resources via terraform

```bash
# Install required providers and configure terraform backend
terraform init

# Terraform will plan the deployments and show in advance (for confirmation)
terraform plan

# Deploy the resources i.e. apply the plan
terraform apply #-auto-approve 

# Destroy the resources
terraform destroy #-auto-approve
```
