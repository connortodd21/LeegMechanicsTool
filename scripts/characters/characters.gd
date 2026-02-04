extends Node

class_name Character

static var INVALID := "INVALID"

static var character_to_name = {
	CHARACTERS.EZREAL: "ezreal"
}

enum CHARACTERS {
	EZREAL,
	UNKNOWN 
}

static func get_character_name(character: CHARACTERS) -> String:
	match character:
		CHARACTERS.EZREAL:
			return character_to_name[CHARACTERS.EZREAL]
		CHARACTERS.UNKNOWN:
			return "Unknown"
		_:
			return "Invalid"
