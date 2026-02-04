extends Node2D

func cast(ability: AbilityResource, pos: Vector2, dir: Vector2):
	var instance = ability.scene.instantiate()
	add_child(instance)
	
	instance.initialize(pos, dir)
