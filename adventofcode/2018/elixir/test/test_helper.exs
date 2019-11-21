ExUnit.start()

defmodule AOCTest.TryThree do
  defmacro __using__(_options) do
    quote do
      IO.puts("Generating solution tests")

      name = ExUnit.Case.register_test(__ENV__, :test, "solution part 1", [])
      IO.inspect(name)
      def unquote(name)(_), do: IO.puts("IN A TEST!")
    end
  end
end

defmodule AOCTest.Haha do
  use ExUnit.CaseTemplate

  setup_all do
    IO.inspect(__MODULE__)
    input_contents = File.read!("puzzles/01/input")
    # puzzle_module = String.to_atom("Elixir.AOC.Puzzles.N#{@puzzle_number}")
    puzzle_module = String.to_atom("Elixir.AOC.Puzzles.N01")

    answer_part_1 =
      File.read!("puzzles/01/answer_part_1")
      |> String.trim()

    input =
      apply(
        puzzle_module,
        :parse,
        [input_contents]
      )

    # Send it to the test cases
    {:ok, input: input, answer_part_1: answer_part_1}
  end

  using do
    quote do
      test "solution part 1", %{:input => input, :answer_part_1 => read_answer} do
        puzzle_module = String.to_atom("Elixir.AOC.Puzzles.N01")

        computed_answer =
          apply(
            puzzle_module,
            :first_half,
            [input]
          )

        assert Kernel.inspect(computed_answer) == read_answer
      end
    end
  end
end

defmodule AOCTest.Puzzle do
  defmacro __using__(options) do
    # Set default options
    %{
      part1_parse: part1_parse,
      part2_parse: part2_parse
    } =
      Enum.into(options, %{
        part1_parse: :string,
        part2_parse: :string
      })

    quote do
      # Get puzzle number from the module name
      puzzle_number =
        ~r/Elixir\.AOCTest\.Puzzles\.N(\d+)Test/
        |> Regex.run(to_string(__MODULE__))
        |> List.last()

      Module.put_attribute(__MODULE__, :puzzle_number, puzzle_number)

      # Read the input from the file and add it to a module attribute
      input_contents = File.read!("puzzles/#{puzzle_number}/input")
      Module.put_attribute(__MODULE__, :raw_input, input_contents)

      # Parse the input using the function from the solution
      parsed_input = String.to_atom("Elixir.AOC.Puzzles.N#{@puzzle_number}")
      Module.put_attribute(__MODULE__, :parsed_input, parsed_input)

      # Read the answers into two module attributes
      AOCTest.Puzzle.read_answer(__MODULE__, "answer_part_1", puzzle_number, unquote(part1_parse))
      AOCTest.Puzzle.read_answer(__MODULE__, "answer_part_2", puzzle_number, unquote(part2_parse))

      # Generate a setup block
      setup_all do
        # Parse the input file
        input =
          apply(
            @parsed_input,
            :parse,
            [@raw_input]
          )

        # Send it to the test cases
        {:ok, input: input}
      end
    end

    # test "part 1 solution" do
    #   assert 10 != 10
    #   # assert first_half(@parsed_input) == unquote(@answer_part_1)
    # end
  end

  def read_answer(module, answer_name, puzzle_number, parse_type) do
    # Read the answer from the file
    raw_answer =
      File.read!("puzzles/#{puzzle_number}/#{answer_name}")
      |> String.trim()

    # Parse the answer if we need to
    parsed_answer =
      case parse_type do
        :integer -> String.to_integer(raw_answer)
        :string -> raw_answer
      end

    # Write the answer as a module attribute
    Module.put_attribute(
      module,
      String.to_atom(answer_name),
      parsed_answer
    )
  end
end
