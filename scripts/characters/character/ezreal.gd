extends BaseCharacter 
class_name Ezreal

func _init() -> void:
	var health = 500
	var max_health = 500
	var mana = 300
	var max_mana = 300
	var health_regen = 2
	var mana_regen = 5
	var move_speed = 300
	var character = Character.CHARACTERS.EZREAL
	var _character_attributes = CharacterAttributes.new(
		health, max_health, mana, max_mana, health_regen, mana_regen, move_speed, character
	)
	super._init(_character_attributes)
