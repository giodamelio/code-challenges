extern crate math;

fn main() {
    let factors = math::prime_factors(600851475143);
    println!("{}", factors[factors.len() - 1]);
}
