defmodule AOC.Puzzles.N09 do
  import AOC.Puzzles.Utils
  require AOC.Puzzles.Utils

  # These next few functions delete some things from a string
  def delete_canceled(input) do
    Regex.replace(~r/\!./, input, "")
  end

  def delete_garbage(input) do
    Regex.replace(~r/\<.+?\>/, input, "")
  end

  def delete_extra_commas(input) do
    Regex.replace(~r/,(?=,|})|(?<={),/, input, "")
  end

  def convert_to_lists(input) do
    replaced_opening = Regex.replace(~r/{/, input, "[")
    Regex.replace(~r/}/, replaced_opening, "]")
  end

  # Add up the groups
  # Outermost group gets value of 1, next layer gets 2 and so on
  def count_groups(group), do: count_groups(group, 1)
  def count_groups(group, depth) do
    # Own depth, plus the depth of all children
    [depth] ++ Enum.map(group, &count_groups(&1, depth + 1))
    |> Enum.sum
  end

  def first_half(input) do
    input
    # Delete some stuff
    |> delete_canceled
    |> delete_garbage
    |> delete_extra_commas

    # Convert atoms to lists because they are enumerable
    |> convert_to_lists

    # Eval the string and get just the value
    |> Code.eval_string
    |> elem(0)

    # Count up the groups
    |> count_groups
  end

  def second_half(input) do
    100
  end
end
