#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"



az network traffic-manager profile create \
    --resource-group $rg \
    --name TM-MusicStream-Performance \
    --routing-method Performance \
    --unique-dns-name TM-MusicStream-Performance-$RANDOM \
    --output table

WestId=$(az network public-ip show \
    --resource-group $rg  \
    --name westus2-vm-nic-pip \
    --query id \
    --out tsv)

az network traffic-manager endpoint create \
    --resource-group $rg \
    --profile-name TM-MusicStream-Performance \
    --name "WestUS" \
    --type azureEndpoints \
    --target-resource-id $WestId

EastId=$(az network public-ip show \
    --resource-group $rg \
    --name eastasia-vm-nic-pip \
    --query id \
    --out tsv)

az network traffic-manager endpoint create \
    --resource-group $rg \
    --profile-name TM-MusicStream-Performance \
    --name "EastAsia" \
    --type azureEndpoints \
    --target-resource-id $EastId

echo http://$(az network traffic-manager profile show \
    --resource-group $rg \
    --name TM-MusicStream-Performance \
    --query dnsConfig.fqdn \
    --output tsv)


nslookup $(az network traffic-manager profile show \
        --resource-group $rg \
        --name TM-MusicStream-Performance \
        --query dnsConfig.fqdn \
        --output tsv)
