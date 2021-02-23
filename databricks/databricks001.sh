#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

location="eastus2"
rgName="databricks"
dbName="databricks123"

az group create --name $rgName --location $location

az databricks workspace create --resource-group $rgName \
	--name $dbName \
	--location $location \
	--sku standard
