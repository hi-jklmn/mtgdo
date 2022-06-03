.PHONY: all run clean

all: run

run: args scryfall/simplified.json
	cargo run --release -- $(shell cat ./args)

clean:
	rm -vf scryfall/*.json
	cargo clean

args:
	read -p "Arguments: " ARGS; echo $$ARGS > args
	@echo "[make]: Default arguments are now found in file 'args'."
	@echo "[make]: Edit this file to change arguments for target 'run'"

scryfall/cards.json:
	./scryfall/fetch_all_english_cards.sh

scryfall/simplified.json: scryfall/cards.json
	./scryfall/simplify_entries.sh
