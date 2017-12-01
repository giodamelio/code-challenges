defmodule AOC.Puzzles.N01 do
  def first_half(input) do
    input

    # Take the first item in the list and add it to the end
    |> (fn(list) ->
      list ++ Enum.take(list, 1)
    end).()

    # Split the list into overlapping chunks of two
    |> Enum.chunk_every(2, 1, :discard)

    # Filter out pairs that are not the same
    |> Enum.filter(fn([a, b]) ->
      a == b
    end)

    # Take the first item from each pair
    |> Enum.map(fn([a, _]) ->
      a
    end)

    # Sum them
    |> Enum.sum
  end

  def second_half(input) do
    input

    # Double the list
    |> (fn(list) ->
      list ++ list
    end).()

    # Split the list into overlapping subarrays of the length
    # of the list floor divided by 2 and add 1
    # The last item in the each resulting list will be the
    # number that is "halfway around"
    |> Enum.chunk_every(trunc(length(input) / 2) + 1, 1)

    # We now have twice as many sub lists as we want and the last half
    # are junk anyway, so just grab  the ones we want
    |> Enum.take(length(input))

    # Filter out pairs that are not the same
    |> Enum.filter(fn(item) ->
      # Compare first and last indexs of list
      hd(item) == Enum.at(item, -1)
    end)

    # Take the first item from each pair
    |> Enum.map(&hd/1)

    # Sum them
    |> Enum.sum
  end
end
