import test from '../test';
import { greatestCommenDivisor, lowestCommenMultiple } from '../mathlib';

let addFractions = function(num, ...input) {
  // Convert the fractions to an array of arrays
  let fractions = input.map(function(fraction) {
    let parts = fraction.split('/');
    return [parseInt(parts[0]), parseInt(parts[1])];
  });

  // Get the lowest commen multiple
  let lcm = lowestCommenMultiple(fractions.map((f) => f[1]));

  // Convert the fractions to have the same denominators
  fractions = fractions.map(function(fraction) {
    return [fraction[0] * (lcm / fraction[1]), lcm];
  });

  // Add the fractions togather
  let result = fractions.reduce(function(previous, current) {
    return [previous[0] + current[0], previous[1]];
  });

  // Reduce the fraction
  let gcd = greatestCommenDivisor(...result);
  result = result.map(function(num) {
    return num / gcd;
  });

  return result.join('/');
};

console.log('Sample inputs');
test([2, '1/6', '3/10'], addFractions, '7/15');
test([3, '1/3', '1/4', '1/12'], addFractions, '2/3');

console.log('Challenge inputs');
test([5, '2/9', '4/35', '7/34', '1/2', '16/33'], addFractions, '89962/58905');
test([10, '1/7', '35/192', '61/124', '90/31', '5/168', '31/51', '69/179', '32/5', '15/188', '10/17'], addFractions, '351910816163/29794134720');

