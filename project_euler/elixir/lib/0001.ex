defmodule ProjectEuler.P0001 do
  def solve(limit) do
    1..(limit - 1)
      # Filter out multiples of 3 and 5
      |> Enum.filter(fn x ->
        rem(x, 3) == 0 or rem(x, 5) == 0
      end)

      # Sum the numbers
      |> Enum.sum
  end

  def print do
    IO.puts solve(1000)
  end
end
