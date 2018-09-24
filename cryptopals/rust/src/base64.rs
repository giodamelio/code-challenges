fn int_to_char(index: u8, zeros_are_padding: bool) -> char {
    let alphabet: Vec<_> = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        .chars()
        .collect();

    if index == 0 && zeros_are_padding {
        '='
    } else {
        alphabet[index as usize]
    }
}

fn zero_first_two_bits(input: u8) -> u8 {
    input & 0b0011_1111
}

fn process_chunk(input: u32, zeros_are_padding: bool) -> String {
    let mut output = String::new();

    output.push(int_to_char(
        zero_first_two_bits((input >> 18) as u8),
        zeros_are_padding,
    ));
    output.push(int_to_char(
        zero_first_two_bits((input >> 12) as u8),
        zeros_are_padding,
    ));
    output.push(int_to_char(
        zero_first_two_bits((input >> 6) as u8),
        zeros_are_padding,
    ));
    output.push(int_to_char(
        zero_first_two_bits(input as u8),
        zeros_are_padding,
    ));

    output
}

pub fn encode(input: &[u8]) -> String {
    let mut output = String::new();

    // Loop over chunks of 3 chars and convert them to base64
    let chunks = input.exact_chunks(3);
    let mut remainder = chunks.remainder().to_vec();
    for chunk in chunks {
        let combined =
            (u32::from(chunk[0]) << 16) | (u32::from(chunk[1]) << 8) | u32::from(chunk[2]);
        output.push_str(&process_chunk(combined, false));
    }

    // Pad the remaining bytes to make them length 3 and process those bytes
    let pad_length = (3 - remainder.len() % 3) % 3;
    if pad_length > 0 {
        remainder.append(&mut vec![0; pad_length]);
        output.push_str(&process_chunk(
            (u32::from(remainder[0]) << 16)
                | (u32::from(remainder[1]) << 8)
                | u32::from(remainder[2]),
            true,
        ));
    }

    output
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    // All of length evenly divisible by 3
    fn simple_bytes() {
        // "Man"
        assert_eq!(encode(&[0, 0, 0]), "AAAA");
        assert_eq!(encode(&[255, 255, 255]), "////");

        // "Man"
        assert_eq!(encode(&[77, 97, 110]), "TWFu");

        // "Hello World!"
        assert_eq!(
            encode(&[72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]),
            "SGVsbG8gV29ybGQh"
        );
    }

    #[test]
    fn padded_end() {
        // "AA"
        assert_eq!(encode(&[65, 65]), "QUE=");

        // "A"
        assert_eq!(encode(&[65]), "QQ==");
    }
}
