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

  describe "delete_canceled/1" do
    test "delete some canceled chars" do
      assert delete_canceled("{!<<>, {!}}}") == "{<>, {}}"
    end

    test "canceled cancel chars" do
      assert delete_canceled("{{<!!>},{<!!>},{<!!>},{<!!>}}") ==
        "{{<>},{<>},{<>},{<>}}"
    end

    test "no canceled chars" do
      assert delete_canceled("{<>, {}}") == "{<>, {}}"
    end
  end

  describe "delete_garbage/1" do
    test "delete garbage sections" do
      assert delete_garbage("{{<},{<},{<},{<a>}}") == "{{}}"
    end
  end

  describe "delete_extra_commas/1" do
    test "delete some extra commas" do
      assert delete_extra_commas("{,,,}") == "{}"
    end
  end

  describe "convert_to_lists" do
    test "convert atoms to lists" do
      assert convert_to_lists("{{},{},{{}}}") == "[[],[],[[]]]"
    end
  end

  describe "count_groups/1" do
    test "empty group" do
      assert count_groups([]) == 1
    end

    test "(1 * 1) + (2 * 2) == 5" do
      assert count_groups([[],[]]) == 5
    end

    test "(1 * 1) + (2 * 1) + (3 * 3) + (4 * 1)" do
      assert count_groups([[[],[],[[]]]]) == 16
    end
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
    end

    test "solution", %{:input => input} do
      assert first_half(input) == 1044
    end
  end

  # describe "Part 2" do
  #   test "" do
  #     assert second_half() == 6
  #   end

  #   test "solution", %{:input => input} do
  #     assert second_half(input) == 1054
  #   end
  # end
end
