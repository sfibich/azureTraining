#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

git clone https://github.com/MicrosoftDocs/mslearn-end-to-end-encryption-with-app-gateway shippingportal

cd shippingportal

sed -i "s/\$rgName/$rg/g" setup-infra.sh

bash setup-infra.sh

echo https://"$(az vm show \
  --name webservervm1 \
  --resource-group $rg \
  --show-details \
  --query [publicIps] \
  --output tsv)"


