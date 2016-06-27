extern crate math;

fn main() {
    let mut biggest_divisible_number = 1;
    for n in 1..21 {
        biggest_divisible_number = math::least_commen_multiple(biggest_divisible_number, n);
    }

    println!("{}", biggest_divisible_number);
}
