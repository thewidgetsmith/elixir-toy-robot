defmodule ToyRobot.Game.PlayerSupervisor do
  use DynamicSupervisor

  alias ToyRobot.Game.Player

  def init(_args) do
    Registry.start_link(keys: :unique, name: ToyRobot.Game.PlayerRegistry)
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(robot, name) do
    DynamicSupervisor.start_child(__MODULE__, {Player, [robot: robot, name: name]})
  end

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def report(name) do
    name |> Player.process_name |> Player.report
  end

  def move(name) do
    name |> Player.process_name |> Player.move
  end
end
