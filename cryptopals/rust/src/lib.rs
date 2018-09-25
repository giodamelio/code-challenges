#![feature(exact_chunks)]

pub mod base64;
pub mod bitops;
pub mod hex;
pub mod utils;

#[cfg(test)]
mod set1 {
    use super::*;

    #[test]
    fn challenge1() {
        let input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";
        let bytes = hex::decode(input).expect("Failed to parse hex input");

        assert_eq!(
            base64::encode(&bytes),
            "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
        );
    }

    #[test]
    fn challenge2() {
        let input1 = "1c0111001f010100061a024b53535009181c";
        let input2 = "686974207468652062756c6c277320657965";
        let bytes1 = hex::decode(input1).expect("Failed to parse hex input 1");
        let bytes2 = hex::decode(input2).expect("Failed to parse hex input 2");

        assert_eq!(
            hex::encode(&bitops::slice_xor_slice(&bytes1, &bytes2)),
            "746865206B696420646F6E277420706C6179"
        );
    }
}
