defmodule ToyRobot.CommandInterpreter do
  @doc """
  Maps commands from a commands list to executable actions.

  ## Examples
    iex> alias ToyRobot.CommandInterpreter
    ToyRobot.CommandInterpreter
    iex> commands = ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "REPORT"]
    ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "REPORT"]
    iex> commands |> CommandInterpreter.interpret
    [
      {:place, %{lcn_x: 1, lcn_y: 2, yaw: :north}},
      :move,
      :turn_left,
      :turn_right,
      :report
    ]
  """
  def interpret(commands) do
    commands |> Enum.map(&String.upcase/1) |> Enum.map(&do_interpret/1)
  end

  defp do_interpret("PLACE " <> rest) do
    [lcn_x, lcn_y, yaw] = rest |> String.split(",")
    to_int = &String.to_integer/1

    {:place, %{
      lcn_x: to_int.(lcn_x),
      lcn_y: to_int.(lcn_y),
      yaw: yaw |> String.downcase |> String.to_atom
    }}
  end

  defp do_interpret("MOVE"), do: :move
  defp do_interpret("LEFT"), do: :turn_left
  defp do_interpret("RIGHT"), do: :turn_right
  defp do_interpret("REPORT"), do: :report
  defp do_interpret(command), do: {:invalid, command}
end
