class_name PlayerAnimationMetadata

var animation_name: String
var should_flip_h: bool


func _init(_animation_name: String = "", _should_flip_h: bool = false) -> void:
	animation_name = _animation_name
	should_flip_h = _should_flip_h

func get_animation_name() -> String:
	return animation_name

func get_should_flip_h() -> bool:
	return should_flip_h

func set_animation_name(value: String) -> void:
	animation_name = value

func set_should_flip_h(value: bool) -> void:
	should_flip_h = value
