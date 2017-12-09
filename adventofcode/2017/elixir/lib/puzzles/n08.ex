defmodule AOC.Puzzles.N08 do
  def run(input) do
    {:ok, registry} = Registers.start_link([])

    input
    |> Enum.map(fn (op) ->
      should_run = Registers.op(
        registry,
        :COMPARE,
        {op.comparison_register,
         op.comparison_operator,
         op.comparison_value}
      )

      if should_run do
        Registers.op(registry, op.operation, {op.register, op.amount})
      end
    end)

    registry
  end

  def first_half(input) do
    registry = run(input)

    {_register, value} = registry
    # Dump the registers map
    |> Registers.dump()
    # Find the largest register
    |> Enum.max_by(&elem(&1, 1))

    value
  end

  def second_half(input) do
    registry = run(input)

    Registers.max(registry)
  end
end

defmodule Registers do
  use GenServer

  #### Client API ####

  # Start a set of registers
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  # Run a operation
  def op(server, name, data) do
    GenServer.call(server, {:OP, name, data})
  end

  # Dump the contents of all the registers
  def dump(server) do
    GenServer.call(server, :DUMP)
  end

  # Get the largest a register has ever been
  def max(server) do
    GenServer.call(server, :MAX)
  end

  #### Helpers ####

  # Put a value to a map and track the max value
  def put_and_track_max(map, key, value, max) do
    {Map.put(map, key, value),
    (if value > max, do: value, else: max)}
  end

  #### Server Callbacks ####

  # Start with an empty Map of registers and a max value of 0
  def init(:ok) do
    {:ok, {%{}, 0}}
  end

  # Dump all the registers
  def handle_call(:DUMP, _from, {registers, max}) do
    {:reply, registers, {registers, max}}
  end

  # Return the largest a register has ever been
  def handle_call(:MAX, _from, {registers, max}) do
    {:reply, max, {registers, max}}
  end

  # Increment a register
  def handle_call({:OP, :INC, {register, amount}}, _from, {registers, max}) do
    value = Map.get(registers, register, 0)
    {new_registers, new_max} =
      put_and_track_max(registers, register, value + amount, max)

    {:reply, :ok, {new_registers, new_max}}
  end

  # Decrement a register
  def handle_call({:OP, :DEC, {register, amount}}, _from, {registers, max}) do
    value = Map.get(registers, register, 0)
    {new_registers, new_max} =
      put_and_track_max(registers, register, value - amount, max)

    {:reply, :ok, {new_registers, new_max}}
  end

  # Compare a register to a value
  def handle_call({:OP,
                   :COMPARE,
                   {register, operator, value}}, _from, {registers, max}) do
    register_value = Map.get(registers, register, 0)

    {:reply,
     apply(Kernel, operator, [register_value, value]),
     {registers, max}}
  end
end
