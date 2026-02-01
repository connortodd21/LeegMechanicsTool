extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# animations
const MOVING = "moving"
const IDLE = "idle"
const ATTACK = "attack"

var speed = 300.0
const JUMP_VELOCITY = -400.0

var move_to_location : Vector2
var move_direction : Vector2
const stop_moving_vector := Vector2(0,0)

func _physics_process(_delta: float) -> void:
	process_movement()
	
	if position.distance_to(move_to_location) > 10:
		move_and_slide()
	else:
		set_character_to_idle()
		


func process_movement() -> void:
	if Input.is_action_just_pressed("move_to_spot"):
		move_to_location = get_global_mouse_position()
		update_character_facing_direction(MOVING)
		velocity = global_position.direction_to(move_to_location) * speed


func set_character_to_idle() -> void:
	update_character_facing_direction(IDLE)

func update_character_facing_direction(animation_type: String) -> void:
	move_direction = position.direction_to(move_to_location)
	# if we are moving more horizontally than vertically
	if abs(move_direction.x) > abs(move_direction.y):
		# move left
		if move_direction.x < 0:
			animated_sprite_2d.animation = animation_type + "_side"
			animated_sprite_2d.flip_h = true
		# move right
		elif move_direction.x > 0:
			animated_sprite_2d.animation = animation_type + "_side"
			animated_sprite_2d.flip_h = false
	else:
		# move up
		if move_direction.y < 0:
			animated_sprite_2d.animation = animation_type + "_back"
			animated_sprite_2d.flip_h = false
		# move down
		elif move_direction.y > 0:
			animated_sprite_2d.animation = animation_type + "_front"
			animated_sprite_2d.flip_h = false
	
