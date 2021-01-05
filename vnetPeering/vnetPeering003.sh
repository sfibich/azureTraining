#!/bin/bash

rg=trainNetwork

watch -d -n 5 "az vm list \
    --resource-group $rg \
    --show-details \
    --query '[*].{Name:name, ProvisioningState:provisioningState, PowerState:powerState}' \
    --output table"

