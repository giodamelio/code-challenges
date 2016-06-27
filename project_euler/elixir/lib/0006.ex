defmodule ProjectEuler.P0006 do
  def solve(limit) do
    square_of_sum = 1..limit
      |> Enum.to_list
      |> Enum.sum
    square_of_sum =  square_of_sum * square_of_sum

    sum_of_squares = 1..limit
      |> Enum.to_list
      |> Enum.map(&(&1 * &1))
      |> Enum.sum

    square_of_sum - sum_of_squares
  end

  def print do
    solve 100
  end
end
