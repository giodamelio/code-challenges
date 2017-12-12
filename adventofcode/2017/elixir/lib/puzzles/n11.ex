defmodule AOC.Puzzles.N11 do
  # Go a direction
  def go( :N, {x, y, z}), do: {x    , y + 1, z - 1}
  def go( :S, {x, y, z}), do: {x    , y - 1, z + 1}
  def go(:NE, {x, y, z}), do: {x + 1, y    , z - 1}
  def go(:SW, {x, y, z}), do: {x - 1, y    , z + 1}
  def go(:NW, {x, y, z}), do: {x - 1, y + 1, z    }
  def go(:SE, {x, y, z}), do: {x + 1, y - 1, z    }

  # Calculate the distance between two points on the grid
  def manhatten_distence({x1, y1, z1}, {x2, y2, z2}) do
    # return (abs(a.x - b.x) + abs(a.y - b.y) + abs(a.z - b.z)) / 2
    (abs(x1 - x2) + abs(y1 - y2) + abs(z1 - z2)) / 2
  end

  def first_half(input) do
    input
    # Apply the directions starting from 0, 0, 0
    |> Enum.reduce({0, 0, 0}, fn (direction, coords) ->
      go(direction, coords)
    end)

    # Calculate the distance from 0, 0, 0
    |> manhatten_distence({0, 0, 0})

    # Convert to integer
    |> trunc
  end

  def second_half(input) do
    input
    # Apply the directions starting from 0, 0, 0
    |> Enum.scan({0, 0, 0}, fn (direction, coords) ->
      go(direction, coords)
    end)

    # Calculate the distance from each step to 0, 0, 0
    |> Enum.map(&manhatten_distence({0, 0, 0}, &1))

    # Get the largest one
    |> Enum.max

    # Convert to integer
    |> trunc
  end
end
