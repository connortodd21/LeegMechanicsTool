extends Node2D

var caster: Node2D

var damage: float
var direction: Vector2
var speed: float = 900

var max_distance: float = 300
var start_position: Vector2
	
func _initialize(_caster: Node2D, ability_cast_metadata: AbilityCastMetadata) -> void:
	caster = _caster
	global_position = caster.global_position
	start_position = caster.global_position
	direction = ability_cast_metadata.get_mouse_direction().normalized()

func _process(delta):
	position += direction * speed * delta
	
	# Check if max distance has been reached. if so skillshot is over
	if position.distance_to(start_position) >= max_distance:
		queue_free() 

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
