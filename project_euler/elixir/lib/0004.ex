defmodule ProjectEuler.P0004 do
  def solve(limit) do
    for x <- 1..limit,
        y <- 1..limit,
        ProjectEuler.Mathlib.is_palindrome(x * y) do
      x * y
    end |> Enum.max
  end

  def print do
    solve 999
  end
end
