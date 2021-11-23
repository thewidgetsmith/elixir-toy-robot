defmodule ToyRobot.Game.PlayerSupervisor do
  use DynamicSupervisor

  alias ToyRobot.Game.Player

  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(registry_id, table, position, name) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {
        Player,
        [
          registry_id: registry_id,
          table: table,
          position: position,
          name: name
        ]
      }
    )
  end

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end
end
