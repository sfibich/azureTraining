#!/bin/bash

#Template Version: 2021010401

#Generic Password
pw=XyzAbc.12345

#Assumes SCRIPTNAME###.sh for the file name format
rg=$(basename -- "$0" | tr -d '0123456789' | cut -d '.' -f 1)

echo "resource group: $rg"

az group create --name $rg --location eastus2

git clone https://github.com/MicrosoftDocs/mslearn-improve-app-scalability-resiliency-with-load-balancer.git

cd mslearn-improve-app-scalability-resiliency-with-load-balancer
bash create-high-availability-vm-with-sets.sh $rg
cd ..

rm -r mslearn-improve-app-scalability-resiliency-with-load-balancer/ --force

