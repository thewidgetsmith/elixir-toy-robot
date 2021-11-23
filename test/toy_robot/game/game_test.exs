defmodule ToyRobot.Game.GameTest do
  use ExUnit.Case, async: true

  alias ToyRobot.Game

  setup do
    {:ok, game} = Game.start([x_boundary: 4, y_boundary: 4])
    {:ok, %{game: game}}
  end

  test "can place a player", %{game: game} do
    :ok = Game.place(game, %{lcn_x: 0, lcn_y: 0, yaw: :north}, "Foobar")
    assert Game.player_count(game) == 1
  end

  test "cannot place a robot out of bounds", %{game: game} do
    assert Game.place(game, %{lcn_x: 10, lcn_y: 10, yaw: :north}, "Wall-E") == {:error, :out_of_bounds}
  end

  test "cannot place a robot in the same space as another robot", %{game: game} do
    :ok = Game.place(
      game,
      %{lcn_x: 0, lcn_y: 0, yaw: :north},
      "Wall-E"
    )
    assert Game.place(
      game,
      %{lcn_x: 0, lcn_y: 0, yaw: :north},
      "Eve"
    ) == {:error, :occupied}
  end

  describe "move command" do
    test "cannot move a robot onto another robot's square", %{game: game} do
      :ok = Game.place(
        game,
        %{lcn_x: 0, lcn_y: 0, yaw: :north},
        "Marvin"
      )

      :ok = Game.place(
        game,
        %{lcn_x: 0, lcn_y: 1, yaw: :south},
        "Chappie"
      )

      assert Game.move(game, "Chappie") == {:error, :occupied}
    end

    test "can move onto an unoccupied square", %{game: game} do
      :ok = Game.place(
        game,
        %{lcn_x: 0, lcn_y: 0, yaw: :east},
        "Mr. Roboto"
      )

      :ok = Game.place(
        game,
        %{lcn_x: 0, lcn_y: 1, yaw: :south},
        "Kit"
      )

      assert Game.move(game, "Mr. Roboto") == :ok
    end
  end

  describe "respawning" do
    test "davros does not respawn on (1, 1)", %{game: game} do
      izzy_origin = %{lcn_x: 1, lcn_y: 0, yaw: :north}
      :ok = Game.place(game, izzy_origin, "Izzy")

      davros_origin = %{lcn_x: 1, lcn_y: 1, yaw: :west}
      :ok = Game.place(game, davros_origin, "Davros")
      :ok = Game.move(game, "Davros")
      :ok = Game.move(game, "Izzy")
      :ok = Game.move(game, "Davros")
      :timer.sleep(100)

      refute match?(%{lcn_x: 1, lcn_y: 1}, Game.report(game, "Davros"))
    end
  end
end
