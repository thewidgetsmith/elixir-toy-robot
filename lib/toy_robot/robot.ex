defmodule ToyRobot.Robot do
  alias ToyRobot.Robot

  defstruct [lcn_y: 0, lcn_x: 0, yaw: :north]

  @doc """
  Moves the robot forward one space in the direction it is pointing.

  ## Examples
    iex> alias ToyRobot.Robot
    ToyRobot.Robot
    iex> robot = %Robot{lcn_y: 0, yaw: :north}
    %Robot{lcn_y: 0, yaw: :north}
    iex> robot |> Robot.move
    %Robot{lcn_y: 1}
  """
  def move(%Robot{yaw: yaw} = robot) do
    case yaw do
      :north -> robot |> move_north
      :south -> robot |> move_south
      :east -> robot |> move_east
      :west -> robot |> move_west
    end
  end

  @doc """
  Turns the robot left.

  ## Examples
    iex> alias ToyRobot.Robot
    ToyRobot.Robot
    iex> robot = %Robot{yaw: :north}
    %Robot{yaw: :north}
    iex> robot |> Robot.turn_left
    %Robot{yaw: :west}
  """
  def turn_left(%Robot{yaw: yaw} = robot) do
    new_yaw = case yaw do
      :north -> :west
      :south -> :east
      :east -> :north
      :west -> :south
    end

    %Robot{robot | yaw: new_yaw}
  end

  @doc """
  Turns the robot right.

  ## Examples
    iex> alias ToyRobot.Robot
    ToyRobot.Robot
    iex> robot = %Robot{yaw: :north}
    %Robot{yaw: :north}
    iex> robot |> Robot.turn_right
    %Robot{yaw: :east}
  """
  def turn_right(%Robot{yaw: yaw} = robot) do
    new_yaw = case yaw do
      :north -> :east
      :south -> :west
      :east -> :south
      :west -> :north
    end

    %Robot{robot | yaw: new_yaw}
  end

  @doc """
  Turns around to face the opposite direction.

  ## Examples
    iex> alias ToyRobot.Robot
    ToyRobot.Robot
    iex> robot = %Robot{yaw: :north}
    %Robot{yaw: :north}
    iex> robot |> Robot.turn_around
    %Robot{yaw: :south}
  """
  def turn_around(%Robot{yaw: yaw} = robot) do
    new_yaw = case yaw do
      :north -> :south
      :south -> :north
      :east -> :west
      :west -> :east
    end

    %Robot{robot | yaw: new_yaw}
  end

  defp move_north(%Robot{} = robot) do
    %Robot{robot | lcn_y: robot.lcn_y + 1}
  end

  defp move_south(%Robot{} = robot) do
    %Robot{robot | lcn_y: robot.lcn_y - 1}
  end

  defp move_east(%Robot{} = robot) do
    %Robot{robot | lcn_x: robot.lcn_x + 1}
  end

  defp move_west(%Robot{} = robot) do
    %Robot{robot | lcn_x: robot.lcn_x - 1}
  end
end
