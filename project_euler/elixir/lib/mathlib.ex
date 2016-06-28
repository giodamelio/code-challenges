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

  defmodule Prime do
    @moduledoc """
    A module for dealing with prime numbers
    """

    @doc """
    Find the nth prime

    ## Example
    iex> ProjectEuler.Mathlib.Prime.nth(10)
    29
    """
    def nth(count) do
      Stream.iterate(2, &next_prime/1)
        |> Enum.take(count)
        |> List.last
    end

    @doc """
    Find the next prime

    ## Example
    iex> ProjectEuler.Mathlib.Prime.next_prime(7)
    11
    iex> ProjectEuler.Mathlib.Prime.next_prime(14)
    17
    """
    def next_prime(n) do
      n = n + 1

      if ProjectEuler.Mathlib.prime_factors(n) == [n] do
        n
      else
        next_prime(n)
      end
    end
  end

  @doc """
  Check if a set of three numbers is a Pythagorean triplet

  ## Example
  iex> ProjectEuler.Mathlib.is_pythagorean_triplet(3, 4, 5)
  true
  iex> ProjectEuler.Mathlib.is_pythagorean_triplet(1, 2, 3)
  false
  """
  def is_pythagorean_triplet(a, b, c) do
    (a * a) + (b * b) == (c * c)
  end

  @doc """
  Get the factorial of a number

  ## Example
  iex> ProjectEuler.Mathlib.factorial(4)
  24
  iex> ProjectEuler.Mathlib.factorial(10)
  3628800
  """
  def factorial(0), do: 1
  def factorial(n) when n > 0 do
    n * factorial(n - 1)
  end

  @doc """
  Find the factors of a number

  ## Example
  iex> ProjectEuler.Mathlib.factors(12)
  [1, 2, 3, 4, 6, 12]
  """
  def factors(n) do
    factors(n, 1, []) |> Enum.sort
  end

  defp factors(n, i, f) when n < i * i, do: f
  defp factors(n, i, f) when n == i * i, do: [i | f]
  defp factors(n, i, f) when rem(n, i) == 0 do
    factors(n, i + 1, [i, div(n, i) | f])
  end
  defp factors(n, i, f), do: factors(n, i + 1, f)

  @doc """
  Checks if a number is an amicable number

  ## Example
  iex> ProjectEuler.Mathlib.is_amicable_number(220)
  true
  iex> ProjectEuler.Mathlib.is_amicable_number(17)
  false
  """
  def is_amicable_number(a) do
    b = amicable_convert(a)
    c = amicable_convert(b)
    b != c && a == c
  end
  defp amicable_convert(n) do
    factors(n) |> List.delete_at(-1) |> Enum.sum
  end

  @doc """
  Create a lazy stream of amicable numbers

  ## Example
  iex> ProjectEuler.Mathlib.amicable_numbers |> Enum.take(10)
  [220, 284, 1184, 1210, 2620, 2924, 5020, 5564, 6232, 6368]
  """
  def amicable_numbers do
    Stream.unfold(1, fn (acc) ->
      {acc, acc + 1}
    end) |> Stream.filter(fn (n) ->
      is_amicable_number(n)
    end)
  end
end
