defmodule ProjectEuler.P0002 do
  def solve(limit) do
    ProjectEuler.Mathlib.fib
      |> Enum.take_while(&(&1 <= limit))
      |> Enum.filter(&(rem(&1, 2) == 0))
      |> Enum.sum
  end

  def print do
    IO.puts solve(4000000)
  end
end
