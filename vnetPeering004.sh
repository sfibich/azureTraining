#!/bin/bash

rg=trainNetwork

az network vnet peering create \
	--name SalesVnet-To-MarketingVNet \
	--remote-vnet MarketingVnet \
	--resource-group $rg \
	--vnet-name SalesVNet \
	--allow-vnet-access

az network vnet peering create \
	--name MarketingVNet-To-SalesVNet \
	--remote-vnet SalesVNet \
	--resource-group $rg \
	--vnet-name MarketingVNet \
	--allow-vnet-access

az network vnet peering create \
	--name MarketingVNet-To-ResearchVnet \
	--remote-vnet ResearchVNet \
	--resource-group $rg \
	--vnet-name MarketingVNet \
	--allow-vnet-access

az network vnet peering create \
    --name ResearchVNet-To-MarketingVNet \
    --remote-vnet MarketingVNet \
    --resource-group $rg \
    --vnet-name ResearchVNet \
    --allow-vnet-access

az network vnet peering list \
    --resource-group $rg \
    --vnet-name SalesVNet \
    --output table

az network vnet peering list \
    --resource-group $rg \
    --vnet-name ResearchVNet \
    --output table

az network vnet peering list \
    --resource-group $rg \
    --vnet-name MarketingVNet \
    --output table




