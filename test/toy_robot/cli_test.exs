defmodule ToyRobot.CLITest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  test "handles commands and reports correctly" do
    commands_path = Path.expand("test/fixtures/commands.txt", File.cwd!())

    output =
      capture_io(fn ->
        ToyRobot.CLI.main([commands_path])
      end)

    expected_output = """
    The robot is at (0,4) facing NORTH
    """

    assert output |> String.trim() == expected_output |> String.trim()
  end

  test "handles new V2 commands and reports correctly" do
    commands_path = Path.expand("test/fixtures/commands_v2.txt", File.cwd!())

    output =
      capture_io(fn ->
        ToyRobot.CLI.main([commands_path])
      end)

    expected_output = """
    The robot is at (0,2) facing SOUTH
    """

    assert output |> String.trim() == expected_output |> String.trim()
  end

  test "provides usage instructions when no arguments are given" do
    output =
      capture_io(fn ->
        ToyRobot.CLI.main([])
      end)

    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "provides usage instructions when too many arguments are given" do
    output =
      capture_io(fn ->
        ToyRobot.CLI.main(["commands.txt", "commands2.txt"])
      end)

    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "provides usage instructions when the provided file path does not exist" do
    output =
      capture_io(fn ->
        ToyRobot.CLI.main(["does-not-exist.txt"])
      end)

    assert output |> String.trim() == "The file 'does-not-exist.txt' does not exist"
  end
end
