#![feature(exact_chunks)]

mod hex;

fn main() {
    println!("{:?}", hex::string_to_bytes("FFFF"));
}
