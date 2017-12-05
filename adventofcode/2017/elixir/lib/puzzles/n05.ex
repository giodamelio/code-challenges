defmodule AOC.Puzzles.N05 do
  # Initial run
  def jump(stack, updater) do
    jump(stack, 0, 0, updater)
  end

  # If the position goes negative, return the count
  def jump(_stack, position, count, _updater)
  when position < 0,
    do: count

  # If the position goes longer then the list return the count
  def jump(stack, position, count, _updater)
  when position >= length(stack),
    do: count

  # Do a jump
  def jump(stack, position, count, updater) do
    offset = Enum.at(stack, position)
    jump(
      updater.(stack, position, offset),
      position + offset,
      count + 1,
      updater
    )
  end

  def first_half(input) do
    jump(input, fn (stack, position, _offset) ->
        List.update_at(stack, position, &(&1 + 1))
    end)
  end

  def second_half(input) do
    jump(input, fn (stack, position, offset) ->
      change = if offset >= 3, do: -1, else: 1
      List.update_at(stack, position, &(&1 + change))
    end)
  end
end
