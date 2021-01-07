#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network vnet create \
	--resource-group  $rg \
	--name vehicleAppVnet \
	--address-prefix 10.0.0.0/16 \
	--subnet-name webServerSubnet \
	--subnet-prefix 10.0.1.0/24

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

az network application-gateway auth-cert create \
    --resource-group $rg \
    --gateway-name vehicleAppGateway \
    --name P2SRootCert.cer \
    --cert-file ~/P2SRootCert.cer

