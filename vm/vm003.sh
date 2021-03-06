#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az vm create \
    --resource-group $rg \
    --name SampleVM2 \
    --image UbuntuLTS \
    --admin-username azureuser \
    --generate-ssh-keys \
    --verbose \
    --size "Standard_DS2_v2"


az vm list-vm-resize-options \
    --resource-group $rg \
    --name SampleVM \
    --output table

az vm resize \
    --resource-group $rg \
    --name SampleVM \
    --size Standard_D2s_v3

