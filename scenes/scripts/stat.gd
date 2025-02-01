extends TextureProgressBar
class_name statParent

@export var degration: float = 0.75:
	set(value):
		degration = value

@export var val: float = 100:
	set(s):
		val = s
		value = val

func _process(_delta: float) -> void:
	pass
	

func _on_degration_timer_timeout() -> void:
	val -= degration
