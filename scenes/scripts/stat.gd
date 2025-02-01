extends TextureProgressBar
class_name statParent

#UNITS PER SEC
@export var degration: float = 1:
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
