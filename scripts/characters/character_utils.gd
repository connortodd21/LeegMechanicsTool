class_name CharacterUtils

static func get_health(character: BaseCharacter) -> float:
	return character.character_metadata.health

static func get_max_health(character: BaseCharacter) -> float:
	return character.character_metadata.max_health

static func get_mana(character: BaseCharacter) -> float:
	return character.character_metadata.mana

static func get_max_mana(character: BaseCharacter) -> float:
	return character.character_metadata.max_mana

static func get_health_regen(character: BaseCharacter) -> float:
	return character.character_metadata.health_regen

static func get_mana_regen(character: BaseCharacter) -> float:
	return character.character_metadata.mana_regen

static func get_move_speed(character: BaseCharacter) -> float:
	return character.character_metadata.move_speed
