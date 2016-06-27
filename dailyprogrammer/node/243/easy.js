import test from '../test';
import { factors } from '../mathlib';

function abundantOrDeficient(number) {
  const sumOfDivisors = factors(number)
    .reduce((prev, current) => prev + current);
  const twoN = number * 2;

  if (sumOfDivisors > twoN) {
    return `${number} abundant by ${sumOfDivisors - twoN}`;
  } else if (sumOfDivisors < twoN) {
    return `${number} deficient`;
  }

  return sumOfDivisors
};

console.log('Sample inputs');
test(18, abundantOrDeficient, '18 abundant by 3');
test(21, abundantOrDeficient, '21 deficient');
test(9, abundantOrDeficient, '9 deficient');

console.log('Challenge inputs');
test(111, abundantOrDeficient, '111 deficient');
test(112, abundantOrDeficient, '112 abundant by 24');
test(220, abundantOrDeficient, '220 abundant by 64');
test(69, abundantOrDeficient, '69 deficient');
test(134, abundantOrDeficient, '134 deficient');
test(85, abundantOrDeficient, '85 deficient');

