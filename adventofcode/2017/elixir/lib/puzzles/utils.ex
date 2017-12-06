defmodule AOC.Puzzles.Utils do
  # Rotate a list n elements to the right looping elements
  # from the end to the start
  def rotate(list, n), do: rotate(list, n, :RIGHT)

  def rotate(list, n, :RIGHT) do
    {head, tail} = Enum.split(list, length(list) - n)
    tail ++ head
  end

  def rotate(list, n, :LEFT) do
    {head, tail} = Enum.split(list, n)
    tail ++ head
  end
end
