#!/bin/bash

#Template Version: 2021010402

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "clean up resource group: $rg"

az group delete --name $rg --yes

echo "resource group deleted: $rg"
