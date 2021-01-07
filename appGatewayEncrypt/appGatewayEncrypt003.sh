#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

privateip="$(az vm list-ip-addresses \
  --resource-group $rg \
  --name webservervm1 \
  --query "[0].virtualMachine.network.privateIpAddresses[0]" \
  --output tsv)"

az network application-gateway address-pool create \
  --resource-group $rg \
  --gateway-name gw-shipping \
  --name ap-backend \
  --servers $privateip

az network application-gateway root-cert create \
  --resource-group $rg \
  --gateway-name gw-shipping \
  --name shipping-root-cert \
  --cert-file shippingportal/server-config/shipping-ssl.crt

az network application-gateway http-settings create \
  --resource-group $rg \
  --gateway-name gw-shipping \
  --name https-settings \
  --port 443 \
  --protocol Https \
  --host-name $privateip

az network application-gateway http-settings create \
  --resource-group $rg \
  --gateway-name gw-shipping \
  --name https-settings \
  --port 443 \
  --protocol Https \
  --host-name $privateip

export rgID="$(az group show --name $rg --query id --output tsv)"

az network application-gateway http-settings update \
    --resource-group $rg \
    --gateway-name gw-shipping \
    --name https-settings \
    --set trustedRootCertificates='[{"id": "'$rgID'/providers/Microsoft.Network/applicationGateways/gw-shipping/trustedRootCertificates/shipping-root-cert"}]'



