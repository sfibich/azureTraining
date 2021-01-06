#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network vnet create \
	    --resource-group $rg \
	    --name ManufacturingVnet \
	    --address-prefix 10.30.0.0/16 \
	    --location northeurope

az network vnet subnet create \
	    --resource-group $rg \
	    --vnet-name ManufacturingVnet \
	    --name ManufacturingSystemSubnet \
	    --address-prefixes 10.30.10.0/24

az network vnet subnet create \
	    --resource-group $rg \
	    --vnet-name ManufacturingVnet \
	    --name SensorSubnet1 \
	    --address-prefixes 10.30.20.0/24

az network vnet subnet create \
	    --resource-group $rg \
	    --vnet-name ManufacturingVnet \
	    --name SensorSubnet2 \
	    --address-prefixes 10.30.21.0/24

az network vnet subnet create \
		--resource-group $rg \
		--vnet-name ManufacturingVnet \
	    --name SensorSubnet3 \
	    --address-prefixes 10.30.22.0/24


az network vnet subnet list \
		--resource-group $rg \
		--vnet-name ManufacturingVnet \
		--output table
