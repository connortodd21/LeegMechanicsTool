class_name CharacterAttributes

var health : float
var max_health : float
var mana : float
var max_mana : float
var health_regen : float
var mana_regen : float 
var move_speed : float
var character : Character.CHARACTERS

func _init(_health: float, _max_health: float, _mana: float, _max_mana: float, _health_regen: float, _mana_regen: float, _move_speed: float, _character: Character.CHARACTERS) -> void:
	health = _health
	max_health = _max_health
	mana = _mana
	max_mana = _max_mana
	health_regen = _health_regen
	mana_regen = _mana_regen
	move_speed = _move_speed
	character = _character
