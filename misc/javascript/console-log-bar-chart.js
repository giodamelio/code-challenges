const input = [1, 3, 10, 5, 3, 12, 2, 10];

function barChart(numbers) {
  const tallest = Math.max(...input);
  const boxWidth = String(tallest).length;

  // Print the bars
  for (let y = tallest; y > 0; y--) {
    let line = ' ';
    for (let x = 0; x < numbers.length; x++) {
      const number = numbers[x];
      if (number > y) {
        line += '┃' + ' '.repeat(boxWidth) + '┃ ';
      } else if (number === y) {
        line += '┏' + '━'.repeat(boxWidth) + '┓ ';
      } else {
        line += '  ' + ' '.repeat(boxWidth) + ' ';
      }
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
