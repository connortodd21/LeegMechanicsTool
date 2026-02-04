extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var color: Color = Color.DARK_GREEN

var animation_length := 0.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.modulate = color
	scale = Vector2.ONE * 0.1
	modulate.a = 1.0
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "scale", Vector2.ONE * 2.0, animation_length)
	tween.parallel().tween_property(self, "modulate:a", 0.0, animation_length)
	tween.tween_callback(queue_free)
