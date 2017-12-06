defmodule AOC.Puzzles.Utils do
  # Rotate a list n elements to the right looping elements
  # from the end to the start
  def rotate(list, n), do: rotate(list, n, :RIGHT)

  def rotate(list, n, :RIGHT) do
    {head, tail} = Enum.split(list, length(list) - n)
    tail ++ head
  end

  def rotate(list, n, :LEFT) do
    {head, tail} = Enum.split(list, n)
    tail ++ head
  end

  # A macro for easy debug logging

  # Debug a list of variables
  defmacro debug(variables) when is_list(variables) do
    quote bind_quoted: [
      names: variables |> Enum.map(&variable_name/1),
      values: variables
    ] do
      for {name, value} <- Enum.zip(names, values) do
        print_variable(name, value)
      end
      :ok
    end
  end

  # Debug a single variable
  defmacro debug(variable) do
    quote bind_quoted: [variable_name: variable_name(variable),
                        variable_text: variable] do
      print_variable(variable_name, variable_text)
    end
  end

  # Print out a single variable
  def print_variable(variable_name, variable_text) do
    IO.puts("#{variable_name}: #{inspect variable_text}")
  end

  # Get the name of a variable as a string
  def variable_name(variable) do
    Atom.to_string(elem(variable, 0))
  end
end
