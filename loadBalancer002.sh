#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network public-ip create \
  --resource-group $rg \
  --allocation-method Static \
  --name myPublicIP

az network lb create \
		--resource-group $rg \
		--name myLoadBalancer \
		--public-ip-address myPublicIP \
		--frontend-ip-name myFrontEndPool \
		--backend-pool-name myBackEndPool

az network lb probe create \
		--resource-group $rg \
		--lb-name myLoadBalancer \
		--name myHealthProbe \
		--protocol tcp \
		--port 80

az network lb rule create \
		--resource-group $rg \
		--lb-name myLoadBalancer \
		--name myHTTPRule \
		--protocol tcp \
		--frontend-port 80 \
		--backend-port 80 \
		--frontend-ip-name myFrontEndPool \
		--backend-pool-name myBackEndPool \
		--probe-name myHealthProbe

az network nic ip-config update \
		--resource-group $rg \
		--nic-name webNic1 \
		--name ipconfig1 \
		--lb-name myLoadBalancer \
		--lb-address-pools myBackEndPool

az network nic ip-config update \
		--resource-group $rg \
		--nic-name webNic2 \
		--name ipconfig1 \
		--lb-name myLoadBalancer \
		--lb-address-pools myBackEndPool

echo http://$(az network public-ip show \
                --resource-group $rg \
                --name myPublicIP \
                --query ipAddress \
                --output tsv)

