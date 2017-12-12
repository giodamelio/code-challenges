defmodule AOCTest.Puzzles.N12Test do
  use ExUnit.Case

  import AOC.Puzzles.N12

  @regex ~r/(?<number>\d+)\ <->\ (?<connected>.+$)/

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/12.txt")

    input = raw
    # Trim surronding whitespace and newlines
    |> String.trim

    # Split by line
    |> String.split("\n")

    # Parse each line with regex
    |> Enum.map(&Regex.named_captures(@regex, &1))

    # Convert the map keys to atoms
    |> Enum.map(fn (program) ->
      Enum.reduce(program, %{}, fn ({key, val}, acc) ->
        Map.put(acc, String.to_atom(key), val)
      end)
    end)

    # Parse some of the values further
    |> Enum.map(fn (line) ->
      line
      # Convert number to integer
      |> Map.update!(:number, fn (number) ->
        number |> String.to_integer
      end)

      # Convert connected to list of integers
      |> Map.update!(:connected, fn (connected) ->
        connected
        |> String.split(", ")
        |> Enum.map(&String.to_integer/1)
      end)
    end)

    # Example to be shared between parts
    example = [%{connected: [2], number: 0},
               %{connected: [1], number: 1},
               %{connected: [0, 3, 4], number: 2},
               %{connected: [2, 4], number: 3},
               %{connected: [2, 3, 6], number: 4},
               %{connected: [6], number: 5},
               %{connected: [4, 5], number: 6}]

    {:ok, input: input, example: example}
  end

  describe "Part 1" do
    test "first example", %{:example => example} do
      assert first_half(example) == 6
    end

    test "solution", %{:input => input} do
      assert first_half(input) == 115
    end
  end

  describe "Part 2" do
    test "first example", %{:example => example} do
      assert second_half(example) == 2
    end

    test "solution", %{:input => input} do
      assert second_half(input) == 221
    end
  end
end
