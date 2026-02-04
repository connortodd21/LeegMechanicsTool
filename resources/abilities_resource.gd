# ability_resource.gd
extends Resource
class_name AbilityResource

@export var damage: float
@export var mana_cost: float
@export var cooldown: float
@export var scene: PackedScene
@export var should_stop_movement: bool
