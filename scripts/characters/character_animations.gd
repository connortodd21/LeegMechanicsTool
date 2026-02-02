extends Node

class_name CharacterAnimations

@onready var ezreal: AnimatedSprite2D = $Ezreal

func get_animations(character: Character.CHARACTERS) -> AnimatedSprite2D:
	match character:
		Character.CHARACTERS.EZREAL:
			return ezreal
	return null
