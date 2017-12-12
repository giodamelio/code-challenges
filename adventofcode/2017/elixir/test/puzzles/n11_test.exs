defmodule AOCTest.Puzzles.N11Test do
  use ExUnit.Case

  import AOC.Puzzles.N11

  import AOC.Puzzles.Utils
  require AOC.Puzzles.Utils

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/11.txt")

    input = raw
    # Trim surronding whitespace and newlines
    |> String.trim

    # Split by comma
    |> String.split(",")

    # Convert to uppercase
    |> Enum.map(&String.upcase/1)

    # Convert to atoms
    |> Enum.map(&String.to_atom/1)

    {:ok, input: input}
  end

  describe "Part 1" do
    test "first example" do
      assert first_half([:NE, :NE, :NE]) == 3
    end

    test "second example" do
      assert first_half([:NE, :NE, :SW, :SW]) == 0
    end

    test "third example" do
      assert first_half([:NE, :NE, :S, :S]) == 2
    end

    test "fourth example" do
      assert first_half([:SE, :SW, :SE, :SW, :SW]) == 3
    end

    test "solution", %{:input => input} do
      assert first_half(input) == 818
    end
  end

  describe "Part 2" do
    test "solution", %{:input => input} do
      assert second_half(input) == 1596
    end
  end
end
