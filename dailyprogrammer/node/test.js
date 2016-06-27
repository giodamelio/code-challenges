import { equal } from 'assert';

const GREEN = '\x1B\[32m';
const RED = '\x1B\[31m';
const END = '\x1B\[0m';

export default function test(input, process, answer) {
  let output;
  if (!Array.isArray(input)) {
    output = process.apply(this, [input]);
  } else {
    output = process.apply(this, input);
  }

  try {
    equal(output, answer);
    console.log(
`${GREEN}  Input: ${JSON.stringify(input)}
  Output: ${output}
  Correct Answer: ${answer}${END}
`
    );
  } catch (e) {
    if (e.name == 'AssertionError' ) {
      console.log(
`${RED}  Input: ${JSON.stringify(input)}
  Output: ${output}
  Correct Answer: ${answer}${END}
`
      );
    } else {
      throw e;
    }
  }
};

