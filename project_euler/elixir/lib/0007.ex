defmodule ProjectEuler.P0007 do
  def solve(limit) do
    ProjectEuler.Mathlib.Prime.nth(limit)
  end

  def print do
    solve 10001
  end
end
