defmodule ProjectEuler.P0003 do
  def solve(limit) do
    Enum.max ProjectEuler.Mathlib.prime_factors(limit)
  end

  def print do
    solve 600_851_475_143
  end
end
