defmodule ToyRobot.Simulation do
  alias ToyRobot.{Robot, Simulation, Table}

  defstruct [:table, :robot]

  @doc """
  Simulates placing a robot on a table

  ## Examples

  When the robot is placed in a valid position:
    iex> alias ToyRobot.{Robot, Table, Simulation}
    [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
    iex> table = %Table{x_boundary: 4, y_boundary: 4}
    %Table{x_boundary: 4, y_boundary: 4}
    iex> Simulation.place(table, %{lcn_x: 0, lcn_y: 0, yaw: :north})
    {
      :ok,
      %Simulation{
        table: table,
        robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
      }
    }

  When the robot is placed in an invalid position:
    iex> alias ToyRobot.{Table, Simulation}
    [ToyRobot.Table, ToyRobot.Simulation]
    iex> table = %Table{x_boundary: 4, y_boundary: 4}
    %Table{x_boundary: 4, y_boundary: 4}
    iex> Simulation.place(table, %{lcn_x: 0, lcn_y: 6, yaw: :north})
    {:error, :invalid_placement}
  """
  def place(table, placement) do
    if table |> Table.valid_position?(placement) do
      {
        :ok,
        %__MODULE__{
          table: table,
          robot: struct(Robot, placement)
        }
      }
    else
      {
        :error,
        :invalid_placement
      }
    end

  end
end
