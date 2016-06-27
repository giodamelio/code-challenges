extern crate math;

fn main() {
    let mut biggest = 0;
    for a in 1..1000 {
        for b in 1..1000 {
            let i = a * b;
            if math::is_palindrome(i) && i > biggest {
                biggest = i;
            }
        }
    }

    println!("{}", biggest);
}
