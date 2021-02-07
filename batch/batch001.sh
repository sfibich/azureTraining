#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

RESOURCE_GROUP=$rg
BATCH_ACCOUNT=batchaccount$RANDOM

az batch account create \
 --name $BATCH_ACCOUNT \
 --resource-group $RESOURCE_GROUP \
 --location eastus2

az batch account login \
 --name $BATCH_ACCOUNT \
 --resource-group $RESOURCE_GROUP \
 --shared-key-auth


az batch pool create \
 --id mypool --vm-size Standard_A1_v2 \
 --target-dedicated-nodes 3 \
 --image canonical:ubuntuserver:16.04-LTS \
 --node-agent-sku-id "batch.node.ubuntu 16.04"



#Run the following command to periodically determine whether the nodes are ready:
az batch pool show --pool-id mypool \
 --query "allocationState"

