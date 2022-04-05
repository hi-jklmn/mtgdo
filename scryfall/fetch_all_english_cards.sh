#!/bin/bash

DEPS=(curl jq foo)

# Dependency check
if ! ./depscheck.sh ${DEPS[@]}; then
    echo "[$0]: Please install required dependencies."; exit 1
fi

URL=$(curl -s https://api.scryfall.com/bulk-data/default_cards | jq -r .download_uri)

curl $URL > cards.json


