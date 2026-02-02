extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# animations
const MOVING = "moving"
const IDLE = "idle"
const ATTACK = "attack"

# movement
enum MOVE_DIRECTION {
	LEFT,
	RIGHT,
	UP,
	DOWN,
	UNKNOWN
}
var move_to_location : Vector2
var move_direction : Vector2
const stop_moving_vector := Vector2(0,0)

# character
var character : BaseCharacter

func _ready() -> void:
	character = Ezreal.new()

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
		handle_move_character(MOVING)
		velocity = global_position.direction_to(move_to_location) * CharacterUtils.get_move_speed(character)
	# stop command
	if Input.is_action_pressed("s"):
		set_character_to_idle()
		move_to_location = position


func set_character_to_idle() -> void:
	handle_move_character(IDLE)
 

func handle_move_character(animation_type: String) -> void:
	move_direction = position.direction_to(move_to_location)
	var movement_direction = get_movement_direction()
	# if we are moving more horizontally than vertically
	if movement_direction == MOVE_DIRECTION.LEFT:
		animated_sprite_2d.animation = animation_type + "_side"
		animated_sprite_2d.flip_h = true
	elif movement_direction == MOVE_DIRECTION.RIGHT:
		animated_sprite_2d.animation = animation_type + "_side"
		animated_sprite_2d.flip_h = false
	elif movement_direction == MOVE_DIRECTION.UP:
		animated_sprite_2d.animation = animation_type + "_back"
		animated_sprite_2d.flip_h = false
	elif movement_direction == MOVE_DIRECTION.DOWN:
		animated_sprite_2d.animation = animation_type + "_front"
		animated_sprite_2d.flip_h = false


func get_movement_direction() -> MOVE_DIRECTION:
	if abs(move_direction.x) > abs(move_direction.y):
		# move left
		if move_direction.x < 0:
			return MOVE_DIRECTION.LEFT
		# move right
		elif move_direction.x > 0:
			return MOVE_DIRECTION.RIGHT
	else:
		# move up
		if move_direction.y < 0:
			return MOVE_DIRECTION.UP
		# move down
		elif move_direction.y > 0:
			return MOVE_DIRECTION.DOWN
	return MOVE_DIRECTION.UNKNOWN
	
