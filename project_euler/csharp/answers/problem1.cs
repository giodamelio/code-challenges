using System;

namespace answers
{
    public class Problem1 : Answer
    {
        public Problem1(int input) : base(input)
        {
        }

        public new int Calculate()
        {
            var sum = 0;
            for (var i = 0; i < Input; i++)
            {
                if (i % 3 == 0 || i % 5 == 0)
                {
                    sum += i;
                }
            }

            return sum;
        }
    }
}