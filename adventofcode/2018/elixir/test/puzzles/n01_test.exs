defmodule AOCTest.Puzzles.N01Test do
  use ExUnit.Case
  # use AOCTest.Haha
  # use AOCTest.Puzzle, part1_parse: :integer, part2_parse: :integer
  use AOCTest.TryThree

  import AOC.Puzzles.N01

  describe "Parse" do
    test "valid list" do
      assert parse("1\n-1\n1000\n-1000\n") == [1, -1, 1000, -1000]
    end
  end

  describe "Part 1" do
    test "+1, +1, +1" do
      assert first_half([1, 1, 1]) == 3
    end

    test "+1, +1, -2" do
      assert first_half([1, 1, -2]) == 0
    end

    test "-1, -2, -3" do
      assert first_half([-1, -2, -3]) == -6
    end

    # test "solution", %{:input => input} do
    #   assert first_half(input) == @answer_part_1
    # end
  end

  describe "Part 2" do
    test "+1, +1" do
      assert second_half([+1, -1]) == 0
    end

    test "+3, +3, +4, -2, -4" do
      assert second_half([3, 3, 4, -2, -4]) == 10
    end

    test "-6, +3, +8, +5, -6" do
      assert second_half([-6, 3, 8, 5, -6]) == 5
    end

    test "+7, +7, -2, -7, -4" do
      assert second_half([7, 7, -2, -7, -4]) == 14
    end

    # test "solution", %{:input => input} do
    #   assert second_half(input) == @answer_part_2
    # end
  end
end
