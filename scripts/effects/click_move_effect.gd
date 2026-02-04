extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var color: Color = Color.DARK_GREEN

const animation_scale := Vector2.ONE * 7.0
# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play()
	scale = animation_scale
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func _on_animation_finished():
	queue_free()
	
