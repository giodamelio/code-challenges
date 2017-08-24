const input = [1, 3, 10, 5, 3, 12, 2, 10];

function color(text, index) {
  // Convert index to a number between 31 and 36
  const colorNum = String(31 + index % 6);
  return '\x1b[' + colorNum + 'm' + text + '\x1b[0m';
}

function barChart(numbers) {
  const tallest = Math.max(...input);
  const boxWidth = String(tallest).length;

  // Print the bars
  for (let y = tallest; y > 0; y--) {
    let line = ' ';
    for (let x = 0; x < numbers.length; x++) {
      const number = numbers[x];
      let bar = '';
      if (number > y) {
        bar += '┃' + ' '.repeat(boxWidth) + '┃ ';
      } else if (number === y) {
        bar += '┏' + '━'.repeat(boxWidth) + '┓ ';
      } else {
        bar += '  ' + ' '.repeat(boxWidth) + ' ';
      }
      line += color(bar, x);
    }
    console.log(line);
  }

  // Print the bottom bar
  console.log('━' + ('┻' + '━'.repeat(boxWidth) + '┻━').repeat(numbers.length));

  // Print the numbers on the bottom
  let numberBar = '  ';
  for (let i of numbers) {
    const number = String(i);
    numberBar += number + ' '.repeat(boxWidth + 2 - number.length + 1);
  }
  console.log(numberBar);
}

barChart(input);
