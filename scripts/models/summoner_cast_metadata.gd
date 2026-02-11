class_name SummonerCastMetadata

var mouse_position: Vector2
var mouse_direction: Vector2

func _init(_mouse_position: Vector2 = Vector2(), _mouse_direction: Vector2 = Vector2()):
	mouse_position = _mouse_position
	mouse_direction = _mouse_direction

func get_mouse_position() -> Vector2:
	return mouse_position

func get_mouse_direction() -> Vector2:
	return mouse_direction

func set_mouse_position(value: Vector2) -> void:
	mouse_position = value

func set_mouse_direction(value: Vector2) -> void:
	mouse_direction = value
