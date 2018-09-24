use std::error;
use std::fmt;

#[derive(Debug, Clone, PartialEq)]
pub enum HexToBytesError {
    InvalidChar(char),
    InvalidLength
}

impl fmt::Display for HexToBytesError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            HexToBytesError::InvalidChar(c) => write!(f, "'{}' is not a valid hex character", c),
            HexToBytesError::InvalidLength => write!(f, "input must be one or more pairs of hex chars")
        }
    }
}

impl error::Error for HexToBytesError {
    fn description(&self) -> &str {
        match *self {
            HexToBytesError::InvalidChar(_c) => "not a valid hex char",
            HexToBytesError::InvalidLength =>  "input must be one or more pairs of hex chars"
        }
    }

    fn cause(&self) -> Option<&error::Error> {
        None
    }
}

pub fn string_to_bytes(input: &str) -> Result<Vec<u8>, HexToBytesError> {
    let bytes: Vec<_> = input.chars().collect();

    if bytes.len() % 2 != 0 || bytes.len() < 2 {
        return Err(HexToBytesError::InvalidLength);
    }

    bytes.exact_chunks(2).map(|chunk| {
        let chunk0 = chunk[0].to_digit(16).ok_or(HexToBytesError::InvalidChar(chunk[0]))?;
        let chunk1 = chunk[1].to_digit(16).ok_or(HexToBytesError::InvalidChar(chunk[1]))?;
        Ok(((chunk0 << 4) | chunk1) as u8)
    }).collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn simple_hex() {
        assert_eq!(string_to_bytes("FFFF").unwrap(), &[255, 255]);
        assert_eq!(string_to_bytes("0000").unwrap(), &[0, 0]);
    }

    #[test]
    fn invalid_hex() {
        assert_eq!(string_to_bytes("ZZZZ").unwrap_err(), HexToBytesError::InvalidChar('Z'))
    }

    #[test]
    fn not_in_pairs() {
        assert_eq!(string_to_bytes("F").unwrap_err(), HexToBytesError::InvalidLength);
        assert_eq!(string_to_bytes("FFF").unwrap_err(), HexToBytesError::InvalidLength);
        assert_eq!(string_to_bytes("").unwrap_err(), HexToBytesError::InvalidLength);
    }
}
