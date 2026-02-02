class_name MovementUtils

static func get_movement_direction(move_direction: Vector2) -> MovementConstants.MOVE_DIRECTION:
	if abs(move_direction.x) > abs(move_direction.y):
		# move left
		if move_direction.x < 0:
			return MovementConstants.MOVE_DIRECTION.LEFT
		# move right
		elif move_direction.x > 0:
			return MovementConstants.MOVE_DIRECTION.RIGHT
	else:
		# move up
		if move_direction.y < 0:
			return MovementConstants.MOVE_DIRECTION.UP
		# move down
		elif move_direction.y > 0:
			return MovementConstants.MOVE_DIRECTION.DOWN
	return MovementConstants.MOVE_DIRECTION.UNKNOWN
