extends Node2D

var caster: Node2D

var damage: float
var direction: Vector2
var speed: float = 900

var max_distance: float = 300
var start_position: Vector2
var target_position: Vector2
	
func _initialize(_caster: CharacterBody2D, summoner_cast_metadata: SummonerCastMetadata) -> void:
	caster = _caster
	start_position = caster.global_position

	var endpoint = summoner_cast_metadata.get_mouse_position()
	var blink_direction = summoner_cast_metadata.get_mouse_direction().normalized()
	var distance = clampf(endpoint.distance_to(start_position), 0, max_distance) * blink_direction
	var blink_position = caster.global_position + distance

	# blink
	caster.global_position = blink_position

	caster.stop_movement()

	queue_free()
