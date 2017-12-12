# TODO: reimplement without graph library
defmodule AOC.Puzzles.N12 do
  def build_graph(input) do
    input
    # Build the graph
    |> Enum.reduce(Graph.new(), fn (program, graph) ->
      # Build a list of the edges
      edges = program.connected
      |> Enum.zip(Stream.cycle([program.number]))

      Graph.add_edges(graph, edges)
    end)
  end

  def first_half(input) do
    build_graph(input)

    # Find the vertices that can reach 0
    |> Graph.reachable([0])

    # Count them
    |> length
  end

  def second_half(input) do
    build_graph(input)

    |> Graph.components
    |> length
  end
end
