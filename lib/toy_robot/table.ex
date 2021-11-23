defmodule ToyRobot.Table do
  alias ToyRobot.Table

  defstruct [:x_boundary, :y_boundary]

  @doc """
  Determines whether a position would be within the table's boundaries.

  ## Examples
    iex> alias ToyRobot.Table
    ToyRobot.Table
    iex> table = %Table{x_boundary: 4, y_boundary: 4}
    %Table{x_boundary: 4, y_boundary: 4}
    iex> table |> Table.valid_position?(%{lcn_x: 4, lcn_y: 4})
    true
    iex> table |> Table.valid_position?(%{lcn_x: 0, lcn_y: 0})
    true
    iex> table |> Table.valid_position?(%{lcn_x: 0, lcn_y: 6})
    false
  """
  def valid_position?(
        %Table{x_boundary: x_boundary, y_boundary: y_boundary},
        %{lcn_x: lcn_x, lcn_y: lcn_y}
      ) do
    lcn_x >= 0 && lcn_x <= x_boundary &&
      lcn_y >= 0 && lcn_y <= y_boundary
  end

  @doc """
  Returns all valid positions within a table's boundaries.

  ## Examples
      iex> alias ToyRobot.Table
      ToyRobot.Table
      iex> table = %Table{x_boundary: 1, y_boundary: 1}
      %Table{x_boundary: 1, y_boundary: 1}
      iex> table |> Table.valid_positions
      [
        %{lcn_x: 0, lcn_y: 0},
        %{lcn_x: 0, lcn_y: 1},
        %{lcn_x: 1, lcn_y: 0},
        %{lcn_x: 1, lcn_y: 1}
      ]
  """
  def valid_positions(
    %Table{x_boundary: xb, y_boundary: yb}
  ) do
    for x <- 0..xb, y <- 0..yb do
      %{lcn_x: x, lcn_y: y}
    end
  end
end
