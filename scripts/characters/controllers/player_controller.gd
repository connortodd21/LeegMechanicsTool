class_name PlayerController
extends BaseCharacterController

func tick(delta: float):
	process_movement(delta)
	process_skills()


################################################ 
### PLAYER MOVEMENT
################################################
func process_movement(_delta: float) -> void:
	# move command
	if Input.is_action_just_pressed("move_to_spot"):
		player.move_to_location = player.get_global_mouse_position()
		player.velocity = player.global_position.direction_to(player.move_to_location) * CharacterUtils.get_move_speed(player.character) 
		player.player_clicked.emit(player.move_to_location)
		player.handle_move_character()
	# stop command
	if Input.is_action_pressed("s"):
		player.set_character_to_idle(player.last_facing_direction)
	# summoner spells
	if Input.is_action_just_pressed("summoner_1"):
		player.cast_summoner_spell(player.summoner_spell_manager.get_first_summoner_spell())
	if Input.is_action_just_pressed("summoner_2"):
		player.cast_summoner_spell(player.summoner_spell_manager.get_second_summoner_spell())


################################################ 
### PLAYER SKILLS
################################################
func process_skills() -> void:
	if player.ability_loadout != null:
		if Input.is_action_just_pressed("q"):
			player.cast_ability(player.ability_loadout.q)
		if Input.is_action_just_pressed("w"):
			player.cast_ability(player.ability_loadout.w)
		if Input.is_action_just_pressed("e"):
			player.cast_ability(player.ability_loadout.e)
		if Input.is_action_just_pressed("r"):
			pass
