defmodule ProjectEuler.Mathlib do
  @doc """
  Create a lazy stream of the Fibonacci sequence

  ## Example
  iex> ProjectEuler.Mathlib.fib |> Enum.take(10)
  [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  """
  def fib do
    Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end)
  end

  @doc """
  Calculates all prime factors of a number by finding a low factor
  and then recursively calculating the factors of the high factor.
  Skips all evens except 2.
  Could be further optimized by only using known primes to find factors.

  ## Example
  iex> ProjectEuler.Mathlib.prime_factors(31415)
  [5, 61, 103]
  """
  def prime_factors(num , next \\ 2)
  def prime_factors(num, 2) do
    cond do
      rem(num, 2) == 0 -> [2 | prime_factors(div(num, 2))]
      4 > num          -> [num]
      true             -> prime_factors(num, 3)
    end |> Enum.uniq
  end
  def prime_factors(num, next) do
    cond do
      rem(num, next) == 0 -> [next | prime_factors(div(num, next))]
      next + next > num   -> [num]
      true                -> prime_factors(num, next + 2)
    end |> Enum.uniq
  end

  @doc """
  Check if a number is a palindrome

  ## Example
  iex> ProjectEuler.Mathlib.is_palindrome(101)
  true
  iex> ProjectEuler.Mathlib.is_palindrome(102)
  false
  """
  def is_palindrome(num) do
    string = Integer.to_string num
    string == String.reverse string
  end

  @doc """
  Find the greatest common divisor of two numbers

  ## Example
  iex> ProjectEuler.Mathlib.greatest_common_divisor(144, 444)
  12
  iex> ProjectEuler.Mathlib.greatest_common_divisor(240, -40)
  40
  """
  def greatest_common_divisor(a, 0), do: abs(a)
  def greatest_common_divisor(a, b), do: greatest_common_divisor(b, rem(a, b))

  @doc """
  Find the least common multiple of two numbers

  ## Example
  iex> ProjectEuler.Mathlib.least_common_multiple(4, 6)
  12
  iex> ProjectEuler.Mathlib.least_common_multiple(404, 666)
  134532
  """
  def least_common_multiple(a, b) do
    div(a * b, greatest_common_divisor(a, b))
  end
end
