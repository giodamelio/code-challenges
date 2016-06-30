function valid_parens(input) {
  input = input.split('').filter((p) => p === '(' || p === ')').join('');
  let previous = '';
  while (input.length !== previous.length) {
    previous = input;
    input = input.replace('()', '')
  }
  return (input.length === 0);
}

console.log(valid_parens('()'));
console.log(valid_parens('  ('));
