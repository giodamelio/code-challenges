// Find the greatest common divisor of two numbers
export function greatestCommenDivisor(a, b) {
    if (b) {
        return greatestCommenDivisor(b, a % b);
    } else {
        return Math.abs(a);
    }
};

// The the lowest commen multiple from an array of numbers
export function lowestCommenMultiple(numbers) {
  let lcm = function(a, b) {
    return a * (b / greatestCommenDivisor(a, b));
  }
  return numbers.reduce(lcm);
};

// Return an array of the factors of a number
export function factors(number) {
  let factors = [];
  for (let i = 1; i <= number; i++) {
    if (number % i === 0) {
      factors.push(i);
    }
  }
  return factors;
}

