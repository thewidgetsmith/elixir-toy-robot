# Toy Robot - Elixir version

The Toy Robot interview exercise implemented using Elixir.

## The Toy Robot Exercise

The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units. There are no other obstructions on the table surface. The robot is free to roam around the surface of the table. Any movement that would result in the robot falling from the table is prevented, however further valid movement commands are still allowed.

The application reads a file using a name passed in the command line, the following commands are valid:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- `PLACE` will put the toy robot on the table in position X,Y and facing NORTH SOUTH, EAST or WEST.
- The origin (0,0) is the SOUTH WEST most corner.
- All commands are ignored until a valid PLACE is made.
- `MOVE` will move the toy robot one unit forward in the direction it is currently facing.
- `LEFT` and `RIGHT` rotates the robot 90 degrees in the specified direction without changing the position of the robot.
- `REPORT` announces the X,Y and F of the robot.
- The file is assumed to have ASCII encoding. It is assumed that the `PLACE` command has only one space, that is `PLACE 1, 2, NORTH` is an invalid command.
- All commands must be in uppercase, all lower and mixed case commands will be ignored.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `toy_robot` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:toy_robot, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/toy_robot](https://hexdocs.pm/toy_robot).
