defmodule ProjectEuler.P0005 do
  def solve(limit) do
    1..limit
      |> Enum.to_list
      |> List.foldl(1, fn (x, acc) ->
        ProjectEuler.Mathlib.least_common_multiple(x, acc)
      end)
  end

  def print do
    solve 20
  end
end
