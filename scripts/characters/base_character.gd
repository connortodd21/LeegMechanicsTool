class_name BaseCharacter extends Node

var character_attributes: CharacterAttributes

const Q = "Q"
const W = "W"
const E = "E"
const R = "R"
var ability_cooldowns := {}

func _init(_character_attributes : CharacterAttributes) -> void:
	character_attributes = _character_attributes


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
### PLAYER ATTRIBUTES
################################################
func increase_health() -> void:
	clampf(character_attributes.health, character_attributes.health + character_attributes.health_regen, character_attributes.max_health)

func increase_mana() -> void:
	clampf(character_attributes.mana, character_attributes.mana + character_attributes.mana_regen, character_attributes.max_mana)

func heal(heal_amount: float) -> void:
	clampf(character_attributes.health, character_attributes.health + heal_amount, character_attributes.max_health)


################################################
### PLAYER ANIMATIONS
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
