defmodule AOCTest.Puzzles.N03Test do
  use ExUnit.Case

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/03.txt")

    input = raw

    # Trim whiespace and newlines
    |> String.trim

    # Parse to integer
    |> Integer.parse

    # Get just the number without the extra data
    |> (fn ({n, _}) ->
      n
    end).()

    {:ok, input: input}
  end

  describe "manhatten_distance" do
    test "0,0 -> 0,10" do
      assert AOC.Puzzles.N03.manhatten_distance({0, 0}, {0, 10}) == 10
    end

    test "0,0 -> 10,10" do
      assert AOC.Puzzles.N03.manhatten_distance({0, 0}, {10, 10}) == 20
    end
  end

  describe "Part 1" do
    test "1" do
      assert AOC.Puzzles.N03.first_half(1) == 0
    end

    test "12" do
      assert AOC.Puzzles.N03.first_half(12) == 3
    end

    test "23" do
      assert AOC.Puzzles.N03.first_half(23) == 2
    end

    test "1024" do
      assert AOC.Puzzles.N03.first_half(23) == 31
    end

    test "solution", %{:input => input} do
      assert AOC.Puzzles.N03.first_half(input) == 475
    end
  end

  # describe "Part 2" do
  #   test "12131415" do
  #     assert AOC.Puzzles.N03.second_half([1, 2, 1, 3, 1, 4, 1, 5]) == 4
  #   end

  #   test "solution", %{:input => input} do
  #     assert AOC.Puzzles.N03.second_half(input) == 1054
  #   end
  # end
end
