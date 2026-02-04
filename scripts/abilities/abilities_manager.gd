extends Node2D

func cast(ability: AbilityResource, pos: Vector2, dir: Vector2):
	var instance = ability.scene.instantiate()
	add_child(instance)

	instance.global_position = pos
	instance.direction = dir.normalized()
	instance.damage = ability.damage
