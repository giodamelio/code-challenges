#![feature(exact_chunks)]

mod base64;
mod hex;
mod utils;

fn main() {
    let input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";
    let bytes = hex::string_to_bytes(input).expect("Failed to parse hex input");
    println!("{}", base64::encode(&bytes));
}
