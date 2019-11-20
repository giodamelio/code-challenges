defmodule AOC.Puzzles.N03 do
  @item_regex ~r/#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)/
  def parse_item(line) do
    @item_regex
    # Parse the line into a map
    |> Regex.named_captures(line)
    # Convert the map keys into atoms and the values into integers
    |> Map.new(fn {key, value} ->
      {String.to_atom(key), String.to_integer(value)}
    end)
  end

  def parse(input) do
    input
    # Trim surronding whitespace and newlines
    |> String.trim
    # Split on each line
    |> String.split("\n")
    # Parse each line
    |> Enum.map(&parse_item/1)
  end

  def add_claim_to_fabric(claim, fabric) do
    # Create a list of coords that is claimed
    coords_list = for x <- (claim.x)..(claim.x + claim.width - 1),
                      y <- (claim.y)..(claim.y + claim.height - 1) do
      {x, y}
    end

    coords_list
    # Go through the coords and add them to the fabric
    |> Enum.reduce(fabric, fn coord, f ->
      Map.update(f, coord, MapSet.new([claim.id]), &MapSet.put(&1, claim.id))
    end)
  end

  def first_half(input) do
    input
    # Start with an empty fabric and fill it with the squares from the input
    |> Enum.reduce(%{}, &add_claim_to_fabric/2)
    # Get just the values
    |> Map.values
    # Keep just the ones with more then one claim
    |> Enum.filter(&(MapSet.size(&1) > 1))
    # Count them
    |> Enum.count
  end

  def second_half(input) do
    max_id = List.last(input).id
    ids_in_fabric = MapSet.new(1..max_id)

    input
    # Start with an empty fabric and fill it with the squares from the input
    |> Enum.reduce(%{}, &add_claim_to_fabric/2)
    # Get just the values
    |> Map.values
    # Keep just the ones with more then one claim
    |> Enum.filter(&(MapSet.size(&1) > 1))
    # Remove any ids that claim a shared spot from the list of all ids
    |> Enum.reduce(ids_in_fabric, fn claim_ids, remaining_ids ->
      MapSet.difference(remaining_ids, claim_ids)
    end)
    # Get the single remaining id
    |> MapSet.to_list
    |> List.first
  end
end
