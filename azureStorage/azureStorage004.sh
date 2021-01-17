#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

wget https://github.com/MicrosoftDocs/mslearn-connect-app-to-azure-storage/blob/main/images/docs-and-friends-selfie-stick.png?raw=true -O docs-and-friends-selfie-stick.png


