#![feature(iter_arith)]

extern crate num;

use num::pow;
use num::num_bigint::ToBigInt;

fn main() {
    let two = 2.to_bigint().unwrap();
    let sum: u32 = pow(two, 1000)
        .to_string()
        .chars()
        .map(|n| n.to_digit(10).unwrap())
        .sum();

    println!("{:?}", sum);
}
