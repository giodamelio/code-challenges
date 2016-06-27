defmodule ProjectEulerTest do
  use ExUnit.Case, async: true
  doctest ProjectEuler.Mathlib
  doctest ProjectEuler.Mathlib.Prime

  test "Problem 1" do
    assert ProjectEuler.P0001.solve(1000) == 233168
  end

  test "Problem 2" do
    assert ProjectEuler.P0002.solve(4000000) == 4613732
  end

  test "Problem 3" do
    assert ProjectEuler.P0003.solve(600851475143) == 6857
  end

  test "Problem 4" do
    assert ProjectEuler.P0004.solve(999) == 906609
  end

  test "Problem 5" do
    assert ProjectEuler.P0005.solve(20) == 232792560
  end

  test "Problem 6" do
    assert ProjectEuler.P0006.solve(100) == 25164150
  end

  @tag slow: true
  test "Problem 7" do
    assert ProjectEuler.P0007.solve(10001) == 104743
  end

  test "Problem 8" do
    assert ProjectEuler.P0008.solve(13) == 23514624000
  end

  @tag slow: true
  test "Problem 9" do
    assert ProjectEuler.P0009.solve(1000) == 31875000
  end
end
