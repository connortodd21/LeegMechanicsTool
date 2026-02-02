class_name CharacterUtils

static func get_health(character: BaseCharacter) -> float:
	return character.character_attributes.health

static func get_max_health(character: BaseCharacter) -> float:
	return character.character_attributes.max_health

static func get_mana(character: BaseCharacter) -> float:
	return character.character_attributes.mana

static func get_max_mana(character: BaseCharacter) -> float:
	return character.character_attributes.max_mana

static func get_health_regen(character: BaseCharacter) -> float:
	return character.character_attributes.health_regen

static func get_mana_regen(character: BaseCharacter) -> float:
	return character.character_attributes.mana_regen

static func get_move_speed(character: BaseCharacter) -> float:
	return character.character_attributes.move_speed
