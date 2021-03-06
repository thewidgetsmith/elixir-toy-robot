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

  @doc """
  Moves the robot forward one space in the direction that it is facing unless
  that movement will place the robot beyond the boundaries of the table.

  ## Examples

  ### A valid movement
    iex> alias ToyRobot.{Robot, Table, Simulation}
    [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
    iex> table = %Table{x_boundary: 4, y_boundary: 4}
    %Table{x_boundary: 4, y_boundary: 4}
    iex> simulation = %Simulation{
    ...>   table: table,
    ...>   robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
    ...> }
    iex> simulation |> Simulation.move
    {:ok, %Simulation{
      table: table,
      robot: %Robot{lcn_x: 0, lcn_y: 1, yaw: :north}
    }}

  ### An invalid movement:
    iex> alias ToyRobot.{Robot, Table, Simulation}
    [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
    iex> table = %Table{x_boundary: 4, y_boundary: 4}
    %Table{x_boundary: 4, y_boundary: 4}
    iex> simulation = %Simulation{
    ...>   table: table,
    ...>   robot: %Robot{lcn_x: 0, lcn_y: 4, yaw: :north}
    ...> }
    iex> simulation |> Simulation.move
    {:error, :at_table_boundary}
  """
  def move(%{robot: robot, table: table} = simulation) do
    with moved_robot <- robot |> Robot.move(),
         true <- table |> Table.valid_position?(moved_robot) do
      {:ok, %{simulation | robot: moved_robot}}
    else
      false -> {:error, :at_table_boundary}
    end
  end

  @doc """
  Turns the robot left.

  ## Examples
    iex> alias ToyRobot.{Robot, Table, Simulation}
    [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
    iex> table = %Table{x_boundary: 4, y_boundary: 4}
    %Table{x_boundary: 4, y_boundary: 4}
    iex> simulation = %Simulation{
    ...>   table: table,
    ...>   robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
    ...> }
    iex> simulation |> Simulation.turn_left
    {:ok, %Simulation{
      table: table,
      robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :west}
    }}
  """
  def turn_left(%Simulation{robot: robot} = simulation) do
    {:ok, %{simulation | robot: robot |> Robot.turn_left()}}
  end

  @doc """
  Turns the robot right.

  ## Examples
    iex> alias ToyRobot.{Robot, Table, Simulation}
    [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
    iex> table = %Table{x_boundary: 4, y_boundary: 4}
    %Table{x_boundary: 4, y_boundary: 4}
    iex> simulation = %Simulation{
    ...>   table: table,
    ...>   robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
    ...> }
    iex> simulation |> Simulation.turn_right
    {:ok, %Simulation{
      table: table,
      robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :east}
    }}
  """
  def turn_right(%Simulation{robot: robot} = simulation) do
    {:ok, %{simulation | robot: robot |> Robot.turn_right()}}
  end

  @doc """
  Turns the robot around to face the opposite direction.

  ## Examples
    iex> alias ToyRobot.{Robot, Table, Simulation}
    [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
    iex> table = %Table{x_boundary: 4, y_boundary: 4}
    %Table{x_boundary: 4, y_boundary: 4}
    iex> simulation = %Simulation{
    ...>   table: table,
    ...>   robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
    ...> }
    iex> simulation |> Simulation.turn_around
    {:ok, %Simulation{
      table: table,
      robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :south}
    }}
  """
  def turn_around(%Simulation{robot: robot} = simulation) do
    {:ok, %{simulation | robot: robot |> Robot.turn_around()}}
  end

  @doc """
  Returns the robot's current position and orientation on the table.

  ## Examples
    iex> alias ToyRobot.{Robot, Table, Simulation}
    [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
    iex> table = %Table{x_boundary: 4, y_boundary: 4}
    %Table{x_boundary: 4, y_boundary: 4}
    iex> simulation = %Simulation{
    ...>   table: table,
    ...>   robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
    ...> }
    iex> simulation |> Simulation.report
    %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
  """
  def report(%Simulation{robot: robot}), do: robot

  @doc """
  Shows where the robot would move next.

  ## Examples
      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{x_boundary: 5, y_boundary: 5}
      %Table{x_boundary: 5, y_boundary: 5}
      iex> simulation = %Simulation{
      ...>  table: table,
      ...>  robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
      ...> }
      iex> simulation |> Simulation.next_position
      %Robot{lcn_x: 0, lcn_y: 1, yaw: :north}
  """
  def next_position(%{robot: robot} = _simulation) do
    robot |> Robot.move
  end
end
