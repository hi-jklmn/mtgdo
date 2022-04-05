use std::{env, fs};

// Parse arguments to return a list ostensibly filled with card names
fn parse_args(mut args: Vec<String>) -> Option<Vec<String>> {
    return if args.len() > 1 {
        args.remove(0);
        Some(args)
    } else {
        None
    }
}

fn main() {
    // Let's start with a simple "look up card text" program
    let mut cards = parse_args(env::args().collect())
        .expect("Usage: ./mtgdo cardname1 [cardname2] ...");

    let all_card_infos = json::parse(&fs::read_to_string("./scryfall/cards.json")
        .expect(
            "Error reading cards.json, did you run \
            ./scryfall/fetch_all_english_cards.sh?",
        ))
        .expect("Error parsing cards.json");

    let mut v = vec!();

    println!("{:?}", cards);

    for card_info in all_card_infos.members() {
        let card_name = card_info["name"].as_str()
            .expect("Missing card name");
        if cards.contains(&card_name.to_string()) {
            v.push(card_info.clone());
        }
        cards.retain(|x| *x != card_name);
    }

    for el in v {
        println!("Name:         {}", el["name"]);
        println!("Mana Cost:    {}", el["mana_cost"]);
        println!("Text:         {}", el["oracle_text"]);
        if !el["power"].is_null() {
            println!("Power:        {}", el["power"]);
            println!("Toughness:    {}", el["toughness"]);
        }
    }
}
