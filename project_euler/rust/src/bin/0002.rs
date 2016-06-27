fn main() {
    let mut sum = 0;
    let mut current = 1;
    let mut next = 1;
    while current < 4000000 {
        let new_next = current + next;
        current = next;
        next = new_next;

        if current % 2 == 0 {
            sum += current;
        }
    }

    println!("{}", sum);
}
