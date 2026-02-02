extends CharacterBody2D

var move_to_location : Vector2
var move_direction : Vector2
const stop_moving_vector := Vector2(0,0)

# character
var character : BaseCharacter

# character animations
var animated_sprite_2d : AnimatedSprite2D
@onready var character_animations: CharacterAnimations = $CharacterAnimations

func _ready() -> void:
	character = Ezreal.new()
	animated_sprite_2d = character_animations.get_animations(character.character_attributes.character)


func _physics_process(_delta: float) -> void:
	process_movement()
	process_skills()
	
	if position.distance_to(move_to_location) > 10:
		move_and_slide()
	else:
		set_character_to_idle()


################################################
### PLAYER SKILLS
################################################
func process_skills() -> void:
	if Input.is_action_just_pressed("q"):
		pass
	if Input.is_action_just_pressed("w"):
		pass
	if Input.is_action_just_pressed("e"):
		pass
	if Input.is_action_just_pressed("r"):
		pass


################################################
### PLAYER MOVEMENT
################################################
func process_movement() -> void:
	# move command
	if Input.is_action_just_pressed("move_to_spot"):
		move_to_location = get_global_mouse_position()
		handle_move_character()
		velocity = global_position.direction_to(move_to_location) * CharacterUtils.get_move_speed(character)
	# stop command
	if Input.is_action_pressed("s"):
		set_character_to_idle()
		move_to_location = position


func set_character_to_idle() -> void:
	var animation_metadata = character.get_idle_animation_metadata(get_movement_direction())
	if animated_sprite_2d != null && animation_metadata:
		animated_sprite_2d.animation = animation_metadata.get_animation_name()
		animated_sprite_2d.flip_h = animation_metadata.get_should_flip_h()
 

func handle_move_character() -> void:
	move_direction = position.direction_to(move_to_location)
	var animation_metadata = character.get_moving_animation_metadata(get_movement_direction())
	if animated_sprite_2d != null && animation_metadata:
		animated_sprite_2d.animation = animation_metadata.get_animation_name()
		animated_sprite_2d.flip_h = animation_metadata.get_should_flip_h()


func get_movement_direction() -> MovemenConstants.MOVE_DIRECTION:
	if abs(move_direction.x) > abs(move_direction.y):
		# move left
		if move_direction.x < 0:
			return MovemenConstants.MOVE_DIRECTION.LEFT
		# move right
		elif move_direction.x > 0:
			return MovemenConstants.MOVE_DIRECTION.RIGHT
	else:
		# move up
		if move_direction.y < 0:
			return MovemenConstants.MOVE_DIRECTION.UP
		# move down
		elif move_direction.y > 0:
			return MovemenConstants.MOVE_DIRECTION.DOWN
	return MovemenConstants.MOVE_DIRECTION.UNKNOWN
	
