extends Node2D

enum SLOTS {
	ONE,
	TWO
}

var summoner_spells = {}


func cast(caster: Node2D, summoner_spell: SummonerSpellDataResource, summoner_cast_metadata: SummonerCastMetadata) -> void:
	var instance = summoner_spell.scene.instantiate()
	if instance.has_method("_initialize"):
		add_child(instance)
		instance._initialize(caster, summoner_cast_metadata)
	else:
		instance.queue_free()


func set_summoner_spells(spell_1: SummonerSpellDataResource, spell_2: SummonerSpellDataResource) -> void:
	summoner_spells[SLOTS.ONE] = spell_1
	summoner_spells[SLOTS.TWO] = spell_2

func get_first_summoner_spell() -> SummonerSpellDataResource:
	return summoner_spells[SLOTS.ONE]

func get_second_summoner_spell() -> SummonerSpellDataResource:
	return summoner_spells[SLOTS.TWO]
