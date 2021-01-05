#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az vm create \
    --resource-group $rg \
    --name public \
    --vnet-name vnet \
    --subnet publicsubnet \
    --image UbuntuLTS \
    --admin-username azureuser \
    --no-wait \
    --custom-data cloud-init.txt \
    --admin-password $pw

az vm create \
    --resource-group $rg \
    --name private \
    --vnet-name vnet \
    --subnet privatesubnet \
    --image UbuntuLTS \
    --admin-username azureuser \
    --custom-data cloud-init.txt \
    --admin-password $pw

az vm list \
    --resource-group $rg \
    --show-details \
    --query '[*].{Name:name, ProvisioningState:provisioningState, PowerState:powerState}' \
    --output table

