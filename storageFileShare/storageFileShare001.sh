#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"





export STORAGEACCT=learnazurefileshare$RANDOM

az storage account create \
    --name $STORAGEACCT \
    --resource-group $rg \
    --sku Standard_GRS


STORAGEKEY=$(az storage account keys list \
    --resource-group $rg \
    --account-name $STORAGEACCT \
    --query "[0].value" | tr -d '"')

az storage share create \
    --account-name $STORAGEACCT \
    --account-key $STORAGEKEY \
    --name "reports"


az storage share create \
    --account-name $STORAGEACCT \
    --account-key $STORAGEKEY \
    --name "data"


