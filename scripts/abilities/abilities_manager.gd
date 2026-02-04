extends Node2D

func cast(ability: AbilityResource, pos: Vector2, dir: Vector2):
	var instance = ability.scene.instantiate()
	if instance.has_method("_initialize"):
		add_child(instance)
		instance._initialize(pos, dir)
	else:
		instance.queue_free()
