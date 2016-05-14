#[macro_use]
extern crate math;

fn main() {
    for n in math::triangle_numbers() {
        let factors = math::factors(n);

        if factors.len() > (500 - 2) {
            assert_answer!(n);
            break;
        }
    }
}
