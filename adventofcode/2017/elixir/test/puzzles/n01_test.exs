defmodule AOCTest.Puzzles.N01Test do
  use ExUnit.Case

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/01.txt")

    input = raw
    # Trim surronding whitespace and newlines
    |> String.trim

    # Split on each char
    |> String.split("")

    # Filter out any empty strings
    |> Enum.reject(fn(item) ->
      item == ""
    end)

    # Parse it into an {int, remaining_string} tuple
    |> Enum.map(&Integer.parse/1)

    # Take just the number we want
    |> Enum.map(fn({num, _}) ->
      num
    end)

    # IO.inspect input
    {:ok, input: input}
  end

  describe "Part 1" do
    test "1122" do
      assert AOC.Puzzles.N01.first_half([1, 1, 2, 2]) == 3
    end

    test "1111" do
      assert AOC.Puzzles.N01.first_half([1, 1, 1, 1]) == 4
    end

    test "1234" do
      assert AOC.Puzzles.N01.first_half([1, 2, 3, 4]) == 0
    end

    test "91212129" do
      assert AOC.Puzzles.N01.first_half([9, 1, 2, 1, 2, 1, 2, 9]) == 9
    end

    test "solution", %{:input => input} do
      assert AOC.Puzzles.N01.first_half(input) == 1044
    end
  end

  describe "Part 2" do
    test "1212" do
      assert AOC.Puzzles.N01.second_half([1, 2, 1, 2]) == 6
    end

    test "1221" do
      assert AOC.Puzzles.N01.second_half([1, 2, 2, 1]) == 0
    end

    test "123425" do
      assert AOC.Puzzles.N01.second_half([1, 2, 3, 4, 2, 5]) == 4
    end

    test "123123" do
      assert AOC.Puzzles.N01.second_half([1, 2, 3, 1, 2, 3]) == 12
    end

    test "12131415" do
      assert AOC.Puzzles.N01.second_half([1, 2, 1, 3, 1, 4, 1, 5]) == 4
    end

    test "solution", %{:input => input} do
      assert AOC.Puzzles.N01.second_half(input) == 1054
    end
  end
end
