class_name BaseCharacter extends Node

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
### PLAYER ANIMATIONS
################################################
func get_idle_animation_metadata(direction: MovemenConstants.MOVE_DIRECTION) -> PlayerAnimationMetadata:
	var idle = MovemenConstants.IDLE
	
	match direction:
		MovemenConstants.MOVE_DIRECTION.LEFT:
			return PlayerAnimationMetadata.new(idle + "_side", true)
		MovemenConstants.MOVE_DIRECTION.RIGHT:
			return PlayerAnimationMetadata.new(idle + "_side", false)
		MovemenConstants.MOVE_DIRECTION.UP:
			return PlayerAnimationMetadata.new(idle + "_back", false)
		MovemenConstants.MOVE_DIRECTION.DOWN:
			return PlayerAnimationMetadata.new(idle + "_front", false)
		_:
			return PlayerAnimationMetadata.new("", false)


func get_moving_animation_metadata(direction: MovemenConstants.MOVE_DIRECTION) -> PlayerAnimationMetadata:
	var moving = MovemenConstants.MOVING
	
	match direction:
		MovemenConstants.MOVE_DIRECTION.LEFT:
			return PlayerAnimationMetadata.new(moving + "_side", true)
		MovemenConstants.MOVE_DIRECTION.RIGHT:
			return PlayerAnimationMetadata.new(moving + "_side", false)
		MovemenConstants.MOVE_DIRECTION.UP:
			return PlayerAnimationMetadata.new(moving + "_back", false)
		MovemenConstants.MOVE_DIRECTION.DOWN:
			return PlayerAnimationMetadata.new(moving + "_front", false)
		_:
			return PlayerAnimationMetadata.new("", false)


func get_attack_animation_metadata() -> void:
	pass
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
	
	
