extends Node2D

func cast(ability: AbilityResource, _position: Vector2, _direction: Vector2):
	var instance = ability.scene.instantiate()
	if instance.has_method("_initialize"):
		add_child(instance)
		instance._initialize(_position, _direction)
	else:
		instance.queue_free()
