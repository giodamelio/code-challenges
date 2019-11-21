defmodule AOC.Puzzles.N01 do
  def parse(input) do
    input
    # Trim surronding whitespace and newlines
    |> String.trim()

    # Split on each line
    |> String.split("\n")

    # Parse it into an integer
    |> Enum.map(&String.to_integer/1)
  end

  def first_half(input) do
    Enum.sum(input)
  end

  def second_half(input) do
    Stream.cycle(input)
    # Add each item to the next item
    |> Stream.scan(&(&1 + &2))
    # Stream through the list of possabilities adding each item to a set
    # the first time it is a duplicate exit with that number
    |> Enum.reduce_while(MapSet.new([0]), fn x, acc ->
      if not MapSet.member?(acc, x) do
        {:cont, MapSet.put(acc, x)}
      else
        {:halt, x}
      end
    end)
  end
end
