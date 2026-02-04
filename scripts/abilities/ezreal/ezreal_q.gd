extends Node2D

var damage: float
var direction: Vector2
var speed: float = 900

var max_distance: float = 300
var start_position: Vector2
	
func initialize(_position: Vector2, _direction: Vector2) -> void:
	global_position = _position
	start_position = _position
	direction = _direction.normalized()

func _process(delta):
	position += direction * speed * delta
	
	# Check if max distance has been reached. if so skillshot is over
	if position.distance_to(start_position) >= max_distance:
		queue_free() 

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
