#!/bin/bash

set -xe

# Dependencies: {
#       jq 
# }

URL=$(curl -s https://api.scryfall.com/bulk-data/default_cards | jq -r .download_uri)

curl $URL > cards.json


