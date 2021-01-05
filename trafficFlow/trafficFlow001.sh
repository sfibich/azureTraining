#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network route-table create \
	--name publictable \
	--resource-group $rg \
	--disable-bgp-route-propagation false

az network route-table route create \
	--route-table-name publictable \
	--resource-group $rg \
	--name productionsubnet \
	--address-prefix 10.0.1.0/24 \
	--next-hop-type VirtualAppliance \
	--next-hop-ip-address 10.0.2.4

az network vnet create \
	--name vnet \
	--resource-group $rg \
	--address-prefix 10.0.0.0/16 \
	--subnet-name publicsubnet \
	--subnet-prefix 10.0.0.0/24

az network vnet subnet create \
	--name privatesubnet \
	--vnet-name vnet \
	--resource-group $rg \
	--address-prefix 10.0.1.0/24

az network vnet subnet create \
    --name dmzsubnet \
    --vnet-name vnet \
    --resource-group $rg \
    --address-prefix 10.0.2.0/24

az network vnet subnet list \
    --resource-group $rg \
    --vnet-name vnet \
    --output table

