defmodule ProjectEuler.P0009 do
  def solve(limit) do
    for a <- 1..limit,
        b <- a+1..limit,
        c <- b+1..limit,
        ProjectEuler.Mathlib.is_pythagorean_triplet(a, b, c) do
      [a, b, c]
    end
      |> Enum.filter(fn [a, b, c] ->
        a + b + c == limit
      end)
      |> List.first
      |> Enum.reduce(&(&1 * &2))
  end

  def print do
    solve 1000
  end
end
