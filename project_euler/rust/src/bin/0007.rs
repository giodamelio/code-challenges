extern crate math;

fn main() {
    let ten_thousandth_and_first_prime = (1..)
        // Keep only the prime ones
        .filter(|&n| math::is_prime(n))

        // Get the 10,001st prime
        .skip(10000).next().unwrap();

    println!("{}", ten_thousandth_and_first_prime);
}
