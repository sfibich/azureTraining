#!/bin/bash

rg=trainTrafficManager

az group create --name $rg --location eastus2

az network traffic-manager profile create \
    --resource-group $rg  \
    --name TM-MusicStream-Priority \
    --routing-method Priority \
    --unique-dns-name TM-MusicStream-Priority-$RANDOM

az deployment group create \
    --resource-group $rg  \
    --template-uri  https://raw.githubusercontent.com/MicrosoftDocs/mslearn-distribute-load-with-traffic-manager/master/azuredeploy.json \
    --parameters password="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)"


