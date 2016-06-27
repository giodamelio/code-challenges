import test from '../test';

function plants(people, plants) {
  let weeks = 0;
  let fruits = 0;
  while (fruits < people) {
    weeks += 1;
    fruits += plants;
    plants += fruits;
  }
  return weeks + 1;
};

console.log('Sample inputs');
test([15, 1], plants, 5);

console.log('Challenge inputs');
test([200, 15], plants, 5);
test([50000, 1], plants, 14);
test([150000, 240], plants, 9);

