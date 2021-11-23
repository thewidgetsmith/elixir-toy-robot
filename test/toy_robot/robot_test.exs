defmodule ToyRobot.RobotTest do
  use ExUnit.Case
  doctest ToyRobot.Robot
  alias ToyRobot.Robot

  describe "when the robot is facing north" do
    setup do
      {:ok, %{robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :north}}}
    end

    test "it moves one space north", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.lcn_y == 1
    end

    test "turns left to face west", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.yaw == :west
    end

    test "turns right to face east", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.yaw == :east
    end

    test "turns around to face south", %{robot: robot} do
      robot = robot |> Robot.turn_around()
      assert robot.yaw == :south
    end
  end

  describe "when the robot is facing south" do
    setup do
      {:ok, %{robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :south}}}
    end

    test "it moves one space south", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.lcn_y == -1
    end

    test "turns left to face east", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.yaw == :east
    end

    test "turns right to face west", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.yaw == :west
    end

    test "turns around to face north", %{robot: robot} do
      robot = robot |> Robot.turn_around()
      assert robot.yaw == :north
    end
  end

  describe "when the robot is facing east" do
    setup do
      {:ok, %{robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :east}}}
    end

    test "it moves one space east", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.lcn_x == 1
    end

    test "turns left to face north", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.yaw == :north
    end

    test "turns right to face south", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.yaw == :south
    end

    test "turns around to face west", %{robot: robot} do
      robot = robot |> Robot.turn_around()
      assert robot.yaw == :west
    end
  end

  describe "when the robot is facing west" do
    setup do
      {:ok, %{robot: %Robot{lcn_x: 0, lcn_y: 0, yaw: :west}}}
    end

    test "it moves one space west", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.lcn_x == -1
    end

    test "turns left to face south", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.yaw == :south
    end

    test "turns right to face north", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.yaw == :north
    end

    test "turns around to face east", %{robot: robot} do
      robot = robot |> Robot.turn_around()
      assert robot.yaw == :east
    end
  end

  # Regression test to ensure that robot location
  # is not being reset upon turning right or left.
  describe "when the robot is facing north and has moved forward one space" do
    setup do
      {:ok, %{robot: %Robot{lcn_y: 1, yaw: :north}}}
    end

    test "maintains location and turns right to face east", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.yaw == :east
      assert robot.lcn_y == 1
    end

    test "maintains location and turns left to face west", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.yaw == :west
      assert robot.lcn_y == 1
    end
  end

  # Regression test to ensure that robot location
  # is not being reset upon subsequent calls to move().
  describe "when the robot is facing east and has moved north one space" do
    setup do
      {:ok, %{robot: %Robot{lcn_y: 1, yaw: :east}}}
    end

    test "maintains lcn_y position and moves east one space", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.lcn_x == 1
      assert robot.lcn_y == 1
      assert robot.yaw == :east
    end
  end

  # Regression test to ensure that robot location
  # is not being reset upon subsequent calls to move().
  describe "when the robot is facing west and has moved north one space" do
    setup do
      {:ok, %{robot: %Robot{lcn_y: 1, yaw: :west}}}
    end

    test "maintains lcn_y position and moves west one space", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.lcn_x == -1
      assert robot.lcn_y == 1
      assert robot.yaw == :west
    end
  end

  # Regression test to ensure that robot location
  # is not being reset upon subsequent calls to move().
  describe "when the robot is facing north and has moved east one space" do
    setup do
      {:ok, %{robot: %Robot{lcn_x: 1, yaw: :north}}}
    end

    test "maintains lcn_x position and moves north one space", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.lcn_x == 1
      assert robot.lcn_y == 1
      assert robot.yaw == :north
    end
  end

  # Regression test to ensure that robot location
  # is not being reset upon subsequent calls to move().
  describe "when the robot is facing south and has moved east one space" do
    setup do
      {:ok, %{robot: %Robot{lcn_x: 1, yaw: :south}}}
    end

    test "maintains lcn_x position and moves south one space", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.lcn_x == 1
      assert robot.lcn_y == -1
      assert robot.yaw == :south
    end
  end
end
