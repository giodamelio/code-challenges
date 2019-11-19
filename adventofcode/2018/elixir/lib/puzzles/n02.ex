defmodule AOC.Puzzles.N02 do
  def parse(input) do
    input
    # Trim surronding whitespace and newlines
    |> String.trim
    # Split on each line
    |> String.split("\n")
  end

  # Take in a string and return a Map of letter => occorurance count
  def letter_counts(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, fn element, acc ->
      Map.update(acc, element, 1, &(&1 + 1))
    end)
  end

  def first_half(input) do
    summed_counts = input
    # Get the letter counts for each ID
    |> Enum.map(&letter_counts/1)
    # Get lists of just the values
    |> Enum.map(&Map.values/1)
    # Convert to sets
    |> Enum.map(&MapSet.new/1)
    # Convert the MapSets to maps
    |> Enum.map(fn count ->
      Map.new(count, &({&1, 1}))
    end)
    # Merge the maps togather adding the counts
    |> Enum.reduce(fn element, acc ->
      Map.merge(element, acc, fn _key, v1, v2 -> v1 + v2 end)
    end)

    Map.get(summed_counts, 2) * Map.get(summed_counts, 3)
  end

  def second_half(input) do
    input
    # Sort the IDs
    |> Enum.sort
    # Split into overlapping chunks of 2
    |> Enum.chunk_every(2, 1, :discard)
    # Find out how different each pair of IDs are
    |> Enum.map(fn [first, second] ->
      {String.jaro_distance(first, second), first, second}
    end)
    # Find the two most similar items
    |> Enum.sort_by(&elem(&1, 0), &>=/2)
    |> List.first
    # Get the output by removing the different charecters
    |> (fn {_diff, first, second} ->
      String.myers_difference(first, second)
    end).()
    |> Enum.reduce("", fn {key, val}, acc ->
      if key == :eq, do: acc <> val, else: acc
    end)
  end
end
