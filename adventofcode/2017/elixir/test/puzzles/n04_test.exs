defmodule AOCTest.Puzzles.N04Test do
  use ExUnit.Case

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/04.txt")

    input = raw
    # Trim extra whitespace
    |> String.trim

    # Split by line
    |> String.split("\n")

    # Split each row by word
    |> Enum.map(&String.split/1)

    {:ok, input: input}
  end

  describe "part_one_is_valid/1" do
    test "aa bb cc dd ee" do
      assert AOC.Puzzles.N04.part_one_is_valid(["aa", "bb", "cc", "dd", "ee"]) == true
    end

    test "aa bb cc dd aa" do
      assert AOC.Puzzles.N04.part_one_is_valid(["aa", "bb", "cc", "dd", "aa"]) == false
    end

    test "aa bb cc dd aaa" do
      assert AOC.Puzzles.N04.part_one_is_valid(["aa", "bb", "cc", "dd", "aaa"]) == true
    end
  end

  describe "Part 1" do
    test "solution", %{:input => input} do
      assert AOC.Puzzles.N04.first_half(input) == 466
    end
  end

  describe "part_two_is_valid/1" do
    test "abcde fghij" do
      assert AOC.Puzzles.N04.part_two_is_valid(["abcde", "fghij"]) == true
    end

    test "abcde xyz ecdab" do
      assert AOC.Puzzles.N04.part_two_is_valid(["abcde", "xyz", "ecdab"]) == false
    end

    test "a ab abc abd abf abj" do
      assert AOC.Puzzles.N04.part_two_is_valid(["a", "ab", "abc", "abd", "abf", "abj"]) == true
    end

    test "iiii oiii ooii oooi oooo" do
      assert AOC.Puzzles.N04.part_two_is_valid(["iiii", "oiii", "ooii", "oooi", "oooo"]) == true
    end

    test "oiii ioii iioi iiio" do
      assert AOC.Puzzles.N04.part_two_is_valid(["oiii", "ioii", "iioi", "iiio"]) == false
    end
  end

  describe "Part 2" do
    test "solution", %{:input => input} do
      assert AOC.Puzzles.N04.second_half(input) == 251
    end
  end
end
