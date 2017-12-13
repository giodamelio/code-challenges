defmodule AOC.Puzzles.N13 do
  import AOC.Puzzles.Utils
  require AOC.Puzzles.Utils

  def zigzag(n) do
    going_up   = Enum.to_list(0..(n - 1))
    going_down = Enum.to_list((n - 2)..1)

    Stream.cycle(going_up ++ going_down)
  end

  def is_caught?(layer), do: is_caught?(layer, 0)
  def is_caught?({depth, range}, offset) do
    scanner_path = zigzag(range)
    scanner_location = Enum.at(scanner_path, depth + offset)
    scanner_location == 0
  end

  def find_cost(input), do: find_cost(input, 0)
  def find_cost(input, offset) do
    input
    # Keep only the layers where we are caught
    |> Enum.filter(&is_caught?(&1, offset))

    # Multiply depth * range
    |> Enum.map(fn ({a, b}) -> a * b end)

    # Sum it
    |> Enum.sum
  end

  def first_half(input) do
    find_cost(input)
  end

  def second_half(input) do
    # # Infinitly long sequence 1, 2, 3, 4, 5, ...
    # Stream.iterate(0, &(&1 + 1))

    # # Try this offset until the cost is zero
    # |> Enum.take_while(fn (n) ->
    #   cost = find_cost(input, n)
    #   debug([n, cost])
    #   cost != 0
    # end)

    # Infinitly long sequence 1, 2, 3, 4, 5, ...
    Stream.iterate(0, &(&1 + 1))

    # Try this offset until the cost is zero
    |> Enum.map(&find_cost(input, &1))

    |> Enum.take(12)
  end
end
