defmodule AOC.Puzzles.N09 do
  ## Parse the normal non-garbage sections
  # Default values
  def parse(string), do: parse(string, 1, 0)
  # When we hit a `{` increment the depth by one and keep the count
  def parse("{" <> rest, depth, count) do
    {child_depth, count} = parse(rest, depth + 1, count)
    {depth + child_depth, count}
  end
  # When we hit a `}` increase the level by one
  def parse("}" <> rest, depth, count), do: parse(rest, depth - 1, count)
  # When we hit a `<` we are starting a garbage section. See below
  def parse("<" <> rest, depth, count), do: garbage(rest, depth, count)
  # When we hit a `,` ignore it and continue on
  def parse("," <> rest, depth, count), do: parse(rest, depth, count)
  # When we hit the end of the string, send 0 so we can unwind
  def parse("", depth, count), do: {0, count}

  ## Handle garbage sections and cancle's
  # When we hit a `!` ignore it and the next char
  def garbage("!" <> <<_::bytes-size(1)>> <> rest, depth, count),
    do: garbage(rest, depth, count)
  # When we hit a `>` the garbage section is over, go back to normal parsing
  def garbage(">" <> rest, depth, count), do: parse(rest, depth, count)
  # When we hit anything while in a garbage section,
  # ignore it and incremnt the garbage count
  def garbage(<<_::bytes-size(1)>> <> rest, depth, count),
    do: garbage(rest, depth, count + 1)

  def first_half(input) do
    elem(parse(input), 0)
  end

  def second_half(input) do
    elem(parse(input), 1)
  end
end
