#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

PUBLICIP="$(az vm list-ip-addresses \
    --resource-group $rg \
    --name public \
    --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    --output tsv)"

echo "Public IP: $PUBLICIP"

PRIVATEIP="$(az vm list-ip-addresses \
    --resource-group $rg \
    --name private \
    --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    --output tsv)"

echo "Private IP: $PRIVATEIP"

echo "Run the following:"
echo "ssh -t -o StrictHostKeyChecking=no azureuser@$PUBLICIP 'traceroute private --type=icmp; exit'"


echo "Run the following:"
echo "ssh -t -o StrictHostKeyChecking=no azureuser@$PRIVATEIP 'traceroute public --type=icmp; exit'"
