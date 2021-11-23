defmodule ToyRobot.Game.PlayerTest do
  use ExUnit.Case, async: true

  alias ToyRobot.Game.Player
  alias ToyRobot.{Robot, Table}

  def build_table do
    %Table{
      x_boundary: 4,
      y_boundary: 4
    }
  end

  describe "init" do
    setup do
      registry_id = :player_init_test
      Registry.start_link(keys: :unique, name: registry_id)

      {:ok, registry_id: registry_id}
    end

    test "maintains the original position", %{registry_id: registry_id} do
      position = %{lcn_x: 0, lcn_y: 0, yaw: :north}

      {:ok, %{robot: robot}} =
        Player.init([
          registry_id: registry_id,
          table: build_table(),
          position: position,
          name: Player.process_name(registry_id, "CL4PTRP")
        ])

        assert robot.lcn_x == 0
        assert robot.lcn_y == 0
        assert robot.yaw == :north
    end
  end

  describe "init, with another player registered" do
    setup do
      registry_id = :player_init_test
      Registry.start_link(keys: :unique, name: registry_id)

      table = build_table()

      Player.start_link(
        registry_id: registry_id,
        table: table,
        position: %{lcn_x: 0, lcn_y: 0, yaw: :west},
        name: "HAL"
      )

      {:ok, registry_id: registry_id, table: table}
    end

    test "picks a random position on the board", %{registry_id: registry_id, table: table} do
      position= %{lcn_x: 0, lcn_y: 0, yaw: :north}

      {:ok, %{robot: robot}} =
        Player.init([
          registry_id: registry_id,
          table: table,
          position: position,
          name: Player.process_name(registry_id, "Bobbie")
        ])

      refute match?(%{north: 0, east: 0}, robot)
      assert robot.yaw == :north
    end
  end

  describe "report command" do
    setup do
      start_position = %{lcn_x: 0, lcn_y: 0, yaw: :north}
      {:ok, player} = Player.start(build_table(), start_position)
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

  describe "move command" do
    setup do
      start_position = %{lcn_x: 0, lcn_y: 0, yaw: :north}
      {:ok, player} = Player.start(build_table(), start_position)
      %{player: player}
    end

    test "moves the robot forward one unit", %{player: player} do
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
