#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

#Get NSG Info
az network nsg list \
  --resource-group  $rg \
  --query '[].name' \
  --output tsv


az network nsg rule list \
  --resource-group $rg \
  --nsg-name my-vmNSG


az network nsg rule list \
  --resource-group $rg \
  --nsg-name my-vmNSG \
  --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' \
  --output table




