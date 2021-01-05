#!/bin/bash

rg=trainNetwork

az network nic show-effective-route-table \
    --resource-group $rg \
    --name SalesVMVMNic \
    --output table

az network nic show-effective-route-table \
    --resource-group $rg \
    --name MarketingVMVMNic \
    --output table

az network nic show-effective-route-table \
    --resource-group $rg \
    --name ResearchVMVMNic \
    --output table

