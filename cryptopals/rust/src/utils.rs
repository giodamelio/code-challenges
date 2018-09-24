use std::iter::IntoIterator;

pub fn print_bytes<T: IntoIterator<Item = u8>>(input: T) {
    for byte in input.into_iter() {
        // Pad binary with 0s to width of 10 (8 bits plus the '0b' at the start)
        print!("{} ({:#X}, {:#010b}), ", byte, byte, byte)
    }
    println!();
}
