import { equal } from 'assert';

const GREEN = '\x1B\[32m';
const RED = '\x1B\[31m';
const END = '\x1B\[0m';

export default function test(input, process, answer) {
  if (!Array.isArray(input)) {
    input = [input];
  }
  let output = process.apply(this, input);
  try {
    equal(output, answer);
    console.log(
`${GREEN}  Input: ${input}
  Output: ${output}
  Correct Answer: ${answer}${END}
`
    );
  } catch (e) {
    if (e.name == 'AssertionError' ) {
      console.log(
`${RED}  Input: ${input}
  Output: ${output}
  Correct Answer: ${answer}${END}
`
      );
    } else {
      throw e;
    }
  }
};

