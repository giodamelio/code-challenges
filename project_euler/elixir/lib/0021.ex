defmodule ProjectEuler.P0021 do
  def solve(limit) do
    ProjectEuler.Mathlib.amicable_numbers
      |> Enum.take_while(&(&1 < limit))
      |> Enum.sum
  end

  def print do
    solve 10000
  end
end
