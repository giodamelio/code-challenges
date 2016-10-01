/* While these friends are good at cracking security, they need some help with elementary computing tasks. So they reach out to you.
   They want to be able to give you an array of positive and negative integers, representing distances north or south of the capital, and they want to see the elements of the array in zigzag order. 
   This means that the largest member appears first, the smallest appears second, and the remaining elements alternate between the larger members decreasing from the largest, and the smaller members increasing from the smallest.
   For example, the array [ 1, 3, 6, 9, -3 ] becomes [ 9, -3, 6, 1, 3, ] in zigzag order.
   Complete the function zigzagArray which takes one argument, an integer array of n integers. */

const assert = require('assert');

function zigZagArray(input) {
  // Sort the array from largest to smallest
  input.sort((a, b) => a < b);

  function helper(i, acc) {
    // If the input array still has some values,
    // grab the largest remaining element and push it to the output array
    if (i.length === 0) return acc;
    acc.push(i.shift());

    // If the input array still has some values,
    // grab the smallest remaining element and push it to the output array
    if (i.length === 0) return acc;
    acc.push(i.pop());
    
    // Keeping recursing until the input array is empty
    return helper(i, acc);
  }

  return helper(input, []);
}

const input = [1, 3, 6, 9, -3];
const output = [9, -3, 6, 1, 3];
assert.deepEqual(zigZagArray(input), output);
console.log('Success!!!');
