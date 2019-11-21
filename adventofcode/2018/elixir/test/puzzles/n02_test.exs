defmodule AOCTest.Puzzles.N02Test do
  use ExUnit.Case

  import AOC.Puzzles.N02

  @example_1_input ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
  @example_2_input ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/02.txt")

    input = parse(raw)

    {:ok, input: input}
  end

  describe "Parse" do
    test "valid list" do
      assert parse("aaaa\nbbbb\ncccc\ndddd\n") == ["aaaa", "bbbb", "cccc", "dddd"]
    end
  end

  describe "letter_counts" do
    test "a few repeats" do
      assert letter_counts("bababc") == %{
               "a" => 2,
               "b" => 3,
               "c" => 1
             }
    end

    test "no repeats" do
      assert letter_counts("abcdef") == %{
               "a" => 1,
               "b" => 1,
               "c" => 1,
               "d" => 1,
               "e" => 1,
               "f" => 1
             }
    end
  end

  describe "Part 1" do
    test "example 1" do
      assert first_half(@example_1_input) == 12
    end

    test "solution", %{:input => input} do
      assert first_half(input) == 5704
    end
  end

  describe "Part 2" do
    test "example 1" do
      assert second_half(@example_2_input) == "fgij"
    end

    test "solution", %{:input => input} do
      assert second_half(input) == "umdryabviapkozistwcnihjqx"
    end
  end
end
