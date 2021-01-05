#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network vnet subnet create \
  --resource-group $rg \
  --vnet-name vehicleAppVnet  \
  --name appGatewaySubnet \
  --address-prefixes 10.0.0.0/24

az network public-ip create \
  --resource-group $rg \
  --name appGatewayPublicIp \
  --sku Standard \
  --dns-name vehicleapp${RANDOM}


az network application-gateway create \
	--resource-group $rg \
	--name vehicleAppGateway \
	--sku WAF_v2 \
	--capacity 2 \
	--vnet-name vehicleAppVnet \
	--subnet appGatewaySubnet \
	--public-ip-address appGatewayPublicIp \
	--http-settings-protocol Http \
	--http-settings-port 8080 \
	--private-ip-address 10.0.0.4 \
	--frontend-port 8080

