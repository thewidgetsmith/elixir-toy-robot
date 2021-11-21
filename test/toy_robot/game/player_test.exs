defmodule ToyRobot.Game.PlayerTest do
  use ExUnit.Case, async: true

  alias ToyRobot.Game.Player
  alias ToyRobot.Robot

  describe "report" do
    setup do
      starting_position = %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "shows the current position of the robot", %{player: player} do
      assert Player.report(player) == %Robot{
        lcn_x: 0,
        lcn_y: 0,
        yaw: :north
      }
    end
  end

  describe "move" do
    setup do
      starting_position = %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "moves the robot, shows the current position of the robot", %{player: player} do
      :ok = Player.move(player)
      robot = Player.report(player)
      assert robot == %Robot{
        lcn_x: 0,
        lcn_y: 1,
        yaw: :north
      }
    end
  end
end
