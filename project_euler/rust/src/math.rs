extern crate num;

use num::num_integer::Integer;

/// Get all the factors of a number
///
/// # Examples
/// ```
/// assert_eq!(math::factors(12), vec!(2, 3, 4, 6));
/// assert_eq!(math::factors(93), vec!(3, 31));
/// ```
pub fn factors(num: i64) -> Vec<i64> {
    let mut factors: Vec<i64> = Vec::new();
    let max = ((num as f64).sqrt() as i64) + 1;
    for i in 2..max {
        if num % i == 0 {
            factors.push(i);
            factors.push(num / i);
        }
    }
    factors.sort();
    factors.dedup();
    factors
}

/// Get the prime factors
///
/// # Examples
/// ```
/// assert_eq!(math::prime_factors(12), vec!(2, 3));
/// assert_eq!(math::prime_factors(187), vec!(11, 17));
/// ```
pub fn prime_factors(num: i64) -> Vec<i64> {
    factors(num)
        .iter()
        .cloned()
        .filter(|&x| is_prime(x))
        .collect()
}

/// Test if a number is prime or not
///
/// # Examples
/// ```
/// assert!(math::is_prime(7));
/// assert!(math::is_prime(827));
/// ```
pub fn is_prime(n: i64) -> bool {
    if n == 2 {
        return true;
    }
    if n % 2 == 0 || n < 3 {
        return false;
    }
    let max = ((n as f64).sqrt() as i64) + 1;
    for i in 3i64..max {
        if n % i == 0 {
            return false;
        }
    }
    true
}

/// Test is a number is a palindrome
///
/// # Examples
/// ```
/// assert!(math::is_palindrome(1001));
/// assert!(math::is_palindrome(10101));
/// ```
pub fn is_palindrome(num: i64) -> bool {
    let string = num.to_string();
    let bytes = string.as_bytes();
    let iter = bytes.iter();
    let half = bytes.len() / 2;
    let first_half = iter.clone().take(half);
    let second_half = iter.clone().rev().take(half);

    // Zip them togather and make sure they match
    first_half.zip(second_half)
        .all(|(a, b)| a == b)
}

/// Find the greatest commen divisor
///
/// # Examples
/// ```
/// assert_eq!(math::greatest_commen_divisor(54, 144), 18);
/// assert_eq!(math::greatest_commen_divisor(8, 12), 4);
/// ```
pub fn greatest_commen_divisor(a: i64, b: i64) -> i64 {
    if a == 0 {
        b.abs()
    } else {
        greatest_commen_divisor(b % a, a)
    }
}

/// Find the least commen multiple of two numbers
///
/// # Examples
/// ```
/// assert_eq!(math::least_commen_multiple(10, 4), 20);
/// ```
pub fn least_commen_multiple(a: i64, b: i64) -> i64 {
    (a * b) / greatest_commen_divisor(a, b)
}

/// Test if three numbers form a pythagorean triplet
///
/// # Examples
/// ```
/// // Sample Pythagorean triplets
/// assert!(math::is_pythagorean_triplet(3, 4, 5));
/// assert!(math::is_pythagorean_triplet(16, 63, 65));
/// ```
pub fn is_pythagorean_triplet(a: i64, b: i64, c: i64) -> bool {
    a.pow(2) + b.pow(2) == c.pow(2)
}

/// Iterate over the triangle numbers
///
/// # Examples
/// ```
/// assert_eq!(
///     math::triangle_numbers().take(4).collect::<Vec<i64>>(),
///     vec!(1, 3, 6, 10)
/// );
/// ```
pub struct TriangleNumbers {
    current: i64,
    index: i64,
}

impl Iterator for TriangleNumbers {
    type Item = i64;

    fn next(&mut self) -> Option<i64> {
        let current = self.current;

        self.current += self.index;
        self.index += 1;

        Some(current)
    }
}

pub fn triangle_numbers() -> TriangleNumbers {
    TriangleNumbers {
        current: 1,
        index: 2,
    }
}

/// Iterate over the Collatz sequence for a given number
///
/// # Examples
/// ```
/// assert_eq!(
///     math::collatz_sequence(13).collect::<Vec<i64>>(),
///     vec![13, 40, 20, 10, 5, 16, 8, 4, 2, 1]
/// );
/// assert_eq!(
///     math::collatz_sequence(22).collect::<Vec<i64>>(),
///     vec![22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]
/// );
/// ```
pub struct CollatzSequence {
    current: i64,
    previous: i64,
}

impl Iterator for CollatzSequence {
    type Item = i64;

    fn next(&mut self) -> Option<i64> {
        let current = self.current;

        if current % 2 == 0 {
            self.current = current / 2
        } else {
            self.current = 3 * current + 1
        }

        if self.previous == 1 {
            return None;
        }

        self.previous = current;

        Some(current)
    }
}

pub fn collatz_sequence(n: i64) -> CollatzSequence {
    CollatzSequence {
        current: n,
        previous: n,
    }
}

/// Get the factorial of a number
///
/// # Example
/// ```
/// assert_eq!(math::factorial(10), 3628800);
/// assert_eq!(math::factorial(16), 20922789888000i64);
/// ```
pub fn factorial<T>(n: T) -> T
    where T: Integer + Copy
{
    if n == T::zero() || n == T::one() {
        T::one()
    } else {
        n * factorial(n - T::one())
    }
}
