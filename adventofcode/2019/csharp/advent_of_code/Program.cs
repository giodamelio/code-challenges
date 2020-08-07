using System;
using System.Collections.Generic;

namespace advent_of_code
{
    class Program
    {
        static void Main(string[] args)
        {
            var exampleInput = new List<int> {100756};
            var day1 = new Day1(exampleInput);
            Console.WriteLine(day1.Part1());
        }
    }

    class Solution<T>
    {
        protected readonly T Input;

        protected Solution(T input)
        {
            this.Input = input;
        }

        public int Part1()
        {
            return 0;
        }

        public int Part2()
        {
            return 0;
        }
    }

    class Day1 : Solution<List<int>>
    {
        public Day1(List<int> input) : base(input)
        {
        }

        public new int Part1()
        {
            var totalMass = 0;

            foreach (var moduleMass in Input)
            {
                totalMass += CalculateRequiredFuel(moduleMass);
            }

            return totalMass;
        }

        private static int CalculateRequiredFuel(int mass)
        {
            return (mass / 3) - 2;
        }
    }
}