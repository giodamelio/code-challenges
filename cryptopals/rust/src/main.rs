#![feature(exact_chunks)]

use std::error;
use std::fmt;

#[derive(Debug, Clone, PartialEq)]
struct InvalidHexCharError;

impl fmt::Display for InvalidHexCharError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "not a valid hex character")
    }
}

impl error::Error for InvalidHexCharError {
    fn description(&self) -> &str {
        "not a valid hex char"
    }

    fn cause(&self) -> Option<&error::Error> {
        None
    }
}

fn hex_string_to_bytes(input: &str) -> Result<Vec<u8>, InvalidHexCharError> {
    let bytes: Vec<_> = input.chars().collect();

    bytes.exact_chunks(2).map(|chunk| {
        let chunk0 = chunk[0].to_digit(16).ok_or(InvalidHexCharError)?;
        let chunk1 = chunk[1].to_digit(16).ok_or(InvalidHexCharError)?;
        Ok(((chunk0 << 4) | chunk1) as u8)
    }).collect()
}

fn main() {
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn simple_hex() {
        assert_eq!(hex_string_to_bytes("FFFF").unwrap(), &[255, 255]);
        assert_eq!(hex_string_to_bytes("0000").unwrap(), &[0, 0]);
    }

    #[test]
    fn invalid_hex() {
        assert_eq!(hex_string_to_bytes("ZZZZ").unwrap_err(), InvalidHexCharError)
    }
}
