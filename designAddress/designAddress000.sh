#!/bin/bash

#Template Version: 2021010403

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "creating resource group: $rg"

az group create --name $rg --location eastus2

