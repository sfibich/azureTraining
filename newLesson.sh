#!/bin/bash
project=$1

echo "Creating new project $project" 

mkdir $project
fileName="${project}000.sh"
cp templates/template000.sh $project/$fileName
fileName="${project}001.sh"
cp templates/template001.sh $project/$fileName
fileName="${project}999.sh"
cp templates/template999.sh $project/$fileName

tree $project
