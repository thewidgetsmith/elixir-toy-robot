alias ToyRobot.Robot
%Robot{lcn_x: 0, lcn_y: 0, yaw: :north}
|> Robot.move
|> Robot.turn_right
|> Robot.move
|> Robot.turn_left
|> Robot.move
|> Robot.move
|> Robot.turn_left
|> Robot.move
|> Robot.turn_right
|> Robot.turn_right
|> Robot.move
|> Robot.move
|> Robot.move
|> IO.inspect
