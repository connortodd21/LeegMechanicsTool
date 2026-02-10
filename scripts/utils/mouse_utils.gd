class_name MouseUtils extends Node2D


static func get_mouse_direction(mouse_position: Vector2, position: Vector2) -> Vector2:
	var mouse_direction = mouse_position - position
	return mouse_direction.normalized()  
