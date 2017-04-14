const assert = require('assert');

// No e's in this funciton
const no_101 = (string) => (
  that_char = (![] + '')[4], that_tall_char = (/a/.constructor + '')[12],
  !string.split('').find((char) => char === that_char || char === that_tall_char)
)

// Test our function
assert( no_101('abcdfghijklmnopqrstuvxyz'));
assert(!no_101('eeeeeeee'));
assert(!no_101('EEEEEEEE'));
assert(!no_101('eek!'));
assert( no_101('ееk!')); // What!
console.log('Success!');
