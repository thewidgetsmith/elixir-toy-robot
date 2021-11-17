defmodule ToyRobot.CommandRunnerTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  alias ToyRobot.{CommandRunner, Simulation}

  test "handles a valid place command" do
    %Simulation{robot: robot} = CommandRunner.run([
      {
        :place,
        %{lcn_x: 1, lcn_y: 2, yaw: :north}
      }
    ])

    assert robot.lcn_x == 1
    assert robot.lcn_y == 2
    assert robot.yaw == :north
  end

  test "handles an invalid place command" do
    simulation = CommandRunner.run([{:place, %{lcn_x: 10, lcn_y: 10, yaw: :north}}])

    assert simulation == nil
  end

  test "ignores commands until a valid placement" do
    %Simulation{robot: robot} = [
      :move,
      {:place, %{lcn_x: 1, lcn_y: 2, yaw: :north}},
    ] |> CommandRunner.run

    assert robot.lcn_x == 1
    assert robot.lcn_y == 2
    assert robot.yaw == :north
  end

  test "handles a place + move command" do
    %Simulation{robot: robot} = [
      {:place, %{lcn_x: 1, lcn_y: 2, yaw: :north}},
      :move
    ] |> CommandRunner.run

    assert robot.lcn_x == 1
    assert robot.lcn_y == 3
    assert robot.yaw == :north
  end

  test "handles a place + invalid move command" do
    %Simulation{robot: robot} = [
      {:place, %{lcn_x: 1, lcn_y: 4, yaw: :north}},
      :move
    ] |> CommandRunner.run

    assert robot.lcn_x == 1
    assert robot.lcn_y == 4
    assert robot.yaw == :north
  end

  test "handles a place + turn_left command" do
    %Simulation{robot: robot} = [
      {:place, %{lcn_x: 1, lcn_y: 2, yaw: :north}},
      :turn_left
    ] |> CommandRunner.run

    assert robot.lcn_x == 1
    assert robot.lcn_y == 2
    assert robot.yaw == :west
  end

  test "handles a place + turn_right command" do
    %Simulation{robot: robot} = [
      {:place, %{lcn_x: 1, lcn_y: 2, yaw: :north}},
      :turn_right
    ] |> CommandRunner.run

    assert robot.lcn_x == 1
    assert robot.lcn_y == 2
    assert robot.yaw == :east
  end

  test "handles a place + report command" do
    commands = [
      {:place, %{lcn_x: 1, lcn_y: 2, yaw: :north}},
      :report
    ]

    output = capture_io fn ->
      CommandRunner.run(commands)
    end

    assert output |> String.trim == "The robot is at (1,2) facing NORTH"
  end

  test "handles a place + invalid command" do
    %Simulation{robot: robot} = [
      {:place, %{lcn_x: 1, lcn_y: 2, yaw: :north}},
      {:invalid, "EXTERMINATE"}
    ] |> CommandRunner.run

    assert robot.lcn_x == 1
    assert robot.lcn_y == 2
    assert robot.yaw == :north
  end
end
