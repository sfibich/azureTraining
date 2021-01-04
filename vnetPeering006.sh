#!/bin/bash

rg=trainNetwork

az vm list \
    --resource-group $rg \
    --query "[*].{Name:name, PrivateIP:privateIps, PublicIP:publicIps}" \
    --show-details \
    --output table


