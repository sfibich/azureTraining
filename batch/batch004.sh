#!/bin/bash

#Template Version: 2021010501

#Load variables from root config
. ../variables.config

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az batch task file list \
 --job-id myjob2 \
 --task-id mytask5 \
 --output table

mkdir taskoutputs && cd taskoutputs

for i in {1..10}
do
az batch task file download \
    --job-id myjob2 \
    --task-id mytask$i \
    --file-path stdout.txt \
    --destination ./stdout$i.txt
done

cat stdout1.txt && cat stdout2.txt

az batch job delete --job-id myjob2 -y

