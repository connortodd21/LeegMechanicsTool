extends Node2D

@onready var timer: Timer = $Timer

# summoner spell values
@export var duration : float
@export var speed_increase: float

var caster: Node2D
var original_velocity : Vector2


func _initialize(_caster: CharacterBody2D, _summoner_cast_metadata: SummonerCastMetadata) -> void:
	caster = _caster
	caster.character.increase_move_speed(speed_increase)
	timer.start(duration)


func _on_timer_timeout() -> void:
	caster.character.increase_move_speed(speed_increase * -1)
	queue_free()
