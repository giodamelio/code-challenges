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
        ~s(\e[1mhello\e[22m: \e[33m"world"\e[0m\n\n)
    end

    test "print a list" do
      numbers = [1, 2, 3, 4]
      assert capture_io(fn () -> debug(numbers) end) ==
        ~s(\e[1mnumbers\e[22m: [\n  \e[37m[0] \e[0m\e[34m1\e[0m\n  \e[37m[1] \e[0m\e[34m2\e[0m\n  \e[37m[2] \e[0m\e[34m3\e[0m\n  \e[37m[3] \e[0m\e[34m4\e[0m\n]\n\n)
    end

    test "debug multiple variables" do
      numbers = [1, 2, 3, 4]
      letters = ["a", "b", "c", "d"]


      assert capture_io(fn () -> debug([numbers, letters]) end) ==
        ~s(\e[1mnumbers\e[22m: [\n  \e[37m[0] \e[0m\e[34m1\e[0m\n  \e[37m[1] \e[0m\e[34m2\e[0m\n  \e[37m[2] \e[0m\e[34m3\e[0m\n  \e[37m[3] \e[0m\e[34m4\e[0m\n]\n\n\e[1mletters\e[22m: [\n  \e[37m[0] \e[0m\e[33m"a"\e[0m\n  \e[37m[1] \e[0m\e[33m"b"\e[0m\n  \e[37m[2] \e[0m\e[33m"c"\e[0m\n  \e[37m[3] \e[0m\e[33m"d"\e[0m\n]\n\n)
    end
  end

  describe "print_variable/1" do
    test "print a name and variable" do
      assert capture_io(fn () -> print_variable("haha", [1, 2, 3]) end) ==
        ~s(\e[1mhaha\e[22m: [\n  \e[37m[0] \e[0m\e[34m1\e[0m\n  \e[37m[1] \e[0m\e[34m2\e[0m\n  \e[37m[2] \e[0m\e[34m3\e[0m\n]\n\n)
    end
  end

  describe "variable_name/1" do
    test "get the name of a variable" do
      assert variable_name({:hello, [], nil}) == "hello"
    end
  end
end
