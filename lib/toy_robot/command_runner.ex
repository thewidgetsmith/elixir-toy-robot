defmodule ToyRobot.CommandRunner do
  alias ToyRobot.{Simulation, Table}

  # Handle commands marked as invalid
  def run([{:invalid, _command} | rest], simulation), do: run(rest, simulation)

  def run([:move | rest], simulation) do
    new_simulation = simulation
    |> Simulation.move
    |> case do
      {:ok, simulation} -> simulation
      {:error, :at_table_boundary} -> simulation
    end
    run(rest, new_simulation)
  end

  def run([:turn_left | rest], simulation) do
    {:ok, simulation} = simulation |> Simulation.turn_left
    run(rest, simulation)
  end

  def run([:turn_right | rest], simulation) do
    {:ok, simulation} = simulation |> Simulation.turn_right
    run(rest, simulation)
  end

  def run([:report | rest], simulation) do
    %{lcn_x: x, lcn_y: y, yaw: z} = Simulation.report(simulation)
    z = z |> Atom.to_string |> String.upcase
    IO.puts "The robot is at (#{x},#{y}) facing #{z}"

    run(rest, simulation)
  end

  def run([], simulation), do: simulation

  def run([{:place, placement} | rest]) do
    table = %Table{x_boundary: 4, y_boundary: 4}
    case Simulation.place(table, placement) do
      {:ok, simulation} -> run(rest, simulation)
      {:error, :invalid_placement} -> run(rest)
    end
  end

  def run([_command | rest]), do: run(rest)

  def run([]), do: nil
end
