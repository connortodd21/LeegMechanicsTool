extends Resource
## Resource which contains references to abilities
##
## Each character should have one AbilityLoadout, which points to their respective
## q, w, e, and r AbilityResources

class_name AbilityLoadoutResource

# Ability Resource for q ability
@export var q: AbilityResource
# Ability Resource for w ability
@export var w: AbilityResource
# Ability Resource for e ability
@export var e: AbilityResource
# Ability Resource for r ability
@export var r: AbilityResource
