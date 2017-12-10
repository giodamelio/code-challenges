defmodule AOCTest.Puzzles.N09Test do
  use ExUnit.Case

  import AOC.Puzzles.N09

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/09.txt")

    input = raw
    # Trim surronding whitespace and newlines
    |> String.trim

    {:ok, input: input}
  end

  describe "Part 1" do
    test "first example" do
      assert first_half("{{}}") == 3
    end

    test "second example" do
      assert first_half("{{{},{},{{}}}}") == 16
    end

    test "third example" do
      assert first_half("{<a>,<a>,<a>,<a>}") == 1
    

    test "solution", %{:input => input} do
      assert first_half(input) == 8337
    end
  end

  describe "Part 2" do
    test "first example" do
      assert second_half("{<random characters>}") == 17
    end

    test "second example" do
      assert second_half(~s(<{o"i!a,<{i<a>)) == 10
    end

    test "solution", %{:input => input} do
      assert second_half(input) == 4330
    end
  end
end
