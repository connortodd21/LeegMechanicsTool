extends CharacterBody2D

var move_to_location : Vector2
const stop_moving_vector := Vector2(0,0)

# character
var character : BaseCharacter

# character animations
var animated_sprite_2d : AnimatedSprite2D
@onready var character_animations: CharacterAnimations = $CharacterAnimations

# abilities
@export var ability_loadout: AbilityLoadout
@onready var ability_manager = $"../AbilitiesManager"

# effects
@export var click_move_effect_scene: PackedScene

func _ready() -> void:
	character = Ezreal.new()
	animated_sprite_2d = character_animations.get_animations(character.character_attributes.character)
	load_character_skills()

func _physics_process(_delta: float) -> void:
	process_movement()
	process_skills()
	character.tick_cooldowns(_delta)
	
	if position.distance_to(move_to_location) > 10:
		move_and_slide()
	else:
		set_character_to_idle()


################################################
### MOUSE DATA
################################################
func get_mouse_direction() -> Vector2:
	var mouse_pos = get_global_mouse_position()   # mouse position in world
	var dir = mouse_pos - global_position        # vector from player to mouse
	return dir.normalized()  


################################################
### PLAYER SKILLS
################################################
func load_character_skills() -> void:
	var character_name = Character.get_character_name(character.character_attributes.character)
	if character_name != Character.INVALID:
		var character_resource_path = "res://resources/ability_loadouts/%s/loadout.tres" % character_name
		ability_loadout = load(character_resource_path)

func process_skills() -> void:
	if ability_loadout != null:
		if Input.is_action_just_pressed("q"):
			cast_ability(ability_loadout.q)
		if Input.is_action_just_pressed("w"):
			pass
		if Input.is_action_just_pressed("e"):
			pass
		if Input.is_action_just_pressed("r"):
			pass

func cast_ability(ability: AbilityResource) -> void:
	if ability != null:
		if character.get_cooldown(ability) <= 0:
			character.set_cooldown(ability)
			if ability.should_stop_movement:
				set_character_to_idle()
			ability_manager.cast(ability, position, get_mouse_direction())

################################################ 
### PLAYER MOVEMENT
################################################
func process_movement() -> void:
	# move command
	if Input.is_action_just_pressed("move_to_spot"):
		move_to_location = get_global_mouse_position()
		velocity = global_position.direction_to(move_to_location) * CharacterUtils.get_move_speed(character)
		spawn_click_effect(move_to_location)
		handle_move_character()
	# stop command
	if Input.is_action_pressed("s"):
		set_character_to_idle()
		move_to_location = position


func set_character_to_idle() -> void:
	if move_to_location != position:
		var move_direction = MovementUtils.get_movement_direction(position.direction_to(move_to_location))
		move_to_location = position
		var animation_metadata = character.get_idle_animation_metadata(move_direction)
		update_animation(animation_metadata)
 

func handle_move_character() -> void:
	var move_direction = MovementUtils.get_movement_direction(position.direction_to(move_to_location))
	var animation_metadata = character.get_moving_animation_metadata(move_direction)
	update_animation(animation_metadata)


func update_animation(animation_metadata: PlayerAnimationMetadata) -> void:
	if animated_sprite_2d != null && animation_metadata:
		animated_sprite_2d.animation = animation_metadata.get_animation_name()
		animated_sprite_2d.flip_h = animation_metadata.get_should_flip_h()

################################################ 
### EFFECTS
################################################
func spawn_click_effect(click_position: Vector2, color: Color = Color.DARK_GREEN) -> void:
	var effect = click_move_effect_scene.instantiate()
	effect.global_position = click_position
	effect.color = color
	get_tree().current_scene.add_child(effect)
