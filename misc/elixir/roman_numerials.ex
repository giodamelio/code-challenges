defmodule RomanNumerials do
  def encode(num) do
    num
      |> Integer.digits

      # Create an invalid roman numerial without max of three letters in a row
      |> Enum.zip(["M", "C", "X", "I"])
      |> Enum.map(fn ({repeat, char}) ->
        String.duplicate(char, repeat)
      end)

      # Crush down the numerials to proper four and five chars
      |> Enum.map(&RomanNumerials.squish/1)

      |> Enum.join("")
  end

  # Squish down a set of one romen numerial to the most compact form possable
  def squish(numerials) do
    numerial = String.at(numerials, 0)
    case String.length(numerials) do
      9 -> case numerial do
        "I" -> "VIIII"
        "X" -> "LXXXX"
        "C" -> "DCCCC"
      end

      8 -> case numerial do
        "I" -> "VIII"
        "X" -> "LXXX"
        "C" -> "DCCC"
      end

      7 -> case numerial do
        "I" -> "VII"
        "X" -> "LXX"
        "C" -> "DCC"
      end

      6 -> case numerial do
        "I" -> "VI"
        "X" -> "LX"
        "C" -> "DC"
      end

      5 -> case numerial do
        "I" -> "V"
        "X" -> "L"
        "C" -> "D"
      end

      4 -> case numerial do
        "I" -> "IV"
        "X" -> "XL"
        "C" -> "CD"
      end

      # Otherwise leave it as is
      _ -> numerials
    end
  end
end

ExUnit.start

defmodule RomanNumerialsTest do
  use ExUnit.Case, async: true

  test "2345 = MMCCCXLV" do
    assert RomanNumerials.encode(2345) == "MMCCCXLV", "Incorrect roman numerials"
  end

  test "3485 = MMCCCXLV" do
    assert RomanNumerials.encode(3485) == "MMMCDLXXXV", "Incorrect roman numerials"
  end

  test "3892 = MMMDCCCXCII" do
    assert RomanNumerials.encode(3892) == "MMMDCCCXCII", "Incorrect roman numerials"
  end
end
