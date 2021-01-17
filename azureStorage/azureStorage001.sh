#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az storage account create \
    --name photosharingappsf077 \
    --resource-group $rg \
    --location eastus \
    --sku Standard_LRS \

dotnet new console --name PhotoSharingApp
cd PhotoSharingApp
dotnet add package Azure.Storage.Blobs
dotnet run




