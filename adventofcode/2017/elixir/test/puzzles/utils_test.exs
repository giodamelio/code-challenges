defmodule AOCTest.Puzzles.UtilsTest do
  use ExUnit.Case

  import AOC.Puzzles.Utils
  import ExUnit.CaptureIO

  require AOC.Puzzles.Utils

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

  describe "debug/1" do
    test "print a variable" do
      hello = "world"
      assert capture_io(fn () -> debug(hello) end) ==
        ~s(\e[1mhello\e[22m: "world"\n)
    end

    test "print a list" do
      numbers = [1, 2, 3, 4]
      assert capture_io(fn () -> debug(numbers) end) ==
        ~s(\e[1mnumbers\e[22m: [1, 2, 3, 4]\n)
    end

    test "debug multiple variables" do
      numbers = [1, 2, 3, 4]
      letters = ["a", "b", "c", "d"]

      assert capture_io(fn () -> debug([numbers, letters]) end) ==
        ~s(\e[1mnumbers\e[22m: [1, 2, 3, 4]\n\e[1mletters\e[22m: ["a", "b", "c", "d"]\n)
    end
  end

  describe "print_variable/1" do
    test "print a name and variable" do
      assert capture_io(fn () -> print_variable("haha", [1, 2, 3]) end) ==
        ~s(\e[1mhaha\e[22m: [1, 2, 3]\n)
    end
  end

  describe "variable_name/1" do
    test "get the name of a variable" do
      assert variable_name({:hello, [], nil}) == "hello"
    end
  end
end
