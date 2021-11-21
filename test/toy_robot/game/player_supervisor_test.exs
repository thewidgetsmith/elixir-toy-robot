defmodule ToyRobot.Game.PlayerSupervisorTest do
  use ExUnit.Case, async: true

  alias ToyRobot.{Game.PlayerSupervisor, Robot}

  test "starts a registry" do
    registry = Process.whereis(ToyRobot.Game.PlayerRegistry)
    assert registry
  end

  test "starts a player child process" do
    robot = %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
    {:ok, player} = PlayerSupervisor.start_child(robot, "Donna")

    [{registered_player, _}] = Registry.lookup(ToyRobot.Game.PlayerRegistry, "Donna")
    assert registered_player == player
  end

  test "reports a robot's location" do
    robot = %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
    {:ok, _player} = PlayerSupervisor.start_child(robot, "Jarvis")
    %{lcn_y: lcn_y} = PlayerSupervisor.report("Jarvis")

    assert lcn_y == 0
  end

  test "moves a robot forward" do
    robot = %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
    {:ok, _player} = PlayerSupervisor.start_child(robot, "Harvey")
    :ok = PlayerSupervisor.move("Harvey")
    %{lcn_y: lcn_y} = PlayerSupervisor.report("Harvey")

    assert lcn_y == 1
  end
end
