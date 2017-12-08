# TODO: rewrite with custom tree data structor
defmodule AOC.Puzzles.N07 do
  import AOC.Puzzles.Utils
  require AOC.Puzzles.Utils

  # Build the graph from the input data
  # TODO: make sure all vertices get labels. Right now some are being
  # auto added bye add_edges.
  def build_graph(input) do
    graph = input
    # Add each program to a digraph
    |> Enum.reduce(Graph.new(), fn ({name, program}, g) ->
      g
      # Add the program to the graph
      |> Graph.add_vertex(program, "#{name}\nself: #{program.weight}")
    end)

    input
    # Add edges when there are programs above
    |> Enum.reduce(graph, fn ({name, program}, g) ->
      Graph.add_edges(
        g,
        Enum.map(
          program.above,
          fn (above_name) ->
            above = Map.get(input, above_name)
            {program, above}
          end
        )
      )
    end)
  end

  def first_half(input) do
    input
    # Build the graph
    |> build_graph()

    # Get the root
    |> Graph.arborescence_root
  end

  def second_half(input) do
    graph = input
    # Build the graph
    |> build_graph()

    # Write the graph out to a file
    {:ok, dot} = Graph.to_dot(graph)
    File.write!(
      Path.absname("/tmp/aoc_graph"),
      dot,
      [:write]
    )

    "aaa"
  end
end
