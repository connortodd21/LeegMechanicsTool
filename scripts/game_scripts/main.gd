extends Node2D

@onready var player: CharacterBody2D = $Player

# Characters
@export var available_champions: Array[CharacterConfigResource]

# Summoner spells
@export var available_summoners: Array[SummonerSpellDataResource]

# Shared assets
@export var click_move_effect_scene: PackedScene


func _ready() -> void:
	var selected_champion = get_selected_champion()
	start_game(selected_champion)


################################################
### CHAMPION SELECTION
################################################
func get_selected_champion() -> CharacterConfigResource:
	if available_champions.is_empty():
		push_error("No champions assigned to Main!")
		return null

	# TODO, we need to get index based off input
	return available_champions[0]


func get_summoner_spells() -> SummonerSpellLoadoutResource:
	var summoner_spells = SummonerSpellLoadoutResource.new()
	summoner_spells.slot1 = available_summoners[0]
	summoner_spells.slot2 = available_summoners[1]
	return summoner_spells


################################################
### GAME START
################################################
func start_game(character_config: CharacterConfigResource) -> void:
	if character_config == null:
		push_error("Champion is null.")
		return

	
	player.initialize(character_config, get_summoner_spells())


################################################ 
### EFFECTS
################################################
func spawn_click_effect(click_position: Vector2, color: Color = Color.DARK_GREEN) -> void:
	var effect = click_move_effect_scene.instantiate()
	effect.global_position = click_position
	effect.color = color
	get_tree().current_scene.add_child(effect)
