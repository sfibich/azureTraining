#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network vnet create \
	    --resource-group $rg \
	    --name ResearchVnet \
	    --address-prefix 10.40.40.0/24 \
	    --location westindia

az network vnet subnet create \
	    --resource-group $rg \
	    --vnet-name ResearchVnet \
	    --name ResearchSystemSubnet \
	    --address-prefixes 10.40.40.0/24

az network vnet subnet list \
	    --resource-group $rg \
	    --vnet-name ResearchVnet \
	    --output table

