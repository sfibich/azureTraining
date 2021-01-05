#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network vnet subnet update \
    --name publicsubnet \
    --vnet-name vnet \
    --resource-group $rg \
    --route-table publictable

az vm create \
    --resource-group $rg \
    --name nva \
    --vnet-name vnet \
    --subnet dmzsubnet \
    --image UbuntuLTS \
    --admin-username azureuser \
    --admin-password $pw

NICID=$(az vm nic list \
    --resource-group $rg \
    --vm-name nva \
    --query "[].{id:id}" --output tsv)

echo $NICID
NICNAME=$(az vm nic show \
    --resource-group $rg \
    --vm-name nva \
    --nic $NICID \
    --query "{name:name}" --output tsv)

echo $NICNAME

az network nic update --name $NICNAME \
    --resource-group $rg \
    --ip-forwarding true

NVAIP="$(az vm list-ip-addresses \
    --resource-group $rg \
    --name nva \
    --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    --output tsv)"

echo $NVAIP


ssh -t -o StrictHostKeyChecking=no azureuser@$NVAIP 'sudo sysctl -w net.ipv4.ip_forward=1; exit;'
