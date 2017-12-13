defmodule AOCTest.Puzzles.N13Test do
  use ExUnit.Case

  import AOC.Puzzles.N13
  import AOC.Puzzles.Utils
  require AOC.Puzzles.Utils

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/13.txt")

    input = raw
    # Trim surronding whitespace and newlines
    |> String.trim

    # Split it by lines
    |> String.split("\n")

    # Split it by the colon
    |> Enum.map(&String.split(&1, ": "))

    # Parse the strings to numbers
    |> Enum.map(fn ([a, b]) ->
      {String.to_integer(a), String.to_integer(b)}
    end)

    # Example to be shared between parts
    example = [{0, 3},
               {1, 2},
               {4, 4},
               {6, 4}]
    # example = [{0, 3},
    #            {1, 2},
    #            {2, 0},
    #            {3, 0},
    #            {4, 4},
    #            {5, 0},
    #            {6, 4}]

    {:ok, input: input, example: example}
  end

  describe "zigzag/1" do
    test "zigzag(3)" do
      assert zigzag(3) |> Enum.take(9) == [0, 1, 2, 1, 0, 1, 2, 1, 0]
    end

    test "zigzag(4)" do
      assert zigzag(4) |> Enum.take(7) == [0, 1, 2, 3, 2, 1, 0]
    end

    test "zigzag(5)" do
      assert zigzag(5) |> Enum.take(9) == [0, 1, 2, 3, 4, 3, 2, 1, 0]
    end

    test "zigzag(6)" do
      assert zigzag(6) |> Enum.take(11) == [0, 1, 2, 3, 4, 5, 4, 3, 2, 1, 0]
    end
  end

  describe "is_caught?/1" do
    test "is_caught?({0, 3})" do
      assert is_caught?({0, 3}) == true
    end

    test "is_caught?({1, 2})" do
      assert is_caught?({1, 2}) == false
    end

    test "is_caught?({6, 4})" do
      assert is_caught?({6, 4}) == true
    end
  end

  describe "Part 1" do
    test "first example", %{:example => example} do
      assert first_half(example) == 24
    end

    test "solution", %{:input => input} do
      assert first_half(input) == 648
    end
  end

  # describe "Part 2" do
  #   test "first example", %{:example => example} do
  #     assert second_half(example) == 10
  #   end

  #   # test "solution", %{:input => input} do
  #   #   assert second_half(input) == 221
  #   # end
  # end
end
