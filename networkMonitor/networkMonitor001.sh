#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network vnet create \
    --resource-group $rg \
    --name MyVNet1 \
    --address-prefix 10.10.0.0/16 \
    --subnet-name FrontendSubnet \
    --subnet-prefix 10.10.1.0/24

az network vnet subnet create \
    --address-prefixes 10.10.2.0/24 \
    --name BackendSubnet \
    --resource-group $rg \
    --vnet-name MyVNet1

az vm create \
    --resource-group $rg \
    --name FrontendVM \
    --vnet-name MyVNet1 \
    --subnet FrontendSubnet \
    --image Win2019Datacenter \
    --admin-username azureuser \
    --admin-password $pw 

az vm extension set \
    --publisher Microsoft.Compute \
    --name CustomScriptExtension \
    --vm-name FrontendVM \
    --resource-group $rg \
    --settings '{"commandToExecute":"powershell.exe Install-WindowsFeature -Name Web-Server"}' \
    --no-wait

az vm create \
    --resource-group $rg \
    --name BackendVM \
    --vnet-name MyVNet1 \
    --subnet BackendSubnet \
    --image Win2019Datacenter \
    --admin-username azureuser \
    --admin-password $pw

az vm extension set \
    --publisher Microsoft.Compute \
    --name CustomScriptExtension \
    --vm-name BackendVM \
    --resource-group $rg \
    --settings '{"commandToExecute":"powershell.exe Install-WindowsFeature -Name Web-Server"}' \
    --no-wait

az network nsg create \
    --name MyNsg \
    --resource-group $rg

az network nsg rule create \
    --resource-group $rg \
    --name MyNSGRule \
    --nsg-name MyNsg \
    --priority 4096 \
    --source-address-prefixes '*' \
    --source-port-ranges '*' \
    --destination-address-prefixes '*' \
    --destination-port-ranges 80 443 3389 \
    --access Deny \
    --protocol TCP \
    --direction Inbound \
    --description "Deny from specific IP address ranges on 80, 443 and 3389."

az network vnet subnet update \
    --resource-group $rg \
    --name BackendSubnet \
    --vnet-name MyVNet1 \
    --network-security-group MyNsg

az network watcher configure \
--locations eastus2 \
--enabled true \
--resource-group $rg

