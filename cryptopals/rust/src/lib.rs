#![feature(exact_chunks)]

pub mod base64;
pub mod hex;
pub mod utils;

#[cfg(test)]
mod set1 {
    use super::*;

    #[test]
    fn problem1() {
        let input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";
        let bytes = hex::decode(input).expect("Failed to parse hex input");
        assert_eq!(
            base64::encode(&bytes),
            "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
        );
    }
}
