defmodule AOCTest.Puzzles.N03Test do
  use ExUnit.Case

  import AOC.Puzzles.N03

  @example_value [
    %{:id => 1, :height => 4, :width => 4, :x => 1, :y => 3},
    %{:id => 2, :height => 4, :width => 4, :x => 3, :y => 1},
    %{:id => 3, :height => 2, :width => 2, :x => 5, :y => 5}
  ]

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/03.txt")

    input = parse(raw)

    {:ok, input: input}
  end

  describe "Parse" do
    test "valid list" do
      assert parse("#1259 @ 539,805: 22x15\n#1260 @ 221,626: 15x24\n#1261 @ 340,845: 13x24\n") == [
        %{
          :id => 1259,
          :height => 15,
          :width => 22,
          :x => 539,
          :y => 805
        },
        %{
          :id => 1260,
          :height => 24,
          :width => 15,
          :x => 221,
          :y => 626
        },
        %{
          :id => 1261,
          :height => 24,
          :width => 13,
          :x => 340,
          :y => 845
        }
      ]
    end

    test "parse item" do
      assert parse_item("#1 @ 1,3: 4x4") == %{
        :id => 1,
        :height => 4,
        :width => 4,
        :x => 1,
        :y => 3
      }
    end
  end

  describe "add_claim_to_fabric" do
    test "add simple claim to empty fabric" do
      assert add_claim_to_fabric(
        %{:id => 1, :height => 2, :width => 2, :x => 1, :y => 1},
        %{}
      ) == %{
        {1, 1} => MapSet.new([1]),
        {1, 2} => MapSet.new([1]),
        {2, 1} => MapSet.new([1]),
        {2, 2} => MapSet.new([1])
      }
    end

    test "add claim overlapping existing claim" do
      assert add_claim_to_fabric(
        %{:id => 2, :height => 2, :width => 2, :x => 2, :y => 2},
        %{
          {1, 1} => MapSet.new([1]),
          {1, 2} => MapSet.new([1]),
          {2, 1} => MapSet.new([1]),
          {2, 2} => MapSet.new([1])
        }
      ) == %{
        {1, 1} => MapSet.new([1]),
        {1, 2} => MapSet.new([1]),
        {2, 1} => MapSet.new([1]),
        {2, 2} => MapSet.new([1, 2]),
        {2, 3} => MapSet.new([2]),
        {3, 2} => MapSet.new([2]),
        {3, 3} => MapSet.new([2]),
      }
    end
  end

  describe "Part 1" do
    test "example 1" do
      assert first_half(@example_value) == 4
    end

    test "solution", %{:input => input} do
      assert first_half(input) == 110891
    end
  end

  describe "Part 2" do
    test "example 1" do
      assert second_half(@example_value) == 3
    end

    test "solution", %{:input => input} do
      assert second_half(input) == 297
    end
  end
end
