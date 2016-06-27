/*
    Problem #5

    2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

    What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
*/

var max = 20;
var n = 1;
for(var i = 1; i <= max; i++) {
    n = mathlib.leastCommonMultiple(n, i);
}
console.log(n);
