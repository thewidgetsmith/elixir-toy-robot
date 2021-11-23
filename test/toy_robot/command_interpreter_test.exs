defmodule ToyRobot.CommandInterpreterTest do
  use ExUnit.Case, async: true
  doctest ToyRobot.CommandInterpreter

  alias ToyRobot.CommandInterpreter

  test "handles all possible commands" do
    commands = ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "UTURN", "REPORT"]
    commands |> CommandInterpreter.interpret()
  end

  # All commands must be in upcase, all lower and mixed case commands will be ignored
  # test "handles upper, lower and mixed case commands" do
  #   commands = ["place 1,2,NORth", "MOVE", "lEfT", "right", "REPort"]
  #   commands |> CommandInterpreter.interpret
  # end

  test "marks invalid commands as invalid" do
    commands = ["SPIN", "TWIRL", "EXTERMINATE", "PLACE 1, 2, NORTH", "move", "MoVe"]
    output = commands |> CommandInterpreter.interpret()

    assert output == [
             {:invalid, "SPIN"},
             {:invalid, "TWIRL"},
             {:invalid, "EXTERMINATE"},
             {:invalid, "PLACE 1, 2, NORTH"},
             {:invalid, "move"},
             {:invalid, "MoVe"}
           ]
  end
end
