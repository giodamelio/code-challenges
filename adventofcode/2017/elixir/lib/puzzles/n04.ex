defmodule AOC.Puzzles.N04 do
  def part_one_is_valid(passphrase) do
    Enum.count(passphrase) === Enum.count(Enum.uniq(passphrase))
  end

  def part_two_is_valid(passphrase) do
    unique_passphrases = passphrase
    # Split each passphrase by char
    |> Enum.map(&String.codepoints/1)

    # Sort them
    |> Enum.map(&Enum.sort/1)

    # Find unique passphrases
    |> Enum.uniq

    Enum.count(passphrase) == Enum.count(unique_passphrases)
  end

  def first_half(input) do
    input
    # Check which passphrases are valid
    |> Enum.filter(&part_one_is_valid/1)

    # Count them
    |> Enum.count
  end

  def second_half(input) do
    input
    # Check which passphrases are valid
    |> Enum.filter(&part_two_is_valid/1)

    # Count them
    |> Enum.count
  end
end
