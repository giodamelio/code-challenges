defmodule AOCTest.Puzzles.N05Test do
  use ExUnit.Case

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/05.txt")

    input = raw
    # Trim extra whitespace
    |> String.trim

    # Split by lines
    |> String.split("\n")

    # Parse to integer
    |> Enum.map(&Integer.parse/1)

    # Get just the number without the extra data
    |> Enum.map(fn ({n, _}) ->
      n
    end)

    {:ok, input: input}
  end

  describe "Part 1" do
    test "0, 3, 0, 1, -3" do
      assert AOC.Puzzles.N05.first_half([0, 3, 0, 1, -3]) == 5
    end

    @tag :slow
    test "solution", %{:input => input} do
      assert AOC.Puzzles.N05.first_half(input) == 343364
    end
  end

  describe "Part 2" do
    test "0, 3, 0, 1, -3" do
      assert AOC.Puzzles.N05.second_half([0, 3, 0, 1, -3]) == 10
    end

    @tag :slow
    test "solution", %{:input => input} do
      assert AOC.Puzzles.N05.second_half(input) == 25071947
    end
  end
end
