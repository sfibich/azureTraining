#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az network application-gateway frontend-port create \
    --resource-group <resource group name> \
    --gateway-name <application gateway name>  \
    --name <port name>
    --port 443



