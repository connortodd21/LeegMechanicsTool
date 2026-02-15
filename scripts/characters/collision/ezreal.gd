@tool
extends Node2D

@onready var preview = $PreviewVisual

func _ready():
	if not Engine.is_editor_hint():
		preview.visible = false
