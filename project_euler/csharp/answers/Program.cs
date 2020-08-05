using System;

namespace answers
{
    internal static class Program
    {
        private static void Main(string[] args)
        {
            var problem1 = new Problem1(1000);
            var sum = problem1.Calculate();
            Console.WriteLine($"Sum: {sum}");
        }
    }

    public class Answer
    {
        private protected int Input { get; set; }

        protected Answer(int input)
        {
            Input = input;
        }

        public int Calculate()
        {
            return Input;
        }
    }
}