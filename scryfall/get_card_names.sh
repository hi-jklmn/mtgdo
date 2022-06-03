#!/bin/bash

#cd into script directory
cd "$(dirname "$0")"

DEPS=(jq)

#Dependency check
if ! ./depscheck.sh ${DEPS[@]}; then 
    echo "[$0]: Please install required dependencies."; exit 1 
fi

jq -r '.. | .name? | values' simplified.json | sort | uniq > cardnames.txt


