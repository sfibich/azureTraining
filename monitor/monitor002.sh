#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"



VMID=$(az vm show \
        --resource-group $rg \
        --name vm1 \
        --query id \
        --output tsv)

az monitor metrics alert create \
    -n "Cpu80PercentAlert" \
    --resource-group $rg \
    --scopes $VMID \
    --condition "max percentage CPU > 80" \
    --description "Virtual machine is running at or greater than 80% CPU utilization" \
    --evaluation-frequency 1m \
    --window-size 1m \
    --severity 3
