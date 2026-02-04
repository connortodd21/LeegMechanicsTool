extends Resource
class_name CharacterData

@export var character : Character.CHARACTERS

# base stats
@export var max_health : float
@export var max_mana : float
@export var health_regen : float
@export var mana_regen : float
@export var move_speed : float

# abilities and animations
@export var ability_loadout : AbilityLoadoutResource
@export var animations_scene : PackedScene
