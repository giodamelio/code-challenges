defmodule ProjectEuler.P0017 do
  def solve(limit) do
    1..limit
      |> Enum.map(&write_out/1)
      |> Enum.join("")
      |> String.replace(~r/\ |-/, "") # Remove spaces and dashes
      |> String.length
  end

  # Handle basic numbers
  def write_out(0), do: ""
  def write_out(1), do: "one"
  def write_out(2), do: "two"
  def write_out(3), do: "three"
  def write_out(4), do: "four"
  def write_out(5), do: "five"
  def write_out(6), do: "six"
  def write_out(7), do: "seven"
  def write_out(8), do: "eight"
  def write_out(9), do: "nine"
  def write_out(10), do: "ten"
  def write_out(11), do: "eleven"
  def write_out(12), do: "twelve"
  def write_out(13), do: "thirteen"
  def write_out(14), do: "fourteen"
  def write_out(15), do: "fifteen"
  def write_out(16), do: "sixteen"
  def write_out(17), do: "seventeen"
  def write_out(18), do: "eighteen"
  def write_out(19), do: "nineteen"
  def write_out(20), do: "twenty"
  def write_out(30), do: "thirty"
  def write_out(40), do: "forty"
  def write_out(50), do: "fifty"
  def write_out(60), do: "sixty"
  def write_out(70), do: "seventy"
  def write_out(80), do: "eighty"
  def write_out(90), do: "ninety"

  # Handle bigger numbers
  def write_out(num) do
    num
      # Convert to a list reversed list of digits with their indexes
      |> Integer.digits
      |> Enum.reverse
      |> Enum.with_index

      # Handle different places
      |> Enum.map(fn ({digit, index}) ->
        case index do
          2 -> "#{write_out(digit)}" # Hundreds place
          1 -> "#{write_out(digit * 10)}" # Tens place
          0 -> write_out(digit)
        end
      end)
      |> Enum.with_index
      # |> Enum.reduce("", fn ({digit, index}, string) ->
      #   case index do
      #     2 -> "#{write_out(digit)} hundred and " # Hundreds place
      #     1 -> "#{write_out(digit * 10)}-" # Tens place
      #     0 -> write_out(digit)
      #   end <> string
      # end)

      # Add extra bits
      |> Enum.map(fn (item) ->
        case item do
          {string, 2} -> case string do
            "" -> ""
            _ -> "#{string} hundred and "
          end
          {string, 1} -> case string do
            "" -> "#{string}"
            _ -> "#{string}-"
          end
          {string, 0} -> string
        end
      end)

      |> Enum.reverse
      |> Enum.join
  end

  def print do
    solve 1000
  end
end
