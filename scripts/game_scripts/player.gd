extends CharacterBody2D

# signals
signal player_clicked

# character
var character : BaseCharacter
var character_data : CharacterData

# character animations
var animated_sprite_2d : AnimatedSprite2D
@onready var character_animations: Node2D = $CharacterAnimations

# character collision
@onready var character_collision_manager: Node2D = $CharacterCollisionManager

# abilities
var ability_loadout: AbilityLoadoutResource
@onready var ability_manager = $"AbilitiesManager"

# summoner spells
@onready var summoner_spell_manager = $SummonerSpellManager

# movement
var last_facing_direction := Vector2.DOWN # the last known direction the character is facing
var move_to_location : Vector2
const stop_moving_vector := Vector2(0,0)

# controller
var controller : BaseCharacterController


func set_controller(_controller: BaseCharacterController) -> void:
	controller = _controller
	controller.initialize(self)


func initialize(config: CharacterConfigResource, summoner_loadout: SummonerSpellLoadoutResource) -> void:
	character_data = config.character_data
	character = BaseCharacter.new(character_data)
	
	ability_loadout = config.ability_loadout
	
	if summoner_loadout:
		summoner_spell_manager.set_summoner_spells(summoner_loadout.slot1, summoner_loadout.slot2)
	
	setup_visuals(config)


func _physics_process(_delta: float) -> void:
	if character:
		controller.tick(_delta)
		character.tick_cooldowns(_delta)
		character.tick_summoner_spell_cooldowns(_delta)
		character.regen(_delta)
		
		if position.distance_to(move_to_location) > 10:
			move_and_slide()
			last_facing_direction =(move_to_location - position).normalized()
		else:
			set_character_to_idle(last_facing_direction)


################################################
### ABILITIES
################################################
func cast_ability(ability: AbilityResource) -> void:
	if ability != null:
		if character.get_cooldown(ability) <= 0:
			character.set_cooldown(ability)
			var ability_cast_metadata = get_ability_cast_metadata()
			last_facing_direction = ability_cast_metadata.get_mouse_direction().normalized()
			if ability.should_stop_movement:
				set_character_to_idle(last_facing_direction)
			ability_manager.cast(ability, self, ability_cast_metadata)


func cast_ability_at_position(ability: AbilityResource, target_position: Vector2) -> void:
	if ability != null:
		if character.get_cooldown(ability) <= 0:
			character.set_cooldown(ability)
			var direction = (target_position - global_position).normalized()
			var metadata = AbilityCastMetadata.new(target_position, direction)
			last_facing_direction = direction
			if ability.should_stop_movement:
				set_character_to_idle(last_facing_direction)
			ability_manager.cast(ability, self, metadata)


func cast_summoner_spell(summoner_spell: SummonerSpellDataResource) -> void:
	if summoner_spell != null:
		if character.get_summoner_spell_cooldown(summoner_spell) <= 0:
			character.set_summoner_spell_cooldown(summoner_spell)
			var summoner_spell_cast_metadata = get_summoner_spell_cast_metadata()
			summoner_spell_manager.cast(self, summoner_spell, summoner_spell_cast_metadata)


func get_summoner_spell_cast_metadata() -> SummonerCastMetadata:
	var mouse_position = get_global_mouse_position()
	var mouse_direction = MouseUtils.get_mouse_direction(mouse_position, global_position)
	return SummonerCastMetadata.new(mouse_position, mouse_direction)


func get_ability_cast_metadata() -> AbilityCastMetadata:
	var mouse_position = get_global_mouse_position()
	var mouse_direction = MouseUtils.get_mouse_direction(mouse_position, global_position)
	return AbilityCastMetadata.new(mouse_position, mouse_direction)

################################################ 
### MOVEMENT
################################################
func set_character_to_idle(facing_direction: Vector2 = Vector2.DOWN) -> void:
	var move_to_direction : MovementConstants.MOVE_DIRECTION
	# if character is moving
	if move_to_location != position:
		move_to_direction = MovementUtils.get_movement_direction(position.direction_to(move_to_location))
		move_to_location = position
	elif facing_direction != Vector2.ZERO:
		move_to_direction = MovementUtils.get_movement_direction(facing_direction)
	else:
		move_to_direction = MovementConstants.MOVE_DIRECTION.DOWN
	var animation_metadata = character.get_idle_animation_metadata(move_to_direction)
	update_animation(animation_metadata)
 

func handle_move_character() -> void:
	var move_direction = MovementUtils.get_movement_direction(position.direction_to(move_to_location))
	var animation_metadata = character.get_moving_animation_metadata(move_direction)
	update_animation(animation_metadata)


func update_animation(animation_metadata: PlayerAnimationMetadata) -> void:
	if animated_sprite_2d != null && animation_metadata:
		animated_sprite_2d.animation = animation_metadata.get_animation_name()
		animated_sprite_2d.flip_h = animation_metadata.get_should_flip_h()


func stop_movement() -> void:
	move_to_location = global_position
	velocity = Vector2.ZERO


################################################ 
### Character Animations
################################################
func setup_visuals(config: CharacterConfigResource) -> void:
	var animation_scene = config.character_animations.instantiate()
	character_animations.add_child(animation_scene)
	animated_sprite_2d = animation_scene.get_node("AnimatedSprite2D")


################################################ 
### Character Collision
################################################
func setup_collision(config: CharacterConfigResource) -> void:
	var collision = config.character_collision.instantiate()
	character_collision_manager.add_child(collision)
