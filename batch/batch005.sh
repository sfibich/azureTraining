#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az batch job create \
 --id explorerjob \
 --pool-id mypool

for i in {1..100}
do
   az batch task create \
    --task-id mytask$i \
    --job-id explorerjob \
    --command-line "/bin/bash -c 'printenv; sleep 5s'"
done

