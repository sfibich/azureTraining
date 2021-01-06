#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network vnet create \
		--resource-group $rg \
		--name CoreServicesVnet \
		--address-prefix 10.20.0.0/16 \
		--location westus

az network vnet subnet create \
		--resource-group $rg \
		--vnet-name CoreServicesVnet \
		--name GatewaySubnet \
		--address-prefixes 10.20.0.0/27

az network vnet subnet create \
	    --resource-group $rg \
	    --vnet-name CoreServicesVnet \
	    --name SharedServicesSubnet \
	    --address-prefixes 10.20.10.0/24

az network vnet subnet create \
	    --resource-group $rg \
	    --vnet-name CoreServicesVnet \
	    --name DatabaseSubnet \
	    --address-prefixes 10.20.20.0/24

az network vnet subnet create \
	    --resource-group $rg \
	    --vnet-name CoreServicesVnet \
	    --name PublicWebServiceSubnet \
	    --address-prefixes 10.20.30.0/24

az network vnet subnet list \
	    --resource-group $rg \
	    --vnet-name CoreServicesVnet \
	    --output table



