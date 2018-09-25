pub fn xor(input_left: &[u8], input_right: &[u8]) -> Vec<u8> {
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

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn same_length() {
        let left = &[8, 8, 8];
        let right = &[16, 16, 16];

        assert_eq!(xor(left, right), &[24, 24, 24]);
    }

    #[test]
    #[should_panic(expected = "left and right arrays must be the same length")]
    fn different_length() {
        let left = &[8, 8];
        let right = &[16, 16, 16];

        assert_eq!(xor(left, right), &[24, 24, 24]);
    }
}
