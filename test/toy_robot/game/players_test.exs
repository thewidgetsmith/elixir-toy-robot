defmodule ToyRobot.Game.PlayersTest do
  use ExUnit.Case, async: true

  alias ToyRobot.Table
  alias ToyRobot.Game.Players

  describe "available positions" do
    setup do
      table = %Table{
        x_boundary: 1,
        y_boundary: 1,
      }

      {:ok, table: table}
    end

    test "does not include the occupied positions", %{table: table} do
      occupied_positions = [%{lcn_x: 0, lcn_y: 0}]

      available_positions = Players.available_positions(
        occupied_positions,
        table
      )

      assert occupied_positions not in available_positions
    end
  end

  describe "change_position_if_occupied" do
    setup do
      table = %Table{
        x_boundary: 1,
        y_boundary: 1,
      }

      {:ok, table: table}
    end

    test "changes position if it is occupied", %{table: table} do
      occupied_positions = [%{lcn_x: 0, lcn_y: 0}]
      original_position = %{lcn_x: 0, lcn_y: 0, yaw: :north}

      new_position = Players.change_position_if_occupied(
        occupied_positions,
        table,
        original_position
      )

      assert new_position != original_position
      assert new_position.yaw == original_position.yaw
    end

    test "does not change position if it is not occupied", %{table: table} do
      occupied_positions = []
      original_position = %{lcn_x: 0, lcn_y: 0, yaw: :north}

      assert Players.change_position_if_occupied(
        occupied_positions,
        table,
        original_position
      ) == original_position
    end
  end
end
