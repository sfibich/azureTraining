#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

ip1=$(az vm list-ip-addresses \
  --resource-group $rg \
  --name webServer1 \
  --query [0].virtualMachine.network.privateIpAddresses[0] \
  --output tsv)

ip2=$(az vm list-ip-addresses \
  --resource-group $rg \
  --name webserver2 \
  --query [0].virtualMachine.network.privateIpAddresses[0] \
  --output tsv)

az network application-gateway address-pool create \
  --gateway-name vehicleAppGateway \
  --resource-group $rg \
  --name vmPool \
  --servers $ip1 $ip2

appName=$(az webapp list --resource-group $rg --query [0].name --output tsv)

az network application-gateway address-pool create \
    --resource-group $rg \
    --gateway-name vehicleAppGateway \
    --name appServicePool \
    --servers $appName.azurewebsites.net

az network application-gateway frontend-port create \
    --resource-group $rg \
    --gateway-name vehicleAppGateway \
    --name port80 \
    --port 80

az network application-gateway http-listener create \
    --resource-group $rg \
    --name vehicleListener \
    --frontend-port port80 \
    --frontend-ip appGatewayFrontendIP \
    --gateway-name vehicleAppGateway


