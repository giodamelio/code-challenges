defmodule AOCTest.Puzzles.N07Test do
  use ExUnit.Case

  import AOC.Puzzles.N07
  import AOC.Puzzles.Utils
  require AOC.Puzzles.Utils

  @regex ~r/(?<name>[a-z]+)\ \((?<weight>[0-9]+)\)(:?\ ->\ (?<above>.*))?/

  # Read the puzzle input from a file and parse it
  setup_all do
    {:ok, raw} = File.read("test/puzzles/inputs/07.txt")

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
    |> Enum.map(fn (program) ->
      program
      # Convert the programs above to a list
      |> Map.update(:above, [], &String.split(&1, ", ", trim: true))
      # Parse the weight
      |> Map.update!(:weight, &String.to_integer/1)
    end)
    # Convert into map
    |> Enum.reduce(%{}, fn (program, map) ->
      Map.put(map, program.name, program)
    end)

    # Add example to be shared between parts
    example = %{
      "pbga" => %{name: "pbga", weight: 66, above: []},
      "xhth" => %{name: "xhth", weight: 57, above: []},
      "ebii" => %{name: "ebii", weight: 61, above: []},
      "havc" => %{name: "havc", weight: 66, above: []},
      "ktlj" => %{name: "ktlj", weight: 57, above: []},
      "fwft" => %{name: "fwft", weight: 72, above: ["ktlj", "cntj", "xhth"]},
      "qoyq" => %{name: "qoyq", weight: 66, above: []},
      "padx" => %{name: "padx", weight: 45, above: ["pbga", "havc", "qoyq"]},
      "tknk" => %{name: "tknk", weight: 41, above: ["ugml", "padx", "fwft"]},
      "jptl" => %{name: "jptl", weight: 61, above: []},
      "ugml" => %{name: "ugml", weight: 68, above: ["gyxo", "ebii", "jptl"]},
      "gyxo" => %{name: "gyxo", weight: 61, above: []},
      "cntj" => %{name: "cntj", weight: 57, above: []}
    }

    {:ok, input: input, example: example}
  end


  # describe "Part 1" do
  #   test "first example", %{:example => example} do
  #     assert first_half(example).name == "tknk"
  #   end

  #   test "solution", %{:input => input} do
  #     assert first_half(input).name == "vgzejbd"
  #   end
  # end

  describe "Part 2" do
    test "first exmaple", %{:example => example} do
      assert second_half(example) == 4
    end

    # test "solution", %{:input => input} do
    #   assert second_half(input) == 1054
    # end
  end
end
