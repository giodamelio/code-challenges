defmodule ProjectEuler.P0025 do
  def solve(limit) do
    ProjectEuler.Mathlib.fib
      |> Enum.take_while(fn (n) ->
        limit > n
          |> Integer.digits
          |> length
      end) |> length
  end

  def print do
    solve 1000
  end
end
