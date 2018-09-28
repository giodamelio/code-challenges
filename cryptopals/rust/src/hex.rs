use std::char;
use std::error;
use std::fmt;

#[derive(Debug, Clone, PartialEq)]
pub enum HexToBytesError {
    InvalidChar(char),
    InvalidLength,
}

impl fmt::Display for HexToBytesError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            HexToBytesError::InvalidChar(c) => write!(f, "'{}' is not a valid hex character", c),
            HexToBytesError::InvalidLength => {
                write!(f, "input must be one or more pairs of hex chars")
            }
        }
    }
}

impl error::Error for HexToBytesError {
    fn description(&self) -> &str {
        match *self {
            HexToBytesError::InvalidChar(_c) => "not a valid hex char",
            HexToBytesError::InvalidLength => "input must be one or more pairs of hex chars",
        }
    }

    fn cause(&self) -> Option<&error::Error> {
        None
    }
}

pub fn decode(input: &str) -> Result<Vec<u8>, HexToBytesError> {
    let bytes: Vec<_> = input.chars().collect();

    if bytes.len() % 2 != 0 || bytes.len() < 2 {
        return Err(HexToBytesError::InvalidLength);
    }

    bytes
        .chunks_exact(2)
        .map(|chunk| {
            let chunk0 = chunk[0]
                .to_digit(16)
                .ok_or_else(|| HexToBytesError::InvalidChar(chunk[0]))?;
            let chunk1 = chunk[1]
                .to_digit(16)
                .ok_or_else(|| HexToBytesError::InvalidChar(chunk[1]))?;
            Ok(((chunk0 << 4) | chunk1) as u8)
        })
        .collect()
}

pub fn encode(input: &[u8]) -> String {
    input
        .iter()
        .map(|digit| {
            vec![
                char::from_digit(u32::from((*digit >> 4) & 0b0000_1111), 16),
                char::from_digit(u32::from(*digit & 0b0000_1111), 16),
            ]
        })
        .flatten()
        // c will always be Some(char) since we can never have an input larget then one byte large
        .map(|c| c.unwrap())
        .collect::<String>()
        .to_uppercase()
}

#[cfg(test)]
mod tests {
    use super::*;

    mod decode {
        use super::*;

        #[test]
        fn simple_hex() {
            assert_eq!(decode("FFFF").unwrap(), &[255, 255]);
            assert_eq!(decode("0000").unwrap(), &[0, 0]);
        }

        #[test]
        fn invalid_hex() {
            assert_eq!(
                decode("ZZZZ").unwrap_err(),
                HexToBytesError::InvalidChar('Z')
            )
        }

        #[test]
        fn not_in_pairs() {
            assert_eq!(decode("F").unwrap_err(), HexToBytesError::InvalidLength);
            assert_eq!(decode("FFF").unwrap_err(), HexToBytesError::InvalidLength);
            assert_eq!(decode("").unwrap_err(), HexToBytesError::InvalidLength);
        }
    }

    mod encode {
        use super::*;

        #[test]
        fn simple_hex() {
            assert_eq!(
                encode(&[255, 127, 63, 31, 15, 7, 3, 1, 0]),
                "FF7F3F1F0F07030100"
            );
            assert_eq!(encode(&[10, 23]), "0A17");
        }
    }
}
