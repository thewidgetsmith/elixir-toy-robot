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
    # All commands must be in upcase, all lower and mixed case commands will be ignored
    # commands |> Enum.map(&String.upcase/1) |> Enum.map(&do_interpret/1)
    commands |> Enum.map(&do_interpret/1)
  end

  defp do_interpret("PLACE" <> _rest = command) do
    format = ~r/\APLACE (\d+),(\d+),(NORTH|SOUTH|EAST|WEST)\z/

    case Regex.run(format, command) do
      [_command, lcn_x, lcn_y, yaw] ->
        to_int = &String.to_integer/1

        {:place,
         %{
           lcn_x: to_int.(lcn_x),
           lcn_y: to_int.(lcn_y),
           yaw: yaw |> String.downcase() |> String.to_atom()
         }}

      nil ->
        {:invalid, command}
    end
  end

  defp do_interpret("MOVE"), do: :move
  defp do_interpret("LEFT"), do: :turn_left
  defp do_interpret("RIGHT"), do: :turn_right
  defp do_interpret("UTURN"), do: :turn_around
  defp do_interpret("REPORT"), do: :report
  defp do_interpret(command), do: {:invalid, command}
end
