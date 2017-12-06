defmodule AOC.Puzzles.N06 do
  # Split a block into a list of blocks to be redistributed
  def split_block(block, banks_length) do
    # Create list the length of the blocks filled with zeros
    List.duplicate(1, block)
    # Split up into chucks of banks length
    # Fill any extra space with zeros
    |> Enum.chunk_every(banks_length, banks_length, Stream.cycle([0]))
    # Combine the lists into tuples
    |> Enum.zip
    # Sum each tuple
    |> Enum.map(&Enum.sum(Tuple.to_list(&1)))
  end

  def cycle(banks) do
    # Fund the index of the largest block
    # On ties smaller indexs win
    {largest_block, largest_block_index} = banks
    # Keep track of the indexes
    |> Enum.with_index
    # Only compare the number itself
    |> Enum.max_by(&(elem(&1, 0)))

    # Seperate the block based on the number of the banks
    # Then rotate the list so it's aligned with the index
    # after the largest index
    blocks_to_redistribute = largest_block
    |> split_block(length(banks))
    |> AOC.Puzzles.Utils.rotate(largest_block_index + 1)

    banks
    # Zero out the largest block
    |> List.replace_at(largest_block_index, 0)
    # Starting with the index after the largest block, redistribute the blocks
    |> Enum.zip(blocks_to_redistribute)
    |> Enum.map(&Enum.sum(Tuple.to_list(&1)))
  end

  # First run with default params
  def calculate(banks) do
    calculate(banks, Map.new(), 0)
  end

  # Keep cycling until we see a duplicate banks.
  # Also keep track of the order so we can tell
  # the difference for part two
  def calculate(banks, map, index) do
    if Map.has_key?(map, banks) do
      {map, index - Map.get(map, banks)}
    else
      calculate(cycle(banks), Map.put(map, banks, index), index + 1)
    end
  end

  def first_half(input) do
    {map, _count_since_duplicate} = calculate(input)
    length(Map.keys(map))
  end

  def second_half(input) do
    {_map, count_since_duplicate} = calculate(input)
    count_since_duplicate
  end
end
