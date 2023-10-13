# interview_cloud_services

## Prerequisites

1. Install [az cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux) and [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) on your developement machine.

2. Login `az cli` and run below command to setup a service principal for terraform authentication to azure.

```bash
subscription="aaaaaaaa-bbbb-bbbb-bbbb-bbbbbbbbbbbbbbbb"
az ad sp create-for-rbac -n "tfuser" --role contributor --scopes /subscriptions/$subscription
```

3. 