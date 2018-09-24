#![feature(exact_chunks)]

mod base64;
mod hex;
mod utils;

fn main() {
    let bytes = hex::string_to_bytes("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d");
    println!("{:?}", bytes);

    println!("{}", base64::encode(vec![77, 97, 110]));
}
