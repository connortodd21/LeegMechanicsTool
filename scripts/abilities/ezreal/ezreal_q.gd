extends Node2D

var damage: float
var direction: Vector2
var speed: float = 900

var max_distance: float = 800
var start_position: Vector2

func _ready() -> void:
	start_position = global_position

func _process(delta):
	position += direction * speed * delta
	
	# Check if max distance has been reached. if so skillshot is over
	if global_position.distance_to(start_position) >= max_distance:
		queue_free() 

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
