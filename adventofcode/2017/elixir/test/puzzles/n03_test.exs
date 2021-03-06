defmodule AOCTest.Puzzles.N03Test do
  use ExUnit.Case

  import AOC.Puzzles.N03

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/03.txt")

    input = raw

    # Trim whiespace and newlines
    |> String.trim

    # Parse to integer
    |> String.to_integer

    {:ok, input: input}
  end

  describe "manhatten_distance" do
    test "0,0 -> 0,10" do
      assert manhatten_distance({0, 0}, {0, 10}) == 10
    end

    test "0,0 -> 10,10" do
      assert manhatten_distance({0, 0}, {10, 10}) == 20
    end
  end

  describe "Part 1" do
    test "1" do
      assert first_half(1) == 0
    end

    test "12" do
      assert first_half(12) == 3
    end

    test "23" do
      assert first_half(23) == 2
    end

    test "1024" do
      assert first_half(23) == 31
    end

    test "solution", %{:input => input} do
      assert first_half(input) == 475
    end
  end

  # describe "Part 2" do
  #   test "12131415" do
  #     assert second_half([1, 2, 1, 3, 1, 4, 1, 5]) == 4
  #   end

  #   test "solution", %{:input => input} do
  #     assert second_half(input) == 1054
  #   end
  # end
end
