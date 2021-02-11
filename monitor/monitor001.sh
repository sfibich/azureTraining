#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az vm create \
    --resource-group $rg \
    --name vm1 \
    --image UbuntuLTS \
    --custom-data cloud-init.txt \
    --generate-ssh-keys
