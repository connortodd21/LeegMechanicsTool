extends Resource
## Resource which contains ability metadata
##
## Each ability for a character should have an associated AbilityResource

class_name AbilityResource

# how much damage this ability does. Will be 0 for support or buffing abilities
@export var damage: float
# mana cost for ability. Will be 0 if champion does not use mana
@export var mana_cost: float
# ability cooldown. Measured in seconds
@export var cooldown: float
# Reference to the scene associated with this ability. The scene should contain the animation,
# logic, and any inner workings for this ability
@export var scene: PackedScene
# True if the character must stop when casting this ability. Default false
@export var should_stop_movement: bool
