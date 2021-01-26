#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)
stacct=$(az storage account list --query "[?contains(@.name, 'learnazurefileshare')==\`true\`].name" --output tsv)


echo "resource group: $rg"
echo "storage account: $stacct"


az storage account update \
    --resource-group $rg \
    --name $stacct \
    --https-only true


