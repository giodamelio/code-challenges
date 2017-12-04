defmodule AOC.Puzzles.N03 do
  def manhatten_distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  # Returns an infinite stream of odd_squares
  def odd_squares do
    squares =
      # Make a stream of odd numbers
      Stream.iterate(1, &(&1 + 2))

      # Square them
      |> Stream.map(&(&1 * &1))

    Stream.with_index(squares)
  end

  def closest_odd_square(n) do
    # Find the last odd square smaller then n
    {smaller_odd_square, smaller_index} = odd_squares()
    |> Enum.take_while(fn ({square, _index}) ->
      square < n
    end)
    |> List.last

    # Find the next odd square larger then n
    {larger_odd_square, larger_index} = odd_squares()
    |> Enum.take(smaller_index + 2)
    |> List.last

    # Compare the two and find the closer one
    if (abs(n - smaller_odd_square) < abs(n - larger_odd_square)) do
      {smaller_odd_square, smaller_index}
    else
      {larger_odd_square, larger_index}
    end
  end

  # The bottom right corner of each concentric square is a square of
  # an odd number (1, 9, 25, 49, ...) so we find the odd last odd square
  # smaller then our input calculate its coords then count up to our number.
  # Then we can calculate the manhatten_distance
  # TODO: Seems to work for the puzzle input, but not for every number
  def first_half(input) do
    {closest_odd_square, closest_odd_square_index} = closest_odd_square(input)

    # Calculate the coords of the number
    coords = {closest_odd_square_index, closest_odd_square - (closest_odd_square_index + input)}

    manhatten_distance({0, 0}, coords)
  end

  def second_half(input) do
    100
  end
end
