defmodule AOCTest.Puzzles.UtilsTest do
  use ExUnit.Case

  import AOC.Puzzles.Utils

  describe "rotate/2" do
    test "rotates right by default" do
      assert rotate([1, 2, 3, 4, 5, 6], 2) == [5, 6, 1, 2, 3, 4]
    end
  end

  describe "rotate/3" do
    test "rotate 2 right" do
      assert rotate([1, 2, 3, 4, 5, 6], 2, :RIGHT) == [5, 6, 1, 2, 3, 4]
    end

    test "rotate 2 left" do
      assert rotate([1, 2, 3, 4, 5, 6], 2, :LEFT) == [3, 4, 5, 6, 1, 2]
    end
  end
end
