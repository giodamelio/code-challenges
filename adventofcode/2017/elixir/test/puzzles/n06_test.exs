defmodule AOCTest.Puzzles.N06Test do
  use ExUnit.Case

  import AOC.Puzzles.N06

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/06.txt")

    input = raw
    # Trim extra whitespace
    |> String.trim

    # Split by newlines
    |> String.split("\n")

    # Parse it into an integer
    |> Enum.map(&String.to_integer(&1))

    {:ok, input: input}
  end

  describe "split_block/2" do
    test "even number" do
      assert split_block(8, 4) == [2, 2, 2, 2]
    end

    test "odd number" do
      assert split_block(13, 4) == [4, 3, 3, 3]
    end
  end

  describe "Part 1" do
    test "0, 2, 7, 0" do
      assert first_half([0, 2, 7, 0]) == 5
    end

    test "solution", %{:input => input} do
      assert first_half(input) == 12841
    end
  end

  describe "Part 2" do
    test "1212" do
      assert second_half([0, 2, 7, 0]) == 4
    end

    test "solution", %{:input => input} do
      assert second_half(input) == 8038
    end
  end
end
