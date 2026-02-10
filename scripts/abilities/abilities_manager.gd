extends Node2D

func cast(ability: AbilityResource, caster: Node2D, ability_cast_metadata: AbilityCastMetadata):
	var instance = ability.scene.instantiate()
	if instance.has_method("_initialize"):
		add_child(instance)
		instance._initialize(caster, ability_cast_metadata)
	else:
		instance.queue_free()
