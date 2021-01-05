#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

APPSERVICE="licenserenewal$RANDOM"

az appservice plan create \
	--resource-group $rg \
	--name vehicleAppServicePlan \
	--sku S1

az webapp create \
	--resource-group $rg \
	--name $APPSERVICE \
	--plan vehicleAppServicePlan \
	--deployment-source-url https://github.com/MicrosoftDocs/mslearn-load-balance-web-traffic-with-application-gateway \
	--deployment-source-branch appService --runtime "DOTNETCORE|2.1"

