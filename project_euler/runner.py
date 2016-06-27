#!/usr/bin/env python3

import argparse
import os
import shlex
import subprocess
import sys
from timeit import default_timer as timer

# Tell the runner how to run each languages example
LANGUAGES = {
    'rust': {
        'directory': 'rust/',
        'command': [
            'cargo build --bin {0:04d} --release',
            './target/release/{0:04d}'
        ],
        'list_completed': lambda:
            sorted([int(file[:-3]) for file in os.listdir('rust/src/bin/')]), 
    },
    'javascript': {
        'directory': 'javascript/',
        'command': 'node {}.js',
        'list_completed': lambda:
            sorted([int(file[:-3]) for file in os.listdir('javascript/') if file != 'mathlib.js']), 
    },
}

# Load the answers
ANSWERS = [int(line.rstrip('\n')) for line in open('problems/answers.txt').readlines()]

# Run an example
def run(language, number):
    info = LANGUAGES[language]

    # Change to the languages directory
    os.chdir(info['directory']);

    # If commands is a list run all but the last one before the timer
    if type(info['command']) == list:
        command = info['command'][-1]
        precommands = info['command'][:-1]

        print('---- Running pre-commands ----')
        for precommand in precommands:
            output = subprocess.check_output(
                shlex.split(precommand.format(number)))
            sys.stdout.write(output.decode('ascii'))
    else:
        command = info['command']

    # Print opening message
    pre_run_message = '---- Running {} problem {} ----'.format(
        args.language, args.number)
    print(pre_run_message)

    # Start our timer
    start = timer()

    # Run the command
    command = shlex.split(command.format(number))
    process = subprocess.Popen(command, stdout=subprocess.PIPE);

    # Print the output keeping track of the last line
    lastline = ''
    for line in process.stdout:
        line = line.decode('ascii')
        lastline = line
        sys.stdout.write(line)

    # Stop timer
    end = timer()

    # Print closing message
    print('-' * len(pre_run_message))
    print('{} problem {} run in {} seconds'
          .format(args.language, args.number, end - start))

    return int(lastline)

# Parse our args
parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument(
    'language', 
    type=str, 
    choices=LANGUAGES.keys(),
    help='which language to run'
)
parser.add_argument(
    'number', 
    type=int, 
    help='which problem to run'
)
args = parser.parse_args()

# Make sure the problem has been completed
completed_problems = LANGUAGES[args.language]['list_completed']()
if not args.number in completed_problems:
    print('Problem {} has not been completed for language {}'
          .format(args.number, args.language))
    sys.exit(1)

# Run the problem
answer = run(args.language, args.number)

# Check to see if the answer is correct
if len(ANSWERS) < args.number or ANSWERS[args.number - 1] == -1:
    print('No answer for problem {} is saved'.format(args.number))
    sys.exit(1)
elif ANSWERS[args.number - 1] != answer:
    print('{}{} is the incorrect answer for problem {}{}'
          .format('\x1b[0;31m', answer, args.number, '\x1b[0m'))
    sys.exit(1)
elif ANSWERS[args.number - 1] == answer:
    print('{}{} is the correct answer for problem {}{}'
          .format('\x1b[0;32m', answer, args.number, '\x1b[0m'))
    sys.exit(0)
