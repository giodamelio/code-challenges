#![feature(exact_chunks)]

fn hex_string_to_bytes(input: &str) -> Vec<u8> {
    let mut decoded_bytes = Vec::new();

    let bytes: Vec<_> = input.chars().collect();

    for chunk in bytes.exact_chunks(2) {
        let chunk0 = chunk[0].to_digit(16).unwrap();
        let chunk1 = chunk[1].to_digit(16).unwrap();
        let byte = ((chunk0 << 4) | chunk1) as u8;
        decoded_bytes.push(byte);
    }

    decoded_bytes
}

fn main() {
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn simple_hex() {
        assert_eq!(hex_string_to_bytes("FFFF"), &[255, 255]);
    }
}
