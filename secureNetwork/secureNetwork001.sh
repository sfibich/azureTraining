#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

# Create Linux VM w/Nginx
az vm create \
  --resource-group $rg \
  --name my-vm \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys

az vm extension set \
  --resource-group $rg \
  --vm-name my-vm \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.1 \
  --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' \
  --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'


# Below should Fail
# Get the IP and show the page
IPADDRESS="$(az vm list-ip-addresses \
  --resource-group $rg \
  --name my-vm \
  --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
  --output tsv)"

curl --connect-timeout 5 http://$IPADDRESS



#Show Information
echo $IPADDRESS
az network nsg list \
  --resource-group $rg \
  --query '[].name' \
  --output tsv


