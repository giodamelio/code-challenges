#![feature(exact_chunks)]

fn hex_string_to_bytes(input: &str) -> Vec<u8> {
    let bytes: Vec<_> = input.chars().collect();

    bytes.exact_chunks(2).map(|chunk| {
        let chunk0 = chunk[0].to_digit(16).unwrap();
        let chunk1 = chunk[1].to_digit(16).unwrap();
        ((chunk0 << 4) | chunk1) as u8
    }).collect()
}

fn main() {
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn simple_hex() {
        assert_eq!(hex_string_to_bytes("FFFF"), &[255, 255]);
        assert_eq!(hex_string_to_bytes("0000"), &[0, 0]);
    }
}
