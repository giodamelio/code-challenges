defmodule ProjectEuler.P0020 do
  def solve(limit) do
    ProjectEuler.Mathlib.factorial(limit)
      |> Integer.digits
      |> Enum.sum
  end

  def print do
    solve 100
  end
end
