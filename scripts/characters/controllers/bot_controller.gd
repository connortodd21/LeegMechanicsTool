class_name BotController
extends BaseCharacterController

var target : Node

# tuning values (easy to tweak)
var preferred_distance := 350.0
var cast_range := 500.0
var reposition_threshold := 40.0

func set_target(node: Node) -> void:
	target = node

func initialize(p) -> void:
	super.initialize(p)


func tick(_delta: float) -> void:
	if not is_instance_valid(target):
		return

	handle_movement()
	cast_abilities()

################################################
# MOVEEMENT
################################################
func handle_movement() -> void:
	var direction = (player.global_position - target.global_position).normalized()
	var desired_position = target.global_position + direction * preferred_distance

	if player.global_position.distance_to(desired_position) > reposition_threshold:
		player.move_to_location = desired_position
		player.velocity = player.global_position.direction_to(desired_position) * CharacterUtils.get_move_speed(player.character)
		player.handle_move_character()

################################################
# ABILITIES
################################################
func cast_abilities() -> void:
	var ability = player.ability_loadout.q
	var distance = player.global_position.distance_to(target.global_position)
	if distance <= cast_range:
		player.cast_ability_at_position(ability, target.global_position)
