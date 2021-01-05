#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

urlAddress=http://$(az network public-ip show \
  --resource-group $rg \
  --name appGatewayPublicIp \
  --query dnsSettings.fqdn \
  --output tsv)

echo "Server Name for: $urlAddress"
curl $urlAddress --silent | grep Server

az vm deallocate \
	--resource-group $rg \
	--name webServer1

echo "Server Name for: $urlAddress"
curl $urlAddress --silent | grep Server

az vm start \
	--resource-group $rg \
	--name webServer1

az vm deallocate \
	--resoruce-group $rg \
	--name webServer2

echo "Server Name for: $urlAddress"
curl $urlAddress --silent | grep Server

az vm start \
	--resource-group $rg \
	--name webServer2

echo "Server Name for: $urlAddress/LicenseRenewal/Create"
curl $urlAddress/LicenseRenewal/Create --silent | grep Server

