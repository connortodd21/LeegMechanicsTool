class_name BaseCharacter

var character_attributes: CharacterAttributes

func _init(_character_attributes : CharacterAttributes) -> void:
	character_attributes = _character_attributes

################################################
### PLAYER ATTRIBUTES
################################################
func increase_health() -> void:
	clampf(character_attributes.health, character_attributes.health + character_attributes.health_regen, character_attributes.max_health)

func increase_mana() -> void:
	clampf(character_attributes.mana, character_attributes.mana + character_attributes.mana_regen, character_attributes.max_mana)

func heal(heal_amount: float) -> void:
	clampf(character_attributes.health, character_attributes.health + heal_amount, character_attributes.max_health)


################################################
### PLAYER SKILLS
################################################
func attack() -> void:
	pass

func use_q() -> void:
	pass

func use_w() -> void:
	pass

func use_e() -> void:
	pass

func use_r() -> void:
	pass
	
	
