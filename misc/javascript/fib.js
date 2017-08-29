const assert = require('assert');

function fibRecursiveN(n) {
  if (n <= 1) return 1;
  return fibRecursiveN(n - 1) + fibRecursiveN(n - 2);
}

assert.equal(fibRecursiveN(5), 8);
assert.equal(fibRecursiveN(0), 1);
assert.equal(fibRecursiveN(8), 34);

function fibIterativeN(n) {
  let a = 1;
  let b = 0;

  while (n >= 0) {
    [a, b] = [a + b, a];
    n--;
  }

  return b;
}

assert.equal(fibIterativeN(5), 8);
assert.equal(fibIterativeN(0), 1);
assert.equal(fibIterativeN(8), 34);
