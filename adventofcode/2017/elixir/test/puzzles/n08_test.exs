defmodule AOCTest.Puzzles.N08Test do
  use ExUnit.Case

  import AOC.Puzzles.N08

  @regex ~r/(?<register>\w+)\ (?<operation>(?:inc|dec))\ (?<amount>-?\d+)\ if\ (?<comparison_register>\w+)\ (?<comparison_operator>(?:==|!=|<|>|<=|>=))\ (?<comparison_value>-?\d+)/

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/08.txt")

    input = raw
    # Trim surronding whitespace
    |> String.trim
    # Split by line
    |> String.split("\n")
    # Parse each line with regex
    |> Enum.map(&Regex.named_captures(@regex, &1))
    # Convert the map keys to atoms
    |> Enum.map(fn (program) ->
      Enum.reduce(program, %{}, fn ({key, val}, acc) ->
        Map.put(acc, String.to_atom(key), val)
      end)
    end)
    # Parse some of the values further
    |> Enum.map(fn (line) ->
      line
      # Convert the operations to atoms
      |> Map.update!(:operation, fn (op) ->
        op |> String.upcase |> String.to_atom
      end)
      # Parse some numbers
      |> Map.update!(:amount, &String.to_integer/1)
      |> Map.update!(:comparison_value, &String.to_integer/1)
      # Convert comparison operator to atom
      |> Map.update!(:comparison_operator, fn (operator) ->
        case operator do
          "==" -> :==
          "!=" -> :!=
          ">"  -> :>
          "<"  -> :<
          ">=" -> :>=
          "<=" -> :<=
        end
      end)
    end)

    # Example to be shared between parts one and two
    example = [
      %{:amount => 5,
        :comparison_operator => :>,
        :comparison_register => "a",
        :comparison_value => 1,
        :operation => :INC,
        :register => "b"},
      %{:amount => 1,
        :comparison_operator => :<,
        :comparison_register => "b",
        :comparison_value => 5,
        :operation => :INC,
        :register => "a"},
      %{:amount => -10,
        :comparison_operator => :>=,
        :comparison_register => "a",
        :comparison_value => 1,
        :operation => :DEC,
        :register => "c"},
      %{:amount => -20,
        :comparison_operator => :==,
        :comparison_register => "c",
        :comparison_value => 10,
        :operation => :INC,
        :register => "c"}]

    {:ok, input: input, example: example}
  end

  describe "Part 1" do
    test "First example", %{:example => example} do
      assert first_half(example) == 1
    end

    test "solution", %{:input => input} do
      assert first_half(input) == 3612
    end
  end

  describe "Part 2" do
    test "First example", %{:example => example} do
      assert second_half(example) == 10
    end

    test "solution", %{:input => input} do
      assert second_half(input) == 3818
    end
  end
end
