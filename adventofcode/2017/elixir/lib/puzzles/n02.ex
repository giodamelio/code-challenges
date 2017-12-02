defmodule AOC.Puzzles.N02 do
  def evenly_divisible_by(a, b) do
    rem(a, b) == 0
  end

  def first_half(input) do
    input

    # Find largest and smallest numbers in row and calculate the differentce
    |> Enum.map(fn (item) ->
      Enum.max(item) - Enum.min(item)
    end)

    # Sum them
    |> Enum.sum
  end

  def second_half(input) do
    input

    # Find each possable combination of two numbers in each row
    |> Enum.map(fn (row) ->
      for a <- row,
          b <- row do
        {a, b}
      end
    end)

    # Remove pairs where numbers are the same
    |> Enum.map(fn (row) ->
      Enum.reject(row, fn ({a, b}) ->
        a == b
      end)
     end)

    # Find evenly divisible pair
    |> Enum.flat_map(fn (row) ->
      Enum.filter(row, fn ({a, b}) ->
        evenly_divisible_by(a, b)
      end)
    end)

    # Divide pairs
    |> Enum.map(fn ({a, b}) ->
      a / b
    end)

    # Sum them
    |> Enum.sum
  end
end
