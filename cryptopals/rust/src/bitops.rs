pub fn slice_xor_slice(input_left: &[u8], input_right: &[u8]) -> Vec<u8> {
    assert!(
        input_left.len() == input_right.len(),
        "left and right arrays must be the same length"
    );

    input_left
        .iter()
        .zip(input_right)
        .map(|(left, right)| left ^ right)
        .collect()
}

pub fn slice_xor_u8(input_left: &[u8], right: u8) -> Vec<u8> {
    input_left.iter().map(|digit| digit ^ right).collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    mod slice_xor_slice {
        use super::*;

        #[test]
        fn same_length() {
            let left = &[8, 8, 8];
            let right = &[16, 16, 16];

            assert_eq!(slice_xor_slice(left, right), &[24, 24, 24]);
        }

        #[test]
        #[should_panic(expected = "left and right arrays must be the same length")]
        fn different_length() {
            let left = &[8, 8];
            let right = &[16, 16, 16];

            assert_eq!(slice_xor_slice(left, right), &[24, 24, 24]);
        }
    }

    mod slice_xor_u8 {
        use super::*;

        #[test]
        fn simple() {
            assert_eq!(slice_xor_u8(&[0xF, 0xF], 0xB), &[0x4, 0x4]);
            assert_eq!(slice_xor_u8(&[0xF, 0xF], 0xF), &[0x0, 0x0]);
        }
    }
}
