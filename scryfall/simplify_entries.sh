#!/bin/bash

#cd into script directory
cd "$(dirname "$0")"

DEPS=(jq)

#Dependency check
if ! ./depscheck.sh ${DEPS[@]}; then 
    echo "[$0]: Please install required dependencies."; exit 1 
fi

CARDS="cards.json" 
OUT="simplified.json"

if [ ! -f cards.json ]; then
    echo "[$0]: No $CARDS file found. Was fetch_all_english_cards.sh run?"; exit 1
fi

FIELDS=(name mana_cost cmc type_line oracle_text power toughness colors\
        color_identity keywords set set_name set_type rarity)

jq "[ .[] | { \
    $(for i in ${FIELDS[@]}; do printf "%s: .%s, " $i $i; done)\
    } ]" $CARDS > $OUT
