class_name BaseCharacter extends Node

var character_metadata: CharacterMetadata

const Q = "Q"
const W = "W"
const E = "E"
const R = "R"
var ability_cooldowns := {}
var summoner_spell_cooldowns := {}

func _init(character_data : CharacterData) -> void:
	character_metadata = CharacterMetadata.new(
		character_data.max_health,
		character_data.max_health,
		character_data.max_mana,
		character_data.max_mana,
		character_data.health_regen,
		character_data.mana_regen,
		character_data.move_speed,
		character_data.character
	)


################################################
### SUMMONER SPELL ATTRIBUTES
################################################
func get_summoner_spell_cooldown(summoner_spell: SummonerSpellDataResource) -> float:
	if summoner_spell in summoner_spell_cooldowns.keys():
		return summoner_spell_cooldowns[summoner_spell]
	return -1


func set_summoner_spell_cooldown(summoner_spell: SummonerSpellDataResource) -> void:
	summoner_spell_cooldowns[summoner_spell] = summoner_spell.cooldown


func tick_summoner_spell_cooldowns(delta: float) -> void:
	for summoner_spell in summoner_spell_cooldowns.keys():
		if summoner_spell_cooldowns[summoner_spell] >= 0:
			summoner_spell_cooldowns[summoner_spell] -= delta


################################################
### ABILITY ATTRIBUTES
################################################
func get_cooldown(ability: AbilityResource) -> float:
	if ability in ability_cooldowns.keys():
		return ability_cooldowns[ability]
	return -1


func set_cooldown(ability: AbilityResource) -> void:
	ability_cooldowns[ability] = ability.cooldown


func tick_cooldowns(delta: float) -> void:
	for ability in ability_cooldowns.keys():
		if ability_cooldowns[ability] >= 0:
			ability_cooldowns[ability] -= delta

################################################
### PLAYER METADATA
################################################
func regen(delta: float) -> void:
	character_metadata.health = clamp(character_metadata.health + character_metadata.health_regen * delta, character_metadata.health, character_metadata.max_health)
	character_metadata.mana = clamp(character_metadata.mana + character_metadata.mana_regen * delta, character_metadata.mana, character_metadata.max_mana)

func increase_mana(mana_amount: float) -> void:
	clampf(character_metadata.mana + mana_amount, character_metadata.mana, character_metadata.max_mana)

func heal(heal_amount: float) -> void:
	character_metadata.health = clamp(character_metadata.health + heal_amount, character_metadata.health, character_metadata.max_health)

func increase_move_speed(speed_amount: float) -> void:
	character_metadata.move_speed += speed_amount

################################################
### PLAYER ANIMATION METADATA
################################################
func get_idle_animation_metadata(direction: MovementConstants.MOVE_DIRECTION) -> PlayerAnimationMetadata:
	var idle = MovementConstants.IDLE
	
	match direction:
		MovementConstants.MOVE_DIRECTION.LEFT:
			return PlayerAnimationMetadata.new(idle + "_side", true)
		MovementConstants.MOVE_DIRECTION.RIGHT:
			return PlayerAnimationMetadata.new(idle + "_side", false)
		MovementConstants.MOVE_DIRECTION.UP:
			return PlayerAnimationMetadata.new(idle + "_back", false)
		MovementConstants.MOVE_DIRECTION.DOWN:
			return PlayerAnimationMetadata.new(idle + "_front", false)
		_:
			return PlayerAnimationMetadata.new("", false)


func get_moving_animation_metadata(direction: MovementConstants.MOVE_DIRECTION) -> PlayerAnimationMetadata:
	var moving = MovementConstants.MOVING
	
	match direction:
		MovementConstants.MOVE_DIRECTION.LEFT:
			return PlayerAnimationMetadata.new(moving + "_side", true)
		MovementConstants.MOVE_DIRECTION.RIGHT:
			return PlayerAnimationMetadata.new(moving + "_side", false)
		MovementConstants.MOVE_DIRECTION.UP:
			return PlayerAnimationMetadata.new(moving + "_back", false)
		MovementConstants.MOVE_DIRECTION.DOWN:
			return PlayerAnimationMetadata.new(moving + "_front", false)
		_:
			return PlayerAnimationMetadata.new("", false)


func get_attack_animation_metadata() -> void:
	pass
