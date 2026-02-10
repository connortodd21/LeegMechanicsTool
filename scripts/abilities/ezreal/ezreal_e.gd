extends Node2D

var caster: Node2D

var damage: float
var direction: Vector2
var speed: float = 900

var max_distance: float = 300
var start_position: Vector2
var target_position: Vector2
	
func _initialize(_caster: CharacterBody2D, ability_cast_metadata: AbilityCastMetadata) -> void:
	caster = _caster
	start_position = caster.global_position

	var endpoint = ability_cast_metadata.get_mouse_position()
	var blink_direction = ability_cast_metadata.get_mouse_direction().normalized()
	var distance = clampf(endpoint.distance_to(start_position), 0, max_distance) * blink_direction
	var blink_position = caster.global_position + distance

	# blink
	caster.global_position = blink_position
	
	spawn_bolt()

	caster.stop_movement()

	queue_free()


func spawn_bolt() -> void:
	pass


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
